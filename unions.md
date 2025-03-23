# Unions in Modern C++

## Introduction to Unions

Unions in C++ are a special class type that allows storing different data types in the same memory location. This means that a union can contain multiple members, but only one member can hold a value at any given time.

## Basic Union Syntax

```cpp
union MyUnion {
    int i;
    float f;
    char c;
};
```

In this example, `MyUnion` can store an integer, a float, or a character, but only one of these at a time. The size of the union is determined by its largest member.

## Memory Layout

Unlike structs, where members are stored sequentially in memory, unions overlay all members at the same memory address:

```cpp
#include <iostream>

union MyUnion {
    int i;       // 4 bytes
    double d;    // 8 bytes
    char c;      // 1 byte
};

int main() {
    std::cout << "Size of MyUnion: " << sizeof(MyUnion) << " bytes\n";
    
    MyUnion u;
    u.i = 10;
    std::cout << "u.i = " << u.i << "\n";
    
    u.d = 3.14;
    std::cout << "u.d = " << u.d << "\n";
    // At this point, u.i no longer holds the value 10
    std::cout << "u.i = " << u.i << " (corrupted)\n";
    
    return 0;
}
```

Output:
```
Size of MyUnion: 8 bytes
u.i = 10
u.d = 3.14
u.i = 1374389535 (corrupted)
```

The size of the union is 8 bytes, which is the size of its largest member (`double`).

## Type Safety Issues

A major drawback of traditional unions is the lack of type safety. The programmer must keep track of which member is currently active:

```cpp
union Value {
    int i;
    float f;
};

void processValue(Value v, bool isFloat) {
    if (isFloat) {
        std::cout << "Float value: " << v.f << "\n";
    } else {
        std::cout << "Int value: " << v.i << "\n";
    }
}
```

## Anonymous Unions

C++ supports anonymous unions, which don't have a name and their members become directly accessible in the surrounding scope:

```cpp
struct Widget {
    bool isInteger;
    
    // Anonymous union
    union {
        int i;
        float f;
    };
    
    void setValue(int value) {
        i = value;
        isInteger = true;
    }
    
    void setValue(float value) {
        f = value;
        isInteger = false;
    }
    
    void printValue() const {
        if (isInteger) {
            std::cout << "Integer: " << i << "\n";
        } else {
            std::cout << "Float: " << f << "\n";
        }
    }
};
```

## Unions with Classes

Unions can contain classes with constructors and destructors, but this requires special handling:

```cpp
#include <new>        // For placement new
#include <string>
#include <iostream>

union StringOrInt {
    std::string s;    // Has constructor and destructor
    int i;
    
    // Default constructor
    StringOrInt() : i(0) {}
    
    // String constructor using placement new
    void setString(const std::string& str) {
        new(&s) std::string(str);
    }
    
    // Destructor must be called manually
    ~StringOrInt() {
        // We would need to know if s is active
    }
};
```

## C++17 std::variant as a Type-Safe Union

Modern C++ introduces `std::variant` as a type-safe alternative to unions:

```cpp
#include <variant>
#include <string>
#include <iostream>

int main() {
    // A variant that can hold either an int or a string
    std::variant<int, std::string> v;
    
    v = 42;  // v contains int
    std::cout << std::get<int>(v) << "\n";
    
    v = std::string("Hello");  // v contains string
    std::cout << std::get<std::string>(v) << "\n";
    
    // Check which type is currently held
    if (std::holds_alternative<int>(v)) {
        std::cout << "v holds an int\n";
    } else if (std::holds_alternative<std::string>(v)) {
        std::cout << "v holds a string\n";
    }
    
    // Visit pattern (type-safe processing)
    std::visit([](auto&& arg) {
        using T = std::decay_t<decltype(arg)>;
        if constexpr (std::is_same_v<T, int>) {
            std::cout << "Int value: " << arg << "\n";
        } else if constexpr (std::is_same_v<T, std::string>) {
            std::cout << "String value: " << arg << "\n";
        }
    }, v);
    
    return 0;
}
```

## When to Use Unions

Unions are useful in scenarios such as:

1. **Memory optimization**: When you need to save memory and you know only one option will be used at a time.

2. **Type punning**: Viewing the same data as different types (though this can lead to aliasing issues).

```cpp
union TypePunning {
    float f;
    uint32_t i;
};

// Example: Get raw bits from a float
TypePunning tp;
tp.f = 3.14f;
std::cout << "Float 3.14f as bits: 0x" << std::hex << tp.i << "\n";
```

3. **Implementing tagged unions**: Creating sum types before C++17's `std::variant`.

## Best Practices

1. **Prefer `std::variant` in modern C++ code** for type safety.

2. **Use a discriminator field** when working with traditional unions to track the active member.

3. **Be careful with non-trivial types** in unions (classes with constructors/destructors).

4. **Consider alignment requirements** for optimal performance.

5. **Document assumptions** about which union member is active in which contexts.

## Performance Considerations

- Unions have no runtime overhead compared to using a single variable.
- `std::variant` adds a small amount of overhead for type safety.
- For performance-critical code, traditional unions might still be preferable.

## Conclusion

While traditional unions in C++ provide memory efficiency by allowing multiple types to share the same memory location, they lack type safety. Modern C++ offers `std::variant` as a safer alternative that provides similar functionality with additional type checking.

Use unions when memory efficiency is critical and you're confident in managing the active type. Use `std::variant` when type safety is more important than absolute performance.
