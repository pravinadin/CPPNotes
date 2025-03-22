# Virtual Functions and Dynamic Dispatch in C++

## Introduction

This document summarizes the key concepts from "Classes part 16 - Virtual Functions (Dynamic dispatch) | Modern C++ Series Ep. 52". Virtual functions are a fundamental concept in C++ that enable polymorphism through a mechanism called dynamic dispatch.

## What are Virtual Functions?

Virtual functions allow a program to call methods that are overridden in derived classes through base class pointers or references. This is one of the key mechanisms that enables polymorphic behavior in C++.

## Key Concepts

### 1. Static vs Dynamic Binding

- **Static binding (Early binding)**: Function calls are resolved at compile time
- **Dynamic binding (Late binding)**: Function calls are resolved at runtime

### 2. The `virtual` Keyword

The `virtual` keyword tells the compiler to use dynamic dispatch for a function. When a function is marked as virtual in a base class, any matching function in a derived class will override it.

```cpp
class Base {
public:
    virtual void show() {
        std::cout << "Base class show function" << std::endl;
    }
};

class Derived : public Base {
public:
    void show() override {
        std::cout << "Derived class show function" << std::endl;
    }
};
```

### 3. The `override` Keyword (C++11)

The `override` keyword helps catch errors by ensuring that a function in a derived class is actually overriding a virtual function from a base class.

```cpp
class Base {
public:
    virtual void show() {
        std::cout << "Base class show function" << std::endl;
    }
};

class Derived : public Base {
public:
    // Compiler error if Base::show() is not virtual or has a different signature
    void show() override {
        std::cout << "Derived class show function" << std::endl;
    }
};
```

### 4. Virtual Table (vtable) and Virtual Pointer (vptr)

- **vtable**: A table of function pointers created by the compiler for each class with virtual functions
- **vptr**: A hidden pointer added to objects of classes with virtual functions, pointing to the vtable

This is how the dynamic dispatch mechanism actually works under the hood:

```cpp
// Example showing how virtual functions work behind the scenes

// What you write:
Base* ptr = new Derived();
ptr->show();  // Calls Derived::show()

// What happens behind the scenes (conceptually):
// 1. ptr->vptr points to Derived's vtable
// 2. The vtable contains a pointer to Derived::show()
// 3. That function gets called
```

### 5. Complete Example with Dynamic Dispatch

```cpp
#include <iostream>

class Shape {
public:
    virtual double area() const {
        return 0.0;
    }
    
    virtual double perimeter() const {
        return 0.0;
    }
    
    // Virtual destructor is important for proper cleanup
    virtual ~Shape() {
        std::cout << "Shape destructor" << std::endl;
    }
};

class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(double r) : radius(r) {}
    
    double area() const override {
        return 3.14159 * radius * radius;
    }
    
    double perimeter() const override {
        return 2 * 3.14159 * radius;
    }
    
    ~Circle() override {
        std::cout << "Circle destructor" << std::endl;
    }
};

class Rectangle : public Shape {
private:
    double width;
    double height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    double area() const override {
        return width * height;
    }
    
    double perimeter() const override {
        return 2 * (width + height);
    }
    
    ~Rectangle() override {
        std::cout << "Rectangle destructor" << std::endl;
    }
};

// Function that works with any Shape
void printShapeInfo(const Shape& shape) {
    std::cout << "Area: " << shape.area() << std::endl;
    std::cout << "Perimeter: " << shape.perimeter() << std::endl;
}

int main() {
    Circle circle(5.0);
    Rectangle rectangle(4.0, 6.0);
    
    std::cout << "Circle info:" << std::endl;
    printShapeInfo(circle);
    
    std::cout << "\nRectangle info:" << std::endl;
    printShapeInfo(rectangle);
    
    // Using pointers
    Shape* shapes[2];
    shapes[0] = new Circle(3.0);
    shapes[1] = new Rectangle(2.0, 5.0);
    
    std::cout << "\nArray of shapes:" << std::endl;
    for (int i = 0; i < 2; ++i) {
        std::cout << "Shape " << i + 1 << ":" << std::endl;
        printShapeInfo(*shapes[i]);
        std::cout << std::endl;
    }
    
    // Cleanup
    for (int i = 0; i < 2; ++i) {
        delete shapes[i]; // Calls appropriate destructor thanks to virtual
    }
    
    return 0;
}
```

### 6. Virtual Destructors

When using polymorphism, it's crucial to declare the base class destructor as virtual. This ensures that when a derived class object is deleted through a base class pointer, the proper destructor chain is called.

```cpp
class Base {
public:
    virtual ~Base() {
        std::cout << "Base destructor" << std::endl;
    }
};

class Derived : public Base {
public:
    ~Derived() override {
        std::cout << "Derived destructor" << std::endl;
    }
};

// Without a virtual destructor, this would only call Base's destructor
// resulting in a memory leak
Base* ptr = new Derived();
delete ptr;  // Calls Derived::~Derived() then Base::~Base()
```

### 7. Pure Virtual Functions and Abstract Classes

A pure virtual function is declared by assigning 0 to the function declaration. A class with at least one pure virtual function becomes an abstract class, which cannot be instantiated directly.

```cpp
class AbstractShape {
public:
    // Pure virtual functions
    virtual double area() const = 0;
    virtual double perimeter() const = 0;
    
    virtual ~AbstractShape() {}
};

// Must implement all pure virtual functions to be instantiable
class Square : public AbstractShape {
private:
    double side;
    
public:
    Square(double s) : side(s) {}
    
    double area() const override {
        return side * side;
    }
    
    double perimeter() const override {
        return 4 * side;
    }
};

// This would cause an error:
// AbstractShape shape; // Cannot instantiate abstract class

// This is valid:
Square square(5.0);
AbstractShape* shape = &square; // Using pointer to abstract class
```

## Performance Considerations

- Virtual functions add a small overhead due to the vtable lookup
- This overhead is typically negligible in modern systems
- The benefits of polymorphism and cleaner design often outweigh the small performance cost

## Best Practices

1. Always declare destructors as virtual in base classes
2. Use the override keyword for clarity and to catch errors
3. Use pure virtual functions to create interfaces (abstract base classes)
4. Don't mark functions as virtual unnecessarily
5. Consider performance in tight loops or performance-critical code

## Conclusion

Virtual functions and dynamic dispatch are powerful features in C++ that enable polymorphic behavior. They allow writing code that works with objects through base class interfaces, without needing to know the specific derived type at compile time. This is a cornerstone of object-oriented programming and enables more flexible and extensible designs.
