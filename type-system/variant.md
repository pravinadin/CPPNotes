# std::variant - Tagged Unions for Safer C++ Code

## Introduction

`std::variant` is a type-safe union introduced in C++17 that allows you to store values of different types in the same memory location. Unlike traditional C unions, `std::variant` keeps track of which type is currently stored, making it much safer to use.

This summary covers the key concepts and examples from Episode 84 of the Modern C++ Series: "std::variant (tagged unions, write safer code)".

## Basic Usage

### Definition and Construction

```cpp
#include <variant>
#include <string>
#include <iostream>

int main() {
    // Define a variant that can hold either an int, double, or string
    std::variant<int, double, std::string> myVariant;
    
    // Default initializes to the first type (int in this case with value 0)
    std::cout << std::get<int>(myVariant) << std::endl;
    
    // Assign different types
    myVariant = 42;                     // Now contains an int
    myVariant = 3.14;                   // Now contains a double
    myVariant = std::string("Hello");   // Now contains a string
    
    // Direct initialization
    std::variant<int, double, std::string> v1{42};         // int
    std::variant<int, double, std::string> v2{3.14};       // double
    std::variant<int, double, std::string> v3{"Hello"};    // const char* converted to string
    
    return 0;
}
```

### Checking the Current Type

```cpp
#include <variant>
#include <string>
#include <iostream>

int main() {
    std::variant<int, double, std::string> myVariant = 3.14;
    
    // Check which type is currently stored
    if (std::holds_alternative<double>(myVariant)) {
        std::cout << "Contains a double: " << std::get<double>(myVariant) << std::endl;
    }
    
    // Index of the current type (0-based)
    std::cout << "Current type index: " << myVariant.index() << std::endl;
    // For this example, should print 1 (the index of double in the variant)
    
    return 0;
}
```

### Accessing Values Safely

```cpp
#include <variant>
#include <string>
#include <iostream>
#include <stdexcept>

int main() {
    std::variant<int, double, std::string> myVariant = "Hello";
    
    try {
        // Unsafe access - throws std::bad_variant_access if type doesn't match
        double value = std::get<double>(myVariant);  // Will throw because it contains a string
    } catch (const std::bad_variant_access& e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    // Safe access using std::get_if - returns nullptr if type doesn't match
    if (auto pval = std::get_if<std::string>(&myVariant)) {
        std::cout << "Contains string: " << *pval << std::endl;
    } else {
        std::cout << "Does not contain a string" << std::endl;
    }
    
    return 0;
}
```

## Visiting Variants

One of the most powerful features of `std::variant` is the ability to "visit" it with a visitor pattern using `std::visit`.

### Basic Visitor

```cpp
#include <variant>
#include <string>
#include <iostream>

// Visitor class with overloaded operator() for each possible type
struct TypePrinter {
    void operator()(int i) const {
        std::cout << "Integer: " << i << std::endl;
    }
    
    void operator()(double d) const {
        std::cout << "Double: " << d << std::endl;
    }
    
    void operator()(const std::string& s) const {
        std::cout << "String: " << s << std::endl;
    }
};

int main() {
    std::variant<int, double, std::string> myVariant = 42;
    
    // Visit the variant with our visitor
    std::visit(TypePrinter{}, myVariant);
    
    myVariant = 3.14;
    std::visit(TypePrinter{}, myVariant);
    
    myVariant = "Hello";
    std::visit(TypePrinter{}, myVariant);
    
    return 0;
}
```

### Overload Pattern (C++17 Idiom)

A common idiom is to use a helper template to create an overloaded visitor inline:

```cpp
#include <variant>
#include <string>
#include <iostream>

// Helper template for creating overloaded visitors
template<class... Ts> struct overloaded : Ts... { 
    using Ts::operator()...; 
};

// Class template deduction guide (C++17)
template<class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

int main() {
    std::variant<int, double, std::string> myVariant = 3.14;
    
    // Create an inline visitor using the overloaded pattern
    std::visit(overloaded{
        [](int i) { std::cout << "Integer: " << i << std::endl; },
        [](double d) { std::cout << "Double: " << d << std::endl; },
        [](const std::string& s) { std::cout << "String: " << s << std::endl; }
    }, myVariant);
    
    return 0;
}
```

### Returning Values from Visitors

Visitors can also return values, and the return type is deduced automatically:

```cpp
#include <variant>
#include <string>
#include <iostream>

template<class... Ts> struct overloaded : Ts... { 
    using Ts::operator()...; 
};
template<class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

int main() {
    std::variant<int, double, std::string> myVariant = 42;
    
    // Visitor that returns a string description
    std::string description = std::visit(overloaded{
        [](int i) -> std::string { return "Integer: " + std::to_string(i); },
        [](double d) -> std::string { return "Double: " + std::to_string(d); },
        [](const std::string& s) -> std::string { return "String: " + s; }
    }, myVariant);
    
    std::cout << description << std::endl;
    
    return 0;
}
```

## Real-World Example: Command Pattern

`std::variant` can be used to implement a type-safe command pattern:

