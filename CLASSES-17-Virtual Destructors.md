# Virtual Destructors in C++ - Summary

## Overview

This document summarizes the key concepts from "Classes part 17 - Virtual Destructors" (Modern C++ Series Episode 53), focusing on why base class destructors should be made virtual in polymorphic class hierarchies.

## The Problem: Memory Leaks with Non-Virtual Destructors

When using polymorphism in C++, failing to make the base class destructor virtual can lead to resource leaks. This happens when a derived class object is deleted through a base class pointer.

### Example Demonstrating the Issue:

```cpp
#include <iostream>

class Base {
public:
    Base() {
        std::cout << "Base constructor called\n";
    }
    
    // Non-virtual destructor
    ~Base() {
        std::cout << "Base destructor called\n";
    }
};

class Derived : public Base {
public:
    Derived() {
        std::cout << "Derived constructor called\n";
        // Allocate some resources
        data = new int[10];
    }
    
    ~Derived() {
        std::cout << "Derived destructor called\n";
        // Clean up resources
        delete[] data;
    }

private:
    int* data;
};

int main() {
    // Case 1: Object handled through its own type - works correctly
    {
        std::cout << "Creating Derived object directly...\n";
        Derived d;
        std::cout << "Derived object going out of scope...\n";
    }
    
    std::cout << "\n------------------------\n\n";
    
    // Case 2: Object handled through base pointer - problem occurs!
    {
        std::cout << "Creating Derived object through Base pointer...\n";
        Base* ptr = new Derived();
        std::cout << "Deleting through Base pointer...\n";
        delete ptr; // Only Base destructor is called!
    }
    
    return 0;
}
```

### Output:

```
Creating Derived object directly...
Base constructor called
Derived constructor called
Derived object going out of scope...
Derived destructor called
Base destructor called

------------------------

Creating Derived object through Base pointer...
Base constructor called
Derived constructor called
Deleting through Base pointer...
Base destructor called
```

Notice that in the second case, the Derived destructor is never called, resulting in a memory leak of the `data` array.

## The Solution: Virtual Destructors

Making the base class destructor virtual ensures that the correct destructor chain is called, regardless of the pointer type used for deletion.

### Corrected Example:

```cpp
#include <iostream>

class Base {
public:
    Base() {
        std::cout << "Base constructor called\n";
    }
    
    // Virtual destructor
    virtual ~Base() {
        std::cout << "Base destructor called\n";
    }
};

class Derived : public Base {
public:
    Derived() {
        std::cout << "Derived constructor called\n";
        data = new int[10];
    }
    
    ~Derived() override {
        std::cout << "Derived destructor called\n";
        delete[] data;
    }

private:
    int* data;
};

int main() {
    // Case with virtual destructor - works correctly
    {
        std::cout << "Creating Derived object through Base pointer...\n";
        Base* ptr = new Derived();
        std::cout << "Deleting through Base pointer...\n";
        delete ptr; // Now both destructors are called in the correct order
    }
    
    return 0;
}
```

### Output with virtual destructor:

```
Creating Derived object through Base pointer...
Base constructor called
Derived constructor called
Deleting through Base pointer...
Derived destructor called
Base destructor called
```

Now both destructors are called in the correct order (derived first, then base), preventing memory leaks.

## Real-World Example with Resource Management

```cpp
#include <iostream>
#include <string>
#include <vector>

class Logger {
public:
    Logger(const std::string& name) : loggerName(name) {
        std::cout << "Logger '" << loggerName << "' initialized\n";
    }
    
    // Virtual destructor - critical for proper cleanup
    virtual ~Logger() {
        std::cout << "Logger '" << loggerName << "' shutdown\n";
    }
    
    virtual void log(const std::string& message) {
        std::cout << "[" << loggerName << "] " << message << "\n";
    }

protected:
    std::string loggerName;
};

class FileLogger : public Logger {
public:
    FileLogger(const std::string& name, const std::string& filename) 
        : Logger(name), logFilename(filename) {
        std::cout << "FileLogger opening file: " << logFilename << "\n";
        // Simulating file resource allocation
        fileHandle = new std::vector<std::string>();
    }
    
    ~FileLogger() override {
        std::cout << "FileLogger closing file: " << logFilename << "\n";
        // Cleanup file resources
        delete fileHandle;
    }
    
    void log(const std::string& message) override {
        Logger::log(message);
        // Simulating writing to file
        fileHandle->push_back(message);
        std::cout << "  (Written to file: " << logFilename << ")\n";
    }

private:
    std::string logFilename;
    std::vector<std::string>* fileHandle; // Simulated file resource
};

int main() {
    // Using polymorphism with loggers
    Logger* loggers[2];
    
    loggers[0] = new Logger("Console");
    loggers[1] = new FileLogger("SystemFile", "system.log");
    
    for (auto& logger : loggers) {
        logger->log("Application started");
    }
    
    // Proper cleanup because of virtual destructors
    for (auto& logger : loggers) {
        delete logger; // Will call the correct destructor sequence
    }
    
    return 0;
}
```

## Key Points

1. **Always declare destructors as virtual in base classes** that are meant to be inherited from.

2. **The `override` keyword** (C++11 and later) is recommended for derived class destructors to make the code more readable and catch potential errors.

3. **Rule of thumb**: If a class has any virtual functions, it should have a virtual destructor.

4. **Performance impact**: Virtual destructors add a small overhead (vtable entry), but this is negligible compared to the risk of memory leaks.

5. **Interfaces** (classes with pure virtual functions) should also have virtual destructors, even if they're empty.

## Best Practice

```cpp
class Interface {
public:
    // Pure virtual function making this an abstract class
    virtual void doSomething() = 0;
    
    // Virtual destructor, even though it does nothing
    virtual ~Interface() = default;
};
```

## When to Avoid Virtual Destructors

If a class is not designed to be used polymorphically or is not meant to be a base class, making the destructor virtual adds unnecessary overhead.

## Conclusion

Virtual destructors are essential for correct resource management in C++ class hierarchies. Making base class destructors virtual ensures that all destructors in the inheritance chain are called when objects are deleted through base class pointers, preventing memory leaks and resource management issues.
