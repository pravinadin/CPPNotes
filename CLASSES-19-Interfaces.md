# Interfaces in C++ (Pure Virtual Functions)

## Introduction

In C++, interfaces are implemented using abstract classes with pure virtual functions. Unlike languages like Java or C# that have explicit `interface` keywords, C++ uses a design pattern with abstract classes to achieve similar functionality.

## What are Pure Virtual Functions?

A pure virtual function is a virtual function that has no implementation in the base class and must be overridden by any concrete (non-abstract) derived class. They are declared using the `= 0` syntax.

```cpp
virtual ReturnType functionName(Parameters) = 0;
```

## Abstract Classes vs. Interfaces

- **Abstract Class**: A class with at least one pure virtual function
- **Interface**: An abstract class where ALL functions are pure virtual (and typically has no member variables)

## Example: Basic Interface

```cpp
// Interface definition
class Printable {
public:
    virtual void print() const = 0;  // Pure virtual function
    virtual ~Printable() = default;  // Virtual destructor
};

// Concrete implementation
class Document : public Printable {
private:
    std::string content;
public:
    Document(const std::string& content) : content(content) {}
    
    // Implementation of the interface method
    void print() const override {
        std::cout << "Document contents: " << content << std::endl;
    }
};

// Usage
void printObject(const Printable& obj) {
    obj.print();  // Polymorphic call
}

int main() {
    Document doc("Hello, Interfaces!");
    printObject(doc);  // Prints: "Document contents: Hello, Interfaces!"
    return 0;
}
```

## Multiple Interface Implementation

C++ allows a class to implement multiple interfaces through multiple inheritance:

```cpp
class Serializable {
public:
    virtual std::string serialize() const = 0;
    virtual ~Serializable() = default;
};

class JsonDocument : public Printable, public Serializable {
private:
    std::string data;
public:
    JsonDocument(const std::string& data) : data(data) {}
    
    // Implement Printable interface
    void print() const override {
        std::cout << "JSON: " << data << std::endl;
    }
    
    // Implement Serializable interface
    std::string serialize() const override {
        return "{\"data\": \"" + data + "\"}";
    }
};
```

## Best Practices for C++ Interfaces

1. **Always include a virtual destructor** in interface classes
   ```cpp
   virtual ~InterfaceName() = default;
   ```

2. **Use `override` keyword** when implementing interface methods
   ```cpp
   void someMethod() override;
   ```

3. **Keep interfaces focused** and follow the Single Responsibility Principle

4. **Consider using pure abstract interfaces** (no data members, only pure virtual functions)

5. **Use `const` for methods** that don't modify the object's state
   ```cpp
   virtual ReturnType someMethod() const = 0;
   ```

## Advanced Example: Strategy Pattern with Interfaces

```cpp
// Logger interface
class Logger {
public:
    virtual void log(const std::string& message) = 0;
    virtual ~Logger() = default;
};

// Concrete implementations
class ConsoleLogger : public Logger {
public:
    void log(const std::string& message) override {
        std::cout << "[Console] " << message << std::endl;
    }
};

class FileLogger : public Logger {
private:
    std::string filename;
public:
    FileLogger(const std::string& filename) : filename(filename) {}
    
    void log(const std::string& message) override {
        // In a real implementation, this would write to a file
        std::cout << "[File: " << filename << "] " << message << std::endl;
    }
};

// Class that uses the logger interface
class Application {
private:
    std::unique_ptr<Logger> logger;
public:
    Application(std::unique_ptr<Logger> logger) : logger(std::move(logger)) {}
    
    void doSomething() {
        // Use the logger through the interface
        logger->log("Application is doing something");
    }
};

int main() {
    // Using ConsoleLogger
    Application app1(std::make_unique<ConsoleLogger>());
    app1.doSomething();
    
    // Using FileLogger
    Application app2(std::make_unique<FileLogger>("app.log"));
    app2.doSomething();
    
    return 0;
}
```

## Key Benefits of Using Interfaces in C++

1. **Separation of Concerns**: Interfaces separate what an object does from how it does it
2. **Polymorphism**: Enable treating different types of objects uniformly
3. **Testability**: Make code easier to test through mock implementations
4. **Flexibility**: Allow for easier changes of implementation details
5. **Contracts**: Define clear contracts between different parts of your code

## Limitations and Considerations

1. **Runtime Overhead**: Virtual function calls have a small overhead
2. **Memory Overhead**: Virtual tables add a small memory overhead
3. **Compile-Time vs. Runtime**: Interfaces enforce contracts at runtime, not compile time
4. **Design Complexity**: Can add complexity to simpler applications