```cpp
#include <variant>
#include <string>
#include <iostream>
#include <vector>

// Different command types
struct MoveCommand {
    int x, y;
};

struct DrawCommand {
    std::string shape;
    int size;
};

struct ColorCommand {
    int r, g, b;
};

// Define our command type as a variant
using Command = std::variant<MoveCommand, DrawCommand, ColorCommand>;

// Process a sequence of commands
void processCommands(const std::vector<Command>& commands) {
    for (const auto& cmd : commands) {
        std::visit(overloaded{
            [](const MoveCommand& c) {
                std::cout << "Moving to position (" << c.x << ", " << c.y << ")" << std::endl;
            },
            [](const DrawCommand& c) {
                std::cout << "Drawing " << c.shape << " with size " << c.size << std::endl;
            },
            [](const ColorCommand& c) {
                std::cout << "Setting color to RGB(" << c.r << ", " << c.g << ", " << c.b << ")" << std::endl;
            }
        }, cmd);
    }
}

int main() {
    std::vector<Command> commands = {
        MoveCommand{10, 20},
        DrawCommand{"circle", 5},
        ColorCommand{255, 0, 0},
        MoveCommand{15, 25},
        DrawCommand{"rectangle", 10}
    };
    
    processCommands(commands);
    
    return 0;
}
```

## Comparison with Other Approaches

### vs. Union

Traditional C unions are not type-safe:

```cpp
#include <iostream>
#include <string>

// Traditional C union - not type safe!
union Value {
    int i;
    double d;
    // Can't have types with constructors like std::string
    // std::string s;  // This would not compile
    
    // Need to manually construct/destruct
    Value() : i(0) {}  // Default construct as int
};

// Need a separate tag to track type
enum class ValueType { Int, Double };

struct TaggedValue {
    Value value;
    ValueType type;
};

int main() {
    TaggedValue v;
    v.type = ValueType::Int;
    v.value.i = 42;
    
    // Dangerous - no type checking!
    std::cout << v.value.d << std::endl;  // Undefined behavior! Reading wrong type
    
    return 0;
}
```

### vs. Inheritance and Polymorphism

`std::variant` provides value semantics without dynamic allocation:

```cpp
#include <iostream>
#include <string>
#include <memory>
#include <variant>
#include <vector>

// Inheritance-based approach
struct Shape {
    virtual ~Shape() = default;
    virtual void draw() const = 0;
};

struct Circle : Shape {
    int radius;
    
    Circle(int r) : radius(r) {}
    
    void draw() const override {
        std::cout << "Drawing Circle with radius " << radius << std::endl;
    }
};

struct Rectangle : Shape {
    int width, height;
    
    Rectangle(int w, int h) : width(w), height(h) {}
    
    void draw() const override {
        std::cout << "Drawing Rectangle " << width << "x" << height << std::endl;
    }
};

// Variant-based approach
struct CircleV {
    int radius;
    
    void draw() const {
        std::cout << "Drawing Circle with radius " << radius << std::endl;
    }
};

struct RectangleV {
    int width, height;
    
    void draw() const {
        std::cout << "Drawing Rectangle " << width << "x" << height << std::endl;
    }
};

using ShapeVariant = std::variant<CircleV, RectangleV>;

int main() {
    // Inheritance approach - requires dynamic allocation and indirection
    std::vector<std::unique_ptr<Shape>> shapes;
    shapes.push_back(std::make_unique<Circle>(5));
    shapes.push_back(std::make_unique<Rectangle>(10, 20));
    
    for (const auto& shape : shapes) {
        shape->draw();
    }
    
    // Variant approach - value semantics, no dynamic allocation
    std::vector<ShapeVariant> shapeVariants;
    shapeVariants.push_back(CircleV{5});
    shapeVariants.push_back(RectangleV{10, 20});
    
    for (const auto& shape : shapeVariants) {
        std::visit([](const auto& s) { s.draw(); }, shape);
    }
    
    return 0;
}
```

## Benefits of std::variant

1. **Type Safety**: Unlike traditional unions, `std::variant` tracks the current type
2. **Value Semantics**: No dynamic allocation needed, unlike polymorphism
3. **Exhaustiveness Checking**: The compiler ensures all types are handled
4. **Performance**: No virtual function call overhead
5. **Flexibility**: Can store unrelated types (no common base class needed)

## When to Use std::variant

- When you need to represent a value that could be one of several unrelated types
- To implement type-safe pattern matching
- As an alternative to inheritance for simple polymorphism
- When you want value semantics rather than reference semantics
- For implementing state machines, parsers, or command processors

## Limitations

- Slightly more verbose syntax compared to dynamic polymorphism
- All possible types must be known at compile time
- Can be more difficult to extend with new types later

## Conclusion

`std::variant` is a powerful addition to Modern C++ that helps write safer, more expressive code by providing type-safe alternatives to traditional unions. Together with `std::visit`, it enables elegant pattern matching and simplifies handling of heterogeneous data without the overhead of dynamic polymorphism.
