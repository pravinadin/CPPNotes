# Classes Part 33 - Nested Classes in Modern C++

## Introduction to Nested Classes

Nested classes are classes defined inside another class or struct. They are a powerful feature in C++ that allows for improved encapsulation and organization of code that is logically associated with a specific class.

## Key Concepts

1. A nested class is defined within the scope of another class
2. Nested classes can access private members of the outer class only through an instance of the outer class
3. Nested classes have full access to all types defined in the enclosing class (including private ones)
4. The outer class does not have special access to the members of the nested class

## Basic Syntax

```cpp
class OuterClass {
private:
    int outerData;
    
public:
    class NestedClass {
    private:
        int nestedData;
        
    public:
        void nestedMethod() {
            // Can't access outerData directly
            // OuterClass::outerData; // Error!
        }
    };
    
    NestedClass createNested() {
        return NestedClass();
    }
};
```

## Accessing Nested Classes

Nested classes can be accessed using the scope resolution operator:

```cpp
// Creating an instance of the nested class
OuterClass::NestedClass nestedObj;

// Alternatively, through an instance of the outer class
OuterClass outerObj;
OuterClass::NestedClass nestedObj2 = outerObj.createNested();
```

## Practical Example: Iterator Pattern

One common use case for nested classes is implementing iterators:

```cpp
class Container {
private:
    int data[100];
    size_t size;
    
public:
    // Constructor
    Container() : size(0) {}
    
    void add(int value) {
        if (size < 100) {
            data[size++] = value;
        }
    }
    
    // Nested Iterator class
    class Iterator {
    private:
        const Container* container;
        size_t index;
        
    public:
        Iterator(const Container* container, size_t start)
            : container(container), index(start) {}
        
        bool hasNext() const {
            return index < container->size;
        }
        
        int next() {
            return container->data[index++];
        }
    };
    
    // Methods to create iterators
    Iterator begin() const {
        return Iterator(this, 0);
    }
    
    Iterator end() const {
        return Iterator(this, size);
    }
};

// Usage example
void iteratorExample() {
    Container c;
    c.add(1);
    c.add(2);
    c.add(3);
    
    Container::Iterator it = c.begin();
    while (it.hasNext()) {
        std::cout << it.next() << " ";
    }
    // Output: 1 2 3
}
```

## Private Nested Classes

Nested classes can be private, which restricts their visibility outside the outer class:

```cpp
class OuterClass {
private:
    class PrivateNestedClass {
    public:
        void doSomething() {}
    };
    
public:
    void usePrivateNested() {
        PrivateNestedClass nested;
        nested.doSomething();
    }
};

// Error - PrivateNestedClass is not accessible
// OuterClass::PrivateNestedClass obj;
```

## Using Nested Classes for Implementation Details

Nested classes are excellent for hiding implementation details:

```cpp
class GraphicsSystem {
private:
    // Private implementation details
    class Renderer {
    public:
        void renderTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
            // Implementation details
        }
    };
    
    class ShaderCompiler {
    public:
        void compile(const std::string& source) {
            // Implementation details
        }
    };
    
    Renderer renderer;
    ShaderCompiler compiler;
    
public:
    void drawTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
        renderer.renderTriangle(x1, y1, x2, y2, x3, y3);
    }
    
    void loadShader(const std::string& source) {
        compiler.compile(source);
    }
};

// Users only see the clean public interface
// GraphicsSystem::Renderer is inaccessible
```

## Type Definitions within Nested Classes

Nested classes can have their own type definitions:

```cpp
class Database {
public:
    class Query {
    public:
        enum Type { SELECT, INSERT, UPDATE, DELETE };
        
        Query(Type type) : queryType(type) {}
        
        Type getType() const { return queryType; }
        
    private:
        Type queryType;
    };
    
    void executeQuery(const Query& query) {
        switch(query.getType()) {
            case Query::SELECT: /* ... */ break;
            case Query::INSERT: /* ... */ break;
            case Query::UPDATE: /* ... */ break;
            case Query::DELETE: /* ... */ break;
        }
    }
};

// Usage
void databaseExample() {
    Database db;
    Database::Query selectQuery(Database::Query::SELECT);
    db.executeQuery(selectQuery);
}
```

## Static Members in Nested Classes

Nested classes can have static members:

```cpp
class Network {
public:
    class Packet {
    private:
        static size_t packetCount;
        int id;
        
    public:
        Packet() : id(packetCount++) {}
        
        int getId() const { return id; }
        
        static size_t getTotalPackets() {
            return packetCount;
        }
    };
    
    void sendPacket() {
        Packet p;
        // Send packet logic
    }
};

// Initialize static member
size_t Network::Packet::packetCount = 0;

// Usage
void networkExample() {
    Network net;
    net.sendPacket();
    net.sendPacket();
    
    std::cout << "Total packets: " << Network::Packet::getTotalPackets() << std::endl;
    // Output: Total packets: 2
}
```

## Forward Declarations for Nested Classes

Nested classes can be forward declared:

```cpp
class OuterClass {
    // Forward declaration
    class NestedClass;
    
    // Use the forward declaration
    NestedClass* createNested();
    
public:
    // Full definition later
    class NestedClass {
        // Implementation
    };
    
    NestedClass* createNested() {
        return new NestedClass();
    }
};
```

## Best Practices for Nested Classes

1. **Use for logical grouping**: Only nest classes that have a strong logical connection to the outer class
2. **Consider visibility carefully**: Make nested classes private if they're implementation details
3. **Avoid deeply nested classes**: Limit nesting to avoid complexity
4. **Use for specialized scopes**: Nested classes are great for types that only make sense within the context of the outer class
5. **Document relationships**: Clearly document the relationship between nested and outer classes

## Benefits of Nested Classes

1. **Enhanced encapsulation**: Hide implementation details
2. **Logical grouping**: Keep related types together
3. **Namespace management**: Avoid polluting the global namespace
4. **Clear dependencies**: Express that one class depends on another

## Conclusion

Nested classes in C++ provide a powerful mechanism for organizing code and enhancing encapsulation. They are particularly useful for implementing helper classes, iterators, and other components that are tightly coupled with a specific class. By understanding nested classes, C++ developers can create more maintainable and well-structured code.
