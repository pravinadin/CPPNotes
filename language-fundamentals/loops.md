# Modern C++ Loop Constructs and std::fill

This document summarizes the key loop constructs and std::fill functionality covered in "For-loop, ranged based for-loop, while, do-while, and std::fill | Modern Cpp Series Ep. 14".

## Table of Contents
1. [Traditional For Loop](#traditional-for-loop)
2. [Range-based For Loop](#range-based-for-loop)
3. [While Loop](#while-loop)
4. [Do-While Loop](#do-while-loop)
5. [std::fill](#stdfill)
6. [Best Practices](#best-practices)

## Traditional For Loop

The classic C-style for loop consists of three components:
- Initialization (executed once at the beginning)
- Condition (checked before each iteration)
- Iteration expression (executed after each loop)

```cpp
#include <iostream>
#include <vector>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    
    // Traditional for loop with index
    for (int i = 0; i < numbers.size(); ++i) {
        std::cout << "Element at index " << i << ": " << numbers[i] << std::endl;
    }
    
    // For loop with iterator
    for (std::vector<int>::iterator it = numbers.begin(); it != numbers.end(); ++it) {
        std::cout << "Element: " << *it << std::endl;
    }
    
    return 0;
}
```

### Use Cases:
- When you need access to the index during iteration
- When you need fine-grained control over the iteration process
- When you need to iterate in non-standard ways (e.g., skipping elements, backwards)

## Range-based For Loop

Introduced in C++11, the range-based for loop simplifies iteration over collections.

```cpp
#include <iostream>
#include <vector>
#include <string>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    
    // Basic range-based for loop
    for (int num : numbers) {
        std::cout << "Number: " << num << std::endl;
    }
    
    // Using auto for type deduction
    for (auto num : numbers) {
        std::cout << "Number: " << num << std::endl;
    }
    
    // Using reference to avoid copy
    for (const auto& num : numbers) {
        std::cout << "Number: " << num << std::endl;
    }
    
    // With a string container
    std::vector<std::string> fruits = {"apple", "banana", "cherry"};
    for (const auto& fruit : fruits) {
        std::cout << "Fruit: " << fruit << std::endl;
    }
    
    return 0;
}
```

### Use Cases:
- When you need to iterate through all elements in a collection
- When you don't need the index of elements
- For cleaner, more readable code

## While Loop

The while loop continues execution as long as a specified condition is true.

```cpp
#include <iostream>
#include <vector>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    
    // Basic while loop with index
    int i = 0;
    while (i < numbers.size()) {
        std::cout << "Element at index " << i << ": " << numbers[i] << std::endl;
        ++i;
    }
    
    // While loop with iterator
    auto it = numbers.begin();
    while (it != numbers.end()) {
        std::cout << "Element: " << *it << std::endl;
        ++it;
    }
    
    // Input validation example
    int input = 0;
    while (input <= 0) {
        std::cout << "Enter a positive number: ";
        std::cin >> input;
    }
    std::cout << "You entered: " << input << std::endl;
    
    return 0;
}
```

### Use Cases:
- When the number of iterations is not known beforehand
- When the loop condition depends on external factors
- For input validation

## Do-While Loop

Similar to the while loop, but guarantees at least one execution of the loop body.

```cpp
#include <iostream>

int main() {
    // Basic do-while loop
    int i = 0;
    do {
        std::cout << "i = " << i << std::endl;
        ++i;
    } while (i < 5);
    
    // Input validation with do-while
    int input;
    do {
        std::cout << "Enter a positive number: ";
        std::cin >> input;
    } while (input <= 0);
    std::cout << "You entered: " << input << std::endl;
    
    // Loop that always executes at least once, even if condition is false
    int x = 10;
    do {
        std::cout << "This will print once even though the condition is false" << std::endl;
    } while (x < 5);
    
    return 0;
}
```

### Use Cases:
- When you need to execute the loop body at least once
- For menu systems where user input is processed after showing options
- For input validation where prompting happens before checking

## std::fill

A standard library algorithm that assigns a specific value to a range of elements.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <array>

int main() {
    // Fill a vector
    std::vector<int> vec(10);
    std::fill(vec.begin(), vec.end(), 42);
    
    std::cout << "Vector filled with 42:" << std::endl;
    for (const auto& num : vec) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Fill a portion of an array
    std::array<int, 10> arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::fill(arr.begin() + 2, arr.begin() + 7, 99);
    
    std::cout << "Array with middle filled with 99:" << std::endl;
    for (const auto& num : arr) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Fill a C-style array
    int cArray[5];
    std::fill(std::begin(cArray), std::end(cArray), -1);
    
    std::cout << "C-style array filled with -1:" << std::endl;
    for (const auto& num : cArray) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

### Use Cases:
- Initializing containers with a default value
- Resetting or clearing portions of a container
- Setting all elements to a specific value efficiently

## Best Practices

1. **Choose the right loop for the job:**
   - Use range-based for loops when iterating over all elements
   - Use traditional for loops when you need indices
   - Use while loops when the number of iterations is unknown
   - Use do-while when you need at least one iteration

2. **Use auto for type deduction** in range-based for loops:
   ```cpp
   for (const auto& element : container) { ... }
   ```

3. **Use references to avoid unnecessary copying:**
   ```cpp
   // For read-only access:
   for (const auto& element : container) { ... }
   
   // For modifying elements:
   for (auto& element : container) {
       element *= 2;  // Modify the actual element, not a copy
   }
   ```

4. **Prefer algorithm functions** like `std::fill`, `std::transform`, etc., over manual loops when possible for better readability and optimization.

5. **Be careful with loop termination conditions** to avoid off-by-one errors or infinite loops.

6. **Consider loop performance:**
   - Range-based for loops generally have the same performance as traditional for loops but with cleaner syntax
   - Avoid expensive operations in loop conditions
   - Be mindful of container access patterns (e.g., row-major vs. column-major for matrices)
