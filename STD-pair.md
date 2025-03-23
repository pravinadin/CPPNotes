# STL std::pair (and std::ref & std::get) | Modern C++ Series

## Introduction

This document summarizes Episode 125 of the Modern C++ Series, which covers `std::pair` along with related utilities `std::ref` and `std::get`. These components are fundamental building blocks in the C++ Standard Template Library (STL) that help with handling pairs of values efficiently.

## std::pair Overview

`std::pair` is a class template that provides a way to store two heterogeneous objects as a single unit. It's defined in the `<utility>` header and is widely used throughout the STL, particularly as the value type of `std::map` and `std::multimap`.

### Basic Usage

```cpp
#include <iostream>
#include <utility>  // for std::pair
#include <string>

int main() {
    // Creating a pair
    std::pair<std::string, int> person("John", 25);
    
    // Accessing elements
    std::cout << "Name: " << person.first << std::endl;
    std::cout << "Age: " << person.second << std::endl;
    
    return 0;
}
```

### Creating Pairs

There are multiple ways to create pairs:

```cpp
// Method 1: Using the constructor
std::pair<std::string, double> product1("Laptop", 999.99);

// Method 2: Using std::make_pair (preferred - type deduction)
auto product2 = std::make_pair("Smartphone", 499.99);

// Method 3: Using list initialization (C++11 and later)
std::pair<std::string, int> student{"Alice", 22};
```

## Operations with std::pair

### Comparison

Pairs can be compared lexicographically - first elements are compared, and if equal, second elements are compared:

```cpp
#include <iostream>
#include <utility>

int main() {
    auto p1 = std::make_pair(10, 20);
    auto p2 = std::make_pair(10, 30);
    auto p3 = std::make_pair(20, 10);
    
    std::cout << "p1 < p2: " << (p1 < p2) << std::endl;  // true
    std::cout << "p1 < p3: " << (p1 < p3) << std::endl;  // true
    std::cout << "p2 < p3: " << (p2 < p3) << std::endl;  // false
    
    return 0;
}
```

### Assignment and Swapping

```cpp
#include <iostream>
#include <utility>

int main() {
    auto p1 = std::make_pair(1, "one");
    auto p2 = std::make_pair(2, "two");
    
    std::cout << "Before swap: " << p1.first << ", " << p1.second << std::endl;
    
    // Swapping pairs
    std::swap(p1, p2);
    // Alternatively: p1.swap(p2);
    
    std::cout << "After swap: " << p1.first << ", " << p1.second << std::endl;
    
    return 0;
}
```

## std::get

`std::get` is a function template that allows you to access tuple-like types by index. It works with `std::pair` as well:

```cpp
#include <iostream>
#include <utility>
#include <tuple>  // for std::get

int main() {
    auto person = std::make_pair("John", 25);
    
    // Using std::get instead of .first and .second
    std::cout << "Name: " << std::get<0>(person) << std::endl;
    std::cout << "Age: " << std::get<1>(person) << std::endl;
    
    // Advantage: type-safety with compile-time index checking
    // std::get<2>(person);  // Compile error: index out of bounds
    
    return 0;
}
```

The main advantage of `std::get` is that it provides compile-time index checking, unlike the `.first` and `.second` members which are fixed at implementation.

## Structured Bindings (C++17)

C++17 introduced structured bindings, which make working with pairs even more convenient:

```cpp
#include <iostream>
#include <utility>
#include <map>
#include <string>

int main() {
    auto person = std::make_pair("John", 25);
    
    // Decomposing the pair into separate variables
    auto [name, age] = person;
    std::cout << "Name: " << name << ", Age: " << age << std::endl;
    
    // Useful with map iteration
    std::map<std::string, double> prices = {
        {"Apple", 0.99},
        {"Banana", 0.59},
        {"Orange", 0.79}
    };
    
    for (const auto& [fruit, price] : prices) {
        std::cout << fruit << ": $" << price << std::endl;
    }
    
    return 0;
}
```

## std::ref

`std::ref` creates a wrapper that behaves like a reference when copied. This is particularly useful when working with function templates that normally copy their arguments:

