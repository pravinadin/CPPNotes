# Structs in C++ | Modern C++ Series Summary

## Introduction to Structs in C++

In C++, a struct is essentially a class where members are public by default. This is the main technical difference between structs and classes in C++, though they're used differently by convention.

## Key Differences Between Structs and Classes

| Feature | Struct | Class |
|---------|--------|-------|
| Default member access | Public | Private |
| Default inheritance | Public | Private |
| Primary use (convention) | Plain Old Data (POD) types | Complex objects with behavior |

## When to Use Structs

Structs are typically used for:
- Simple data aggregation
- "Plain Old Data" (POD) types
- When you need public members by default
- When inheritance and complex behavior are not needed
- Lightweight data structures

## Basic Struct Syntax

```cpp
struct Point {
    int x;  // Public by default
    int y;  // Public by default
};

// Usage
int main() {
    Point p1;
    p1.x = 5;
    p1.y = 10;
    
    // Direct initialization also works
    Point p2 = {15, 20};
    
    // C++11 uniform initialization
    Point p3{25, 30};
    
    return 0;
}
```

## Structs with Constructors and Methods

Structs can have constructors, methods, and other class-like features:

```cpp
struct Rectangle {
    double width;
    double height;
    
    // Constructor
    Rectangle(double w, double h) : width(w), height(h) {}
    
    // Method
    double area() const {
        return width * height;
    }
    
    // Static method
    static Rectangle createSquare(double side) {
        return Rectangle(side, side);
    }
};

// Usage
int main() {
    Rectangle rect(5.0, 3.0);
    double area = rect.area();  // 15.0
    
    Rectangle square = Rectangle::createSquare(4.0);
    // square.width == 4.0, square.height == 4.0
    
    return 0;
}
```

## Nested Structs

Structs can contain other structs:

```cpp
struct Address {
    std::string street;
    std::string city;
    std::string state;
    std::string zipCode;
};

struct Person {
    std::string name;
    int age;
    Address address;  // Nested struct
};

// Usage
int main() {
    Person person;
    person.name = "John Doe";
    person.age = 30;
    person.address.street = "123 Main St";
    person.address.city = "Anytown";
    person.address.state = "CA";
    person.address.zipCode = "12345";
    
    return 0;
}
```

## Structs with Explicit Access Modifiers

You can use access modifiers in structs, though it somewhat defeats their purpose:

```cpp
struct AdvancedPoint {
    // Public by default
    int x;
    int y;
    
    // Default constructor
    AdvancedPoint() : x(0), y(0) {}
    
private:
    // These members are private
    bool isValidated = false;
    
public:
    // Public method
    void validate() {
        isValidated = true;
    }
    
    bool isValid() const {
        return isValidated;
    }
};
```

## Struct vs Class for Data Transfer Objects (DTOs)

Structs are often used for Data Transfer Objects:

```cpp
// As a struct (conventional use)
struct UserDTO {
    int id;
    std::string username;
    std::string email;
};

// Alternative as a class (less conventional)
class UserDTOClass {
public:
    int id;
    std::string username;
    std::string email;
};
```

## Structs with Default Member Initialization

C++11 and later allow default member initialization:

```cpp
struct Configuration {
    bool debugMode = false;
    int maxConnections = 10;
    std::string logFile = "app.log";
    double timeout = 30.0;
};

// Usage
int main() {
    // All members initialized to defaults
    Configuration config;
    
    // Override just what we need
    Configuration customConfig;
    customConfig.debugMode = true;
    customConfig.maxConnections = 100;
    
    return 0;
}
```

## Memory Layout and Alignment

Structs are subject to memory alignment requirements:

```cpp
#include <iostream>

struct MemoryExample {
    char a;     // 1 byte
    // 3 bytes padding (on many systems)
    int b;      // 4 bytes
    short c;    // 2 bytes
    // 2 bytes padding (on many systems)
    double d;   // 8 bytes
};

int main() {
    std::cout << "Size of MemoryExample: " << sizeof(MemoryExample) << " bytes\n";
    // Often outputs 24 bytes, not 15 bytes (1+4+2+8)
    
    return 0;
}
```

## Packed Structs (Advanced)

To avoid padding, some compilers allow packed structs:

```cpp
// This is compiler-specific (shown for GCC/Clang)
struct __attribute__((packed)) PackedExample {
    char a;     // 1 byte
    int b;      // 4 bytes
    short c;    // 2 bytes
    double d;   // 8 bytes
};

// Usage with MSVC
#pragma pack(push, 1)
struct PackedExampleMSVC {
    char a;
    int b;
    short c;
    double d;
};
#pragma pack(pop)
```

## Using Structs with Standard Library Containers

```cpp
#include <vector>
#include <algorithm>
#include <iostream>

struct Student {
    int id;
    std::string name;
    double gpa;
};

bool compareByGPA(const Student& a, const Student& b) {
    return a.gpa > b.gpa;  // For descending order
}

int main() {
    std::vector<Student> students = {
        {1001, "Alice", 3.8},
        {1002, "Bob", 3.6},
        {1003, "Charlie", 4.0}
    };
    
    // Sort by GPA
    std::sort(students.begin(), students.end(), compareByGPA);
    
    // Print sorted students
    for (const auto& student : students) {
        std::cout << student.name << ": " << student.gpa << std::endl;
    }
    
    return 0;
}
```

## Conclusion

Structs in C++ provide a convenient way to group related data with public access by default. While technically almost identical to classes, they're conventionally used for simpler data-oriented structures without complex behavior. 

The key takeaway is to use structs when you primarily need a simple data container and classes when you need to encapsulate both data and behavior with controlled access. Following this convention improves code readability by clearly communicating your intentions to other developers.
