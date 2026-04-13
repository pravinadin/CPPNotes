# STL std::array (Since C++11)

`std::array` is a container that encapsulates fixed-size arrays introduced in C++11. It's part of the Standard Template Library (STL) and provides the benefits of both C-style arrays and STL containers.

## Key Features

1. **Fixed-size container**: Size is specified at compile time and cannot change
2. **Stack allocation**: Unlike `std::vector`, memory is allocated on the stack by default
3. **Zero overhead**: Provides the same performance as a C-style array with additional safety features
4. **STL container interface**: Provides STL container functionality like iterators, algorithms support
5. **Bound checking**: Offers bounds checking via the `at()` method

## Basic Usage

```cpp
#include <array>
#include <iostream>

int main() {
    // Declaration and initialization
    std::array<int, 5> arr1 = {1, 2, 3, 4, 5};
    
    // Alternative initialization syntax
    std::array<int, 5> arr2{1, 2, 3, 4, 5};
    
    // Default initialization (all elements are value-initialized)
    std::array<int, 3> arr3{}; // All elements initialized to 0
    
    // Accessing elements
    std::cout << "First element: " << arr1[0] << std::endl;
    std::cout << "Second element: " << arr1.at(1) << std::endl;
    
    // Bounds-checked access (throws std::out_of_range if index is invalid)
    try {
        std::cout << arr1.at(10) << std::endl; // Will throw an exception
    } catch (const std::out_of_range& e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    return 0;
}
```

## Common Operations

### Size and Capacity

```cpp
#include <array>
#include <iostream>

int main() {
    std::array<double, 4> values = {3.14, 2.71, 1.62, 1.41};
    
    std::cout << "Size: " << values.size() << std::endl;         // 4
    std::cout << "Max size: " << values.max_size() << std::endl; // 4 (same as size)
    std::cout << "Empty: " << values.empty() << std::endl;       // 0 (false)
    
    return 0;
}
```

### Element Access

```cpp
#include <array>
#include <iostream>

int main() {
    std::array<char, 5> chars = {'a', 'b', 'c', 'd', 'e'};
    
    // Different ways to access elements
    std::cout << "Front: " << chars.front() << std::endl;   // 'a'
    std::cout << "Back: " << chars.back() << std::endl;     // 'e'
    std::cout << "Index 2: " << chars[2] << std::endl;      // 'c'
    std::cout << "At(3): " << chars.at(3) << std::endl;     // 'd'
    
    // Get underlying array (pointer to first element)
    const char* data = chars.data();
    std::cout << "Data[1]: " << data[1] << std::endl;       // 'b'
    
    return 0;
}
```

### Iterating Through an Array

```cpp
#include <array>
#include <iostream>
#include <algorithm>

int main() {
    std::array<int, 5> numbers = {10, 20, 30, 40, 50};
    
    // Using range-based for loop (C++11)
    std::cout << "Using range-based for loop: ";
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Using iterators
    std::cout << "Using iterators: ";
    for (auto it = numbers.begin(); it != numbers.end(); ++it) {
        std::cout << *it << " ";
    }
    std::cout << std::endl;
    
    // Using STL algorithms
    std::cout << "Using for_each algorithm: ";
    std::for_each(numbers.begin(), numbers.end(), [](int n) {
        std::cout << n << " ";
    });
    std::cout << std::endl;
    
    return 0;
}
```

### Modifying Elements

```cpp
#include <array>
#include <iostream>
#include <algorithm>

int main() {
    std::array<int, 5> numbers = {1, 2, 3, 4, 5};
    
    // Modify individual elements
    numbers[0] = 10;
    numbers.at(1) = 20;
    
    // Fill the entire array with a value
    numbers.fill(42);
    
    std::cout << "After fill: ";
    for (const auto& num : numbers) {
        std::cout << num << " "; // 42 42 42 42 42
    }
    std::cout << std::endl;
    
    // Modify using algorithms
    std::array<int, 5> vals = {5, 4, 3, 2, 1};
    std::sort(vals.begin(), vals.end());
    
    std::cout << "After sort: ";
    for (const auto& val : vals) {
        std::cout << val << " "; // 1 2 3 4 5
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Advantages Over C-style Arrays

1. **Size awareness**: `std::array` knows its own size
2. **Safety**: Provides bounds checking via the `at()` method
3. **STL compatibility**: Works with STL algorithms
4. **No decay to pointers**: When passed to functions, maintains its type
5. **Aggregate initialization**: Can be initialized like C-style arrays

```cpp
#include <array>
#include <iostream>

// Function accepting std::array by reference
template <std::size_t N>
void printArray(const std::array<int, N>& arr) {
    std::cout << "Array size: " << arr.size() << std::endl;
    for (const auto& element : arr) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    // C-style array
    int cArr[5] = {1, 2, 3, 4, 5};
    
    // std::array
    std::array<int, 5> stdArr = {1, 2, 3, 4, 5};
    
    // With C-style arrays, size information is lost when passed to functions
    // With std::array, size information is preserved
    printArray(stdArr);
    
    return 0;
}
```

## Use Cases and Best Practices

### When to Use `std::array`

1. When you need a fixed-size collection with stack allocation
2. When you want the performance of a C-style array with STL container benefits
3. As a safer alternative to C-style arrays

### When Not to Use `std::array`

1. When you need a dynamically resizable container (use `std::vector` instead)
2. When the size is only known at runtime (use `std::vector`)

### Best Practices

1. Use `auto` with iterators for better readability
2. Use `at()` when bounds checking is needed
3. Use `std::get<N>()` for accessing elements when the index is known at compile time (for better type safety)

```cpp
#include <array>
#include <iostream>
#include <tuple>

int main() {
    std::array<int, 3> arr = {1, 2, 3};
    
    // Using std::get (compile-time index checking)
    std::cout << "Element 0: " << std::get<0>(arr) << std::endl;
    std::cout << "Element 1: " << std::get<1>(arr) << std::endl;
    std::cout << "Element 2: " << std::get<2>(arr) << std::endl;
    
    // This would cause a compile error:
    // std::cout << std::get<3>(arr) << std::endl;
    
    return 0;
}
```

## Working with Multi-dimensional Arrays

```cpp
#include <array>
#include <iostream>

int main() {
    // 2D array: 3 rows × 4 columns
    std::array<std::array<int, 4>, 3> matrix = {{
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    }};
    
    // Accessing elements
    std::cout << "Element at [1][2]: " << matrix[1][2] << std::endl; // 7
    
    // Iterating through the 2D array
    for (const auto& row : matrix) {
        for (const auto& element : row) {
            std::cout << element << " ";
        }
        std::cout << std::endl;
    }
    
    return 0;
}
```

## Performance Considerations

- `std::array` has no performance overhead compared to C-style arrays
- Element access with `operator[]` has the same performance as C-style arrays
- Using `at()` adds bounds checking overhead but improves safety
- Being stack-allocated makes it faster for small arrays compared to heap-allocated containers

## Summary

`std::array` provides a safer, more convenient alternative to C-style arrays while maintaining the same performance characteristics. It combines the efficiency of fixed-size arrays with the interface benefits of STL containers, making it an essential tool in modern C++ programming.
