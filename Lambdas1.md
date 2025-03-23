# C++ Lambdas Part 1: Unnamed Function Objects (Closures)

## Introduction
This markdown summarizes the key concepts from the video "C++ Lambdas Part 1 - Unnamed function objects (closures) in C++ | Modern Cpp Series Ep. 100". Lambda expressions are one of the most powerful features introduced in modern C++, enabling more concise and expressive functional programming patterns.

## What Are Lambda Expressions?

Lambda expressions (also called lambda functions or simply lambdas) are unnamed function objects that can be defined inline at the place where they are used. They provide a concise way to create simple function objects.

### Basic Syntax

```cpp
[capture-list](parameters) -> return_type { function_body }
```

Where:
- `capture-list`: Variables from the surrounding scope that the lambda can access
- `parameters`: Function parameters (optional)
- `return_type`: The return type (optional, can be auto-deduced)
- `function_body`: The code to execute

## Simple Lambda Example

```cpp
#include <iostream>

int main() {
    // A simple lambda that takes no parameters and returns nothing
    auto sayHello = []() {
        std::cout << "Hello, Lambda!" << std::endl;
    };
    
    // Call the lambda
    sayHello();  // Output: Hello, Lambda!
    
    return 0;
}
```

## Lambda with Parameters

```cpp
#include <iostream>

int main() {
    // Lambda with parameters
    auto add = [](int a, int b) {
        return a + b;
    };
    
    int sum = add(3, 4);
    std::cout << "Sum: " << sum << std::endl;  // Output: Sum: 7
    
    return 0;
}
```

## Capture Clauses

Lambdas can "capture" variables from their surrounding scope:

### Capture by Value

```cpp
#include <iostream>

int main() {
    int x = 10;
    
    // Capture x by value
    auto printX = [x]() {
        std::cout << "x: " << x << std::endl;
    };
    
    printX();  // Output: x: 10
    
    // Changing x after lambda definition doesn't affect the lambda
    x = 20;
    printX();  // Still outputs: x: 10
    
    return 0;
}
```

### Capture by Reference

```cpp
#include <iostream>

int main() {
    int x = 10;
    
    // Capture x by reference
    auto printAndModifyX = [&x]() {
        x += 5;  // Modifies the original x
        std::cout << "x inside lambda: " << x << std::endl;
    };
    
    printAndModifyX();  // Output: x inside lambda: 15
    std::cout << "x after lambda call: " << x << std::endl;  // Output: x after lambda call: 15
    
    return 0;
}
```

### Default Capture

```cpp
#include <iostream>

int main() {
    int a = 1, b = 2, c = 3;
    
    // Capture all variables by value
    auto byValue = [=]() {
        std::cout << a << b << c << std::endl;
    };
    
    // Capture all variables by reference
    auto byRef = [&]() {
        a *= 10;
        b *= 10;
        c *= 10;
    };
    
    byValue();  // Output: 123
    byRef();
    std::cout << a << b << c << std::endl;  // Output: 102030
    
    return 0;
}
```

### Mixed Capture

```cpp
#include <iostream>

int main() {
    int a = 1, b = 2, c = 3;
    
    // Capture a and b by value, c by reference
    auto mixed = [a, b, &c]() {
        // a and b cannot be modified
        // c can be modified
        c = a + b + c;
    };
    
    mixed();
    std::cout << "c after lambda: " << c << std::endl;  // Output: c after lambda: 6
    
    return 0;
}
```

## Mutable Lambdas

By default, a lambda cannot modify variables captured by value. The `mutable` keyword allows this:

```cpp
#include <iostream>

int main() {
    int counter = 0;
    
    // Without mutable - this would cause a compilation error
    // auto increment = [counter]() { counter++; }; // Error!
    
    // With mutable - can modify the captured copy
    auto increment = [counter]() mutable {
        counter++;
        std::cout << "Counter inside lambda: " << counter << std::endl;
    };
    
    increment();  // Output: Counter inside lambda: 1
    increment();  // Output: Counter inside lambda: 2
    
    // The original counter is unchanged
    std::cout << "Original counter: " << counter << std::endl;  // Output: Original counter: 0
    
    return 0;
}
```

## Using Lambdas with STL Algorithms

Lambdas are particularly useful with STL algorithms:

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    
    // Count even numbers using a lambda
    int evenCount = std::count_if(numbers.begin(), numbers.end(), 
                                  [](int n) { return n % 2 == 0; });
    
    std::cout << "Number of even integers: " << evenCount << std::endl;  // Output: 5
    
    // Transform each element using a lambda
    std::transform(numbers.begin(), numbers.end(), numbers.begin(), 
                   [](int n) { return n * n; });
    
    std::cout << "Squares: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    // Output: Squares: 1 4 9 16 25 36 49 64 81 100
    
    return 0;
}
```

## Immediately Invoked Lambda Expressions (IILE)

Lambdas can be defined and called immediately:

```cpp
#include <iostream>

int main() {
    int result = [](int x, int y) {
        return x * y;
    }(6, 7);  // Called immediately with arguments 6 and 7
    
    std::cout << "Result: " << result << std::endl;  // Output: Result: 42
    
    // Useful for complex initialization
    const auto complexValue = []() {
        // Complex initialization logic here
        double value = 0;
        for (int i = 0; i < 10; i++) {
            value += i * 3.14;
        }
        return value;
    }();
    
    std::cout << "Complex value: " << complexValue << std::endl;
    
    return 0;
}
```

## Benefits of Lambda Expressions

1. **Conciseness**: Allows defining functions inline where they're used
2. **Readability**: Keeps related code together
3. **Performance**: Can lead to better optimization by the compiler
4. **Expressiveness**: Makes functional programming patterns more accessible
5. **Closure capability**: Can capture and use local variables

## Common Use Cases

1. **Custom comparators**
2. **Callback functions**
3. **STL algorithm predicates**
4. **Event handlers**
5. **One-time function definitions**

## Conclusion

Lambda expressions are a powerful feature in modern C++ that enable more concise and expressive code, particularly when working with algorithms and functional programming patterns. They provide a way to define unnamed function objects inline, making code more readable and maintainable by keeping related logic together.
