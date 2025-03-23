# PIMPL Pattern (Pointer to Implementation) in Modern C++

## Introduction

The PIMPL (Pointer to IMPLementation) idiom is a design pattern in C++ that helps create more stable Application Programming Interfaces (APIs) and reduce compilation dependencies. This pattern is also known as the Compilation Firewall or Handle/Body idiom.

## Why Use PIMPL?

1. **Reduced Compilation Dependencies**: By hiding implementation details, changes to the implementation don't require clients to recompile.
2. **Improved Build Times**: Fewer header dependencies lead to faster build times.
3. **API Stability**: The public interface remains stable even when implementation changes.
4. **Binary Compatibility**: Implementation changes don't break binary compatibility.
5. **Information Hiding**: Implementation details are truly hidden from clients.

## Basic PIMPL Pattern Implementation

### Traditional Header File (Without PIMPL)

```cpp
// widget.h
#include <string>
#include <vector>
#include "complex_dependency.h"

class Widget {
public:
    Widget();
    ~Widget();
    void doSomething();
    
private:
    std::string name;
    std::vector<int> data;
    ComplexDependency helper;
};
```

Every time `ComplexDependency` changes, all code that includes `widget.h` must be recompiled.

### With PIMPL Pattern

```cpp
// widget.h
#include <memory>

class Widget {
public:
    Widget();
    ~Widget();
    Widget(Widget&& other) noexcept;
    Widget& operator=(Widget&& other) noexcept;
    
    void doSomething();
    
private:
    class Impl;
    std::unique_ptr<Impl> pImpl; // Pointer to implementation
};
```

```cpp
// widget.cpp
#include "widget.h"
#include <string>
#include <vector>
#include "complex_dependency.h"

class Widget::Impl {
public:
    std::string name;
    std::vector<int> data;
    ComplexDependency helper;
    
    void doSomethingImpl() {
        // Implementation details
    }
};

Widget::Widget() : pImpl(std::make_unique<Impl>()) {}

Widget::~Widget() = default;

Widget::Widget(Widget&& other) noexcept = default;
Widget& Widget::operator=(Widget&& other) noexcept = default;

void Widget::doSomething() {
    pImpl->doSomethingImpl();
}
```

## Key Points About PIMPL

### Special Member Functions

When using `std::unique_ptr` with an incomplete type, you need to:

1. Define the destructor in the implementation file where the type is complete
2. Declare move operations if needed
3. Consider rule of five implications

```cpp
// Must be defined where Impl is complete
Widget::~Widget() = default;
```

### Performance Considerations

- Extra indirection: Small performance cost due to pointer dereferencing
- Memory allocation: Construction requires heap allocation
- Cache locality: May reduce due to splitting object across memory areas

### Modern C++ Improvements

C++11 and beyond make PIMPL easier with:

- `std::unique_ptr` for automatic resource management
- Move semantics for efficient transfers
- `= default` for special member functions

## Complete Example with Modern C++

```cpp
// gadget.h
#include <memory>
#include <string>

class Gadget {
public:
    // Constructors and assignment
    Gadget();
    ~Gadget();
    Gadget(const Gadget& other);
    Gadget& operator=(const Gadget& other);
    Gadget(Gadget&& other) noexcept;
    Gadget& operator=(Gadget&& other) noexcept;
    
    // Public API
    void setName(const std::string& name);
    std::string getName() const;
    void performAction();
    
private:
    class Impl;
    std::unique_ptr<Impl> pImpl;
};
```

```cpp
// gadget.cpp
#include "gadget.h"
#include <iostream>
#include <complex>
#include <vector>

class Gadget::Impl {
public:
    std::string name;
    std::vector<std::complex<double>> complexData;
    
    void performActionImpl() {
        std::cout << "Performing action with " << name << std::endl;
    }
};

// Constructors and destructor
Gadget::Gadget() : pImpl(std::make_unique<Impl>()) {}

Gadget::~Gadget() = default;

Gadget::Gadget(const Gadget& other) : pImpl(std::make_unique<Impl>(*other.pImpl)) {}

Gadget& Gadget::operator=(const Gadget& other) {
    if (this != &other) {
        *pImpl = *other.pImpl;
    }
    return *this;
}

Gadget::Gadget(Gadget&& other) noexcept = default;
Gadget& Gadget::operator=(Gadget&& other) noexcept = default;

// Method implementations
void Gadget::setName(const std::string& name) {
    pImpl->name = name;
}

std::string Gadget::getName() const {
    return pImpl->name;
}

void Gadget::performAction() {
    pImpl->performActionImpl();
}
```

## Best Practices

1. **Use `std::unique_ptr` for the implementation pointer**: This provides automatic memory management.

2. **Define special member functions properly**: Be careful with the destructor, copy, and move operations.

3. **Consider performance implications**: Use PIMPL when API stability and compilation speed outweigh the small performance cost.

4. **Be consistent**: Apply PIMPL to an entire class hierarchy if appropriate.

5. **Consider alternatives for small classes**: For small classes with few dependencies, PIMPL might be overkill.

## When to Use PIMPL

- Library interfaces that need long-term stability
- Headers with many dependencies that slow down compilation
- Code where implementation details need to be truly hidden

## When Not to Use PIMPL

- Performance-critical code where every indirection matters
- Simple classes with few dependencies
- Code where memory footprint is critical

## Conclusion

The PIMPL pattern is a powerful tool in modern C++ for creating stable interfaces and reducing compilation dependencies. With C++11 and beyond, implementing this pattern has become easier and safer thanks to smart pointers and move semantics.