```cpp
#include <iostream>
#include <functional>  // for std::ref
#include <utility>

template<typename T1, typename T2>
void showAndModify(T1 a, T2 b) {
    std::cout << "Values before: " << a << ", " << b << std::endl;
    a += 10;
    b += 10;
    std::cout << "Values inside: " << a << ", " << b << std::endl;
}

int main() {
    int x = 5, y = 5;
    
    // Without std::ref - passing by value
    std::cout << "Without std::ref:" << std::endl;
    showAndModify(x, y);
    std::cout << "Values after: " << x << ", " << y << std::endl;  // x and y unchanged
    
    // With std::ref - acts like a reference
    std::cout << "\nWith std::ref:" << std::endl;
    showAndModify(x, std::ref(y));
    std::cout << "Values after: " << x << ", " << y << std::endl;  // y is modified
    
    return 0;
}
```

### Using std::ref with std::pair

```cpp
#include <iostream>
#include <functional>
#include <utility>

int main() {
    int first = 10;
    int second = 20;
    
    // Creating a pair of references
    auto p = std::make_pair(std::ref(first), std::ref(second));
    
    // Modifying through the pair
    p.first += 5;
    p.second += 10;
    
    // Original values are modified
    std::cout << "first: " << first << std::endl;   // 15
    std::cout << "second: " << second << std::endl; // 30
    
    return 0;
}
```

## Practical Applications

### Return Multiple Values from a Function

```cpp
#include <iostream>
#include <utility>
#include <string>
#include <cmath>

// Return both the quotient and remainder
std::pair<int, int> divide(int dividend, int divisor) {
    int quotient = dividend / divisor;
    int remainder = dividend % divisor;
    return {quotient, remainder};  // Implicit conversion to pair
}

// Return success/failure status along with a value
std::pair<bool, double> safeSqrt(double x) {
    if (x < 0) {
        return {false, 0.0};  // Cannot compute sqrt of negative number
    }
    return {true, std::sqrt(x)};
}

int main() {
    // Example 1: Division with remainder
    auto [quot, rem] = divide(20, 3);
    std::cout << "20 ÷ 3 = " << quot << " remainder " << rem << std::endl;
    
    // Example 2: Safe operations
    double value = -4.0;
    auto [success, result] = safeSqrt(value);
    
    if (success) {
        std::cout << "Square root of " << value << " is " << result << std::endl;
    } else {
        std::cout << "Cannot compute square root of " << value << std::endl;
    }
    
    return 0;
}
```

### As a Map Entry

```cpp
#include <iostream>
#include <map>
#include <string>
#include <utility>

int main() {
    std::map<std::string, int> ages;
    
    // insert returns a pair<iterator, bool>
    auto result = ages.insert({"Alice", 30});
    
    if (result.second) {
        std::cout << "Inserted successfully" << std::endl;
        std::cout << "Key: " << result.first->first << std::endl;
        std::cout << "Value: " << result.first->second << std::endl;
    } else {
        std::cout << "Insertion failed - key already exists" << std::endl;
    }
    
    return 0;
}
```

## Performance Considerations

- `std::pair` is a lightweight container that incurs minimal overhead
- Passing large pairs by value causes copies - use references where appropriate
- Use `std::move` when transferring ownership of pairs with expensive elements

```cpp
#include <iostream>
#include <utility>
#include <string>
#include <vector>

int main() {
    std::vector<std::pair<std::string, std::vector<int>>> data;
    
    // Creating a potentially large pair
    std::string name = "Dataset_1";
    std::vector<int> values = {1, 2, 3, 4, 5, /* many more values */};
    
    // Inefficient way - copies both string and vector
    data.push_back(std::make_pair(name, values));
    
    // More efficient - moves the string and vector
    data.push_back(std::make_pair(std::move(name), std::move(values)));
    
    return 0;
}
```

## Conclusion

`std::pair` is a fundamental utility in C++ that simplifies storing and manipulating pairs of values. Combined with related utilities like `std::get` and `std::ref`, it becomes a powerful tool for writing clean, efficient, and expressive code. Modern C++ features like structured bindings make working with pairs even more convenient.

Key takeaways:
- Use `std::make_pair` for type deduction
- Consider `std::ref` when needing reference semantics
- Take advantage of structured bindings for cleaner code
- Remember that pairs are compared lexicographically
- Pairs are ideal for returning multiple values from functions
