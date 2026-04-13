# API Design Tips in Modern C++: pimpl Idiom and struct Options

## Introduction

This document summarizes the key concepts from the video "API Design - Two Tips: pimpl idiom and 'struct Options' | Modern Cpp Series Ep. 90," focusing on two important design patterns that can improve C++ API design:

1. The pimpl (pointer to implementation) idiom
2. The "struct Options" pattern

Both techniques help create more maintainable, stable, and user-friendly APIs.

## The pimpl Idiom

### Problem it Solves

The pimpl idiom (Pointer to IMPLementation) addresses several key challenges in C++ API design:

- **Reduced header dependencies**: Minimizes `#include` statements in headers
- **Faster compile times**: Changes to implementation details don't trigger recompilation of client code
- **Binary compatibility**: Allows implementation changes without breaking ABI
- **Implementation hiding**: Keeps implementation details private from users

### How It Works

The pimpl idiom involves:
1. Moving implementation details to a separate class
2. Storing a pointer to this implementation in the public API class
3. Forward-declaring the implementation class in the header

### Code Example

**Before using pimpl (problematic API)**:

```cpp
// widget.h
#include "complex_dependency1.h"
#include "complex_dependency2.h"
#include "complex_dependency3.h"

class Widget {
public:
    Widget();
    ~Widget();
    void doSomething();
    
private:
    ComplexType1 data1;     // Implementation detail exposed in header
    ComplexType2 data2;     // Implementation detail exposed in header
    int internalState;      // Implementation detail exposed in header
};
```

**After applying pimpl idiom**:

```cpp
// widget.h
class Widget {
public:
    Widget();
    ~Widget();
    Widget(Widget&&) noexcept;             // Move constructor
    Widget& operator=(Widget&&) noexcept;  // Move assignment
    void doSomething();
    
private:
    class Impl;             // Forward declaration
    std::unique_ptr<Impl> pImpl;  // Pointer to implementation
};
```

```cpp
// widget.cpp
#include "widget.h"
#include "complex_dependency1.h"
#include "complex_dependency2.h"
#include "complex_dependency3.h"

class Widget::Impl {
public:
    ComplexType1 data1;
    ComplexType2 data2;
    int internalState;
    
    void internalFunction() {
        // Implementation-specific code
    }
};

Widget::Widget() : pImpl(std::make_unique<Impl>()) {}

Widget::~Widget() = default;  // Needs to be defined in cpp where Impl is complete

Widget::Widget(Widget&&) noexcept = default;
Widget& Widget::operator=(Widget&&) noexcept = default;

void Widget::doSomething() {
    pImpl->internalFunction();
    // Other implementation code
}
```

### Key Implementation Notes

1. Use `std::unique_ptr` for automatic memory management
2. Define special member functions in the .cpp file where the implementation class is complete
3. Implement move operations for efficiency
4. Be cautious with copy operations (usually more expensive)

## The "struct Options" Pattern

### Problem it Solves

The "struct Options" pattern addresses:

- **API evolution**: Adding parameters without breaking existing code
- **Optional parameters**: Making most parameters optional with sensible defaults
- **Self-documentation**: Making the API more readable
- **Simplifying construction**: Reducing constructor overloads

### How It Works

1. Define a struct containing all configurable parameters with default values
2. Use this struct as a parameter to constructors/functions
3. Add new parameters to the struct as needed without breaking existing code

### Code Example

**Before using Options (problematic API)**:

```cpp
// database_connection.h
class DatabaseConnection {
public:
    // Constructor with many parameters
    DatabaseConnection(
        std::string host,
        int port = 5432,
        std::string username = "admin",
        std::string password = "",
        int timeout_ms = 1000,
        bool use_ssl = true,
        int max_connections = 10
    );
    
    // Adding a new parameter would break existing code
};
```

**After applying struct Options pattern**:

```cpp
// database_connection.h
class DatabaseConnection {
public:
    struct Options {
        std::string host = "localhost";
        int port = 5432;
        std::string username = "admin";
        std::string password = "";
        int timeout_ms = 1000;
        bool use_ssl = true;
        int max_connections = 10;
        // New parameters can be added here without breaking existing code
        int retry_attempts = 3;
        bool log_queries = false;
    };
    
    explicit DatabaseConnection(Options options = Options{});
};
```

**Client code usage**:

```cpp
// Simple usage with defaults
DatabaseConnection db1;

// Specifying just what's needed
DatabaseConnection::Options opts;
opts.host = "production-server";
opts.password = "secure123";
opts.max_connections = 20;
DatabaseConnection db2(opts);

// C++20 designated initializers make this even cleaner
DatabaseConnection db3({
    .host = "production-server",
    .password = "secure123",
    .max_connections = 20
});
```

### Key Implementation Notes

1. Provide sensible defaults for all parameters when possible
2. Use the Options struct as the first parameter to constructors/functions
3. Consider making the Options struct nested inside your class
4. With C++20, designated initializers make usage even cleaner

## Combining Both Patterns

For optimal API design, consider using both patterns together:

```cpp
// api.h
class API {
public:
    struct Options {
        std::string endpoint = "api.example.com";
        int timeout_ms = 5000;
        bool retry_on_failure = true;
        // More options with defaults
    };
    
    explicit API(Options options = Options{});
    ~API();
    API(API&&) noexcept;
    API& operator=(API&&) noexcept;
    
    // Public methods
    void request(const std::string& path);
    
private:
    class Impl;
    std::unique_ptr<Impl> pImpl;
};
```

## Conclusion

These two patterns, when applied properly, lead to:

- More maintainable and robust APIs
- Better separation of concerns
- Easier evolution of your API over time
- Improved compile times
- Better user experience for consumers of your API

They represent best practices in modern C++ API design and can significantly improve the quality of your libraries and applications.
