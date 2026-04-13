# Modern C++ Series - Episode 51
## Classes Part 15: Inheritance Calling Different Constructors

This document summarizes Episode 51 of the Modern C++ Series, focusing on inheritance and how constructors are called in derived classes.

### Key Concepts

In C++ inheritance, when creating objects of derived classes, constructors are called in a specific order:
1. Base class constructor is called first
2. Derived class constructor is called second

This ensures that the base class portion of the object is properly initialized before the derived class adds its functionality.

### Basic Constructor Calling

```cpp
class Base {
public:
    Base() {
        std::cout << "Base constructor called" << std::endl;
    }
};

class Derived : public Base {
public:
    Derived() {
        std::cout << "Derived constructor called" << std::endl;
    }
};

int main() {
    Derived d; // Output: Base constructor called
               //         Derived constructor called
    return 0;
}
```

### Constructor Initialization Lists

The preferred way to call specific base class constructors is using initialization lists:

```cpp
class Base {
private:
    int value;
public:
    Base() : value(0) {
        std::cout << "Base default constructor called" << std::endl;
    }
    
    Base(int val) : value(val) {
        std::cout << "Base parameterized constructor called with " << val << std::endl;
    }
};

class Derived : public Base {
private:
    double data;
public:
    // Call base default constructor
    Derived() : Base(), data(0.0) {
        std::cout << "Derived default constructor called" << std::endl;
    }
    
    // Call base parameterized constructor
    Derived(int val, double d) : Base(val), data(d) {
        std::cout << "Derived parameterized constructor called" << std::endl;
    }
};
```

### Implicit Base Constructor Calling

If no base constructor is explicitly specified, the default base constructor is called:

```cpp
class Base {
public:
    Base() {
        std::cout << "Base default constructor called" << std::endl;
    }
    
    Base(int val) {
        std::cout << "Base parameterized constructor called" << std::endl;
    }
};

class Derived : public Base {
public:
    // Implicitly calls Base()
    Derived() {
        std::cout << "Derived constructor called" << std::endl;
    }
};
```

### Multiple Inheritance Constructor Calling

When a class inherits from multiple base classes, constructors are called in the order of inheritance declaration:

```cpp
class Base1 {
public:
    Base1() {
        std::cout << "Base1 constructor called" << std::endl;
    }
};

class Base2 {
public:
    Base2() {
        std::cout << "Base2 constructor called" << std::endl;
    }
};

// Order of inheritance: Base1, then Base2
class MultiDerived : public Base1, public Base2 {
public:
    MultiDerived() {
        std::cout << "MultiDerived constructor called" << std::endl;
    }
};

int main() {
    MultiDerived md;
    // Output: Base1 constructor called
    //         Base2 constructor called
    //         MultiDerived constructor called
    return 0;
}
```

### Handling Constructor Parameters

Different ways to pass parameters from derived to base class constructors:

```cpp
class Base {
private:
    int x;
    std::string name;
public:
    Base(int val, const std::string& n) : x(val), name(n) {
        std::cout << "Base initialized with " << x << " and " << name << std::endl;
    }
};

class Derived : public Base {
private:
    double factor;
public:
    // Option 1: Pass fixed values
    Derived() : Base(0, "default"), factor(1.0) {
        std::cout << "Derived default constructor" << std::endl;
    }
    
    // Option 2: Pass through parameters
    Derived(int val, const std::string& n, double f) : Base(val, n), factor(f) {
        std::cout << "Derived parameterized constructor" << std::endl;
    }
    
    // Option 3: Transform parameters
    Derived(int val, double f) : Base(val * 2, "derived-" + std::to_string(val)), factor(f) {
        std::cout << "Derived transformer constructor" << std::endl;
    }
};
```

### Virtual Inheritance

With virtual inheritance, the constructor of the virtual base class is called first, regardless of inheritance order:

```cpp
class GrandBase {
public:
    GrandBase() {
        std::cout << "GrandBase constructor called" << std::endl;
    }
};

class Base1 : virtual public GrandBase {
public:
    Base1() {
        std::cout << "Base1 constructor called" << std::endl;
    }
};

class Base2 : virtual public GrandBase {
public:
    Base2() {
        std::cout << "Base2 constructor called" << std::endl;
    }
};

class Diamond : public Base1, public Base2 {
public:
    Diamond() {
        std::cout << "Diamond constructor called" << std::endl;
    }
};

int main() {
    Diamond d;
    // Output: GrandBase constructor called (only once!)
    //         Base1 constructor called
    //         Base2 constructor called
    //         Diamond constructor called
    return 0;
}
```

### Common Mistakes to Avoid

1. Forgetting to call the appropriate base constructor:

```cpp
class Base {
private:
    int data;
public:
    // No default constructor!
    Base(int val) : data(val) { }
};

class Derived : public Base {
public:
    // Error: Base has no default constructor
    Derived() {
        // Compiler tries to call Base()
    }
    
    // Correct:
    Derived() : Base(0) {
        // Explicitly calls Base(int)
    }
};
```

2. Trying to initialize base class members directly:

```cpp
class Base {
protected:
    int value;
public:
    Base(int val) : value(val) { }
};

class Derived : public Base {
public:
    // Wrong: Can't initialize base members directly
    Derived(int val) : value(val) { 
        // Compiler error
    }
    
    // Correct: Call the base constructor
    Derived(int val) : Base(val) { }
};
```

### Best Practices

1. Always use initialization lists to call base constructors
2. Be explicit about which base constructor you're calling
3. Remember that base class constructors are called before derived class constructors
4. Be careful with multiple inheritance - constructors are called in the order of inheritance declaration
5. With virtual inheritance, virtual base constructors are called first
6. Document the constructor calling sequence for complex class hierarchies

### Summary

Understanding how constructors are called in inheritance hierarchies is crucial for proper object initialization in C++. The base class constructor is always called before the derived class constructor, ensuring that the object is built from the ground up. Using initialization lists is the most explicit and efficient way to specify which base constructor should be called.
