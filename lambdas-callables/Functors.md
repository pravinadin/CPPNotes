# Functors in Modern C++: Summary of Modern C++ Series Ep. 99

## Introduction to Functors

Functors (function objects) are objects that can be called like functions. Unlike regular functions, functors can maintain state between calls, making them a powerful tool in C++ programming.

## What Are Functors?

A functor is any object that overloads the function call operator `operator()`. This allows the object to be used with the same syntax as a function call.

```cpp
class MyFunctor {
public:
    // Function call operator
    int operator()(int x) const {
        return x * x;
    }
};

int main() {
    MyFunctor square;
    
    // Using the functor like a function
    int result = square(5);  // result = 25
    
    return 0;
}
```

## Key Advantages of Functors

### 1. Maintaining State

Unlike traditional functions, functors can store state between function calls:

```cpp
class Counter {
private:
    int count = 0;
    
public:
    int operator()() {
        return ++count;
    }
    
    void reset() {
        count = 0;
    }
};

int main() {
    Counter counter;
    
    std::cout << counter() << std::endl;  // Outputs: 1
    std::cout << counter() << std::endl;  // Outputs: 2
    std::cout << counter() << std::endl;  // Outputs: 3
    
    counter.reset();
    std::cout << counter() << std::endl;  // Outputs: 1
    
    return 0;
}
```

### 2. Customization Through Construction

Functors can be initialized with parameters to customize their behavior:

```cpp
class Multiplier {
private:
    int factor;
    
public:
    Multiplier(int f) : factor(f) {}
    
    int operator()(int x) const {
        return x * factor;
    }
};

int main() {
    Multiplier times2(2);
    Multiplier times10(10);
    
    std::cout << times2(5) << std::endl;    // Outputs: 10
    std::cout << times10(5) << std::endl;   // Outputs: 50
    
    return 0;
}
```

### 3. Type Information

Functors carry their own type information, unlike function pointers:

```cpp
// Function pointer example
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

// Functor example
struct Add {
    int operator()(int a, int b) const { return a + b; }
};

struct Subtract {
    int operator()(int a, int b) const { return a - b; }
};

// Function that takes a function pointer
template<typename T>
void processWithFunctionPtr(T func, int a, int b) {
    std::cout << func(a, b) << std::endl;
}

// Function that takes a functor
template<typename Functor>
void processWithFunctor(Functor func, int a, int b) {
    std::cout << func(a, b) << std::endl;
}

int main() {
    // Using function pointers
    processWithFunctionPtr(add, 5, 3);      // Outputs: 8
    processWithFunctionPtr(subtract, 5, 3); // Outputs: 2
    
    // Using functors
    processWithFunctor(Add(), 5, 3);        // Outputs: 8
    processWithFunctor(Subtract(), 5, 3);   // Outputs: 2
    
    return 0;
}
```

## Functors in the Standard Library

The C++ Standard Library uses functors extensively:

### 1. Predefined Functors

```cpp
#include <functional>
#include <iostream>

int main() {
    std::plus<int> add;
    std::minus<int> subtract;
    std::multiplies<int> multiply;
    
    std::cout << add(5, 3) << std::endl;       // Outputs: 8
    std::cout << subtract(5, 3) << std::endl;  // Outputs: 2
    std::cout << multiply(5, 3) << std::endl;  // Outputs: 15
    
    return 0;
}
```

### 2. Using Functors with Algorithms

```cpp
#include <algorithm>
#include <vector>
#include <iostream>
#include <functional>

class IsGreaterThan {
private:
    int threshold;
    
public:
    IsGreaterThan(int t) : threshold(t) {}
    
    bool operator()(int value) const {
        return value > threshold;
    }
};

int main() {
    std::vector<int> v = {1, 3, 5, 7, 9, 2, 4, 6, 8, 10};
    
    // Count elements greater than 5
    int count = std::count_if(v.begin(), v.end(), IsGreaterThan(5));
    std::cout << "Count of elements > 5: " << count << std::endl;
    
    // Sort in descending order using std::greater
    std::sort(v.begin(), v.end(), std::greater<int>());
    
    std::cout << "Sorted vector: ";
    for (int i : v) {
        std::cout << i << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Comparison with Lambda Functions

Modern C++ offers lambda functions as an alternative to functors for creating inline function objects:

```cpp
#include <algorithm>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> v = {1, 3, 5, 7, 9, 2, 4, 6, 8, 10};
    
    // Using a functor
    class IsGreaterThan5 {
    public:
        bool operator()(int value) const {
            return value > 5;
        }
    };
    
    int count1 = std::count_if(v.begin(), v.end(), IsGreaterThan5());
    
    // Using a lambda
    int threshold = 5;
    int count2 = std::count_if(v.begin(), v.end(), 
                              [threshold](int value) { return value > threshold; });
    
    std::cout << "Count using functor: " << count1 << std::endl;
    std::cout << "Count using lambda: " << count2 << std::endl;
    
    return 0;
}
```

## Advanced Functor Techniques

### 1. Stateful Lambda Functions (C++14 and later)

```cpp
#include <iostream>

int main() {
    // Lambda with captured state
    int counter = 0;
    auto increment = [counter]() mutable { 
        return ++counter; 
    };
    
    std::cout << increment() << std::endl;  // Outputs: 1
    std::cout << increment() << std::endl;  // Outputs: 2
    std::cout << counter << std::endl;      // Outputs: 0 (original counter)
    
    return 0;
}
```

### 2. Creating a Generic Functor

```cpp
template<typename T>
class Accumulator {
private:
    T total;
    
public:
    Accumulator(T start = T{}) : total(start) {}
    
    T operator()(T value) {
        total += value;
        return total;
    }
    
    T getTotal() const {
        return total;
    }
};

int main() {
    Accumulator<int> intAccum;
    std::cout << intAccum(5) << std::endl;    // Outputs: 5
    std::cout << intAccum(10) << std::endl;   // Outputs: 15
    
    Accumulator<std::string> strAccum;
    std::cout << strAccum("Hello") << std::endl;          // Outputs: Hello
    std::cout << strAccum(" World") << std::endl;         // Outputs: Hello World
    
    return 0;
}
```

## Performance Considerations

Functors can be more efficient than function pointers because:

1. They allow for inlining, which can lead to better optimization
2. They avoid the overhead of indirect function calls
3. They can be optimized by the compiler based on their specific type

## When to Use Functors vs. Alternatives

- **Functors**: When you need to maintain state between calls or require customizable behavior through class members
- **Function Pointers**: For simple function callbacks without state
- **Lambda Functions**: For quick, inline function objects (especially when stateless)
- **std::function**: When you need type erasure and flexibility in function storage

## Conclusion

Functors in C++ provide a powerful way to create callable objects that can maintain state. They are widely used in the standard library and form the foundation for many modern C++ features like lambda functions. Understanding functors is essential for effective use of C++ algorithms and creating clean, efficient code.
