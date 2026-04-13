# STL std::span | Modern C++ Series Ep. 115

## Introduction

`std::span` is a non-owning view over a contiguous sequence of objects, introduced in C++20. It provides a lightweight, non-owning reference to a contiguous sequence of objects, similar to string_view but for any contiguous data structure.

## Key Characteristics

- Non-owning (doesn't manage memory)
- Lightweight (typically just a pointer and a size)
- Works with any contiguous sequence (arrays, vectors, etc.)
- Available since C++20
- Header: `<span>`

## Core Benefits

- Avoids unnecessary copying
- Provides a unified interface for working with contiguous data
- Improves performance by eliminating deep copies
- Makes APIs more flexible and simpler

## Basic Usage

```cpp
#include <span>
#include <vector>
#include <iostream>
#include <array>

// Function that works with spans
void printElements(std::span<int> elements) {
    for (const auto& element : elements) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}

int main() {
    // Works with std::vector
    std::vector<int> vec = {1, 2, 3, 4, 5};
    printElements(vec);
    
    // Works with std::array
    std::array<int, 3> arr = {6, 7, 8};
    printElements(arr);
    
    // Works with C-style arrays
    int cArr[] = {9, 10, 11, 12};
    printElements(cArr);
    
    return 0;
}
```

## Creating Spans

```cpp
#include <span>
#include <vector>
#include <iostream>

int main() {
    // From vector
    std::vector<int> vec = {1, 2, 3, 4, 5};
    std::span<int> s1(vec);
    
    // From array
    int arr[] = {6, 7, 8, 9, 10};
    std::span<int> s2(arr, 5);
    
    // From pointer and size
    int* ptr = arr;
    std::span<int> s3(ptr, 3);
    
    // From subrange of vector
    std::span<int> s4(vec.data() + 1, 3);  // {2, 3, 4}
    
    return 0;
}
```

## Span Operations

```cpp
#include <span>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> vec = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::span<int> s(vec);
    
    // Size operations
    std::cout << "Size: " << s.size() << std::endl;
    std::cout << "Empty: " << s.empty() << std::endl;
    
    // Element access
    std::cout << "First: " << s.front() << std::endl;
    std::cout << "Last: " << s.back() << std::endl;
    std::cout << "Element at index 3: " << s[3] << std::endl;
    
    // Subviews
    std::span<int> first_half = s.first(5);  // {1, 2, 3, 4, 5}
    std::span<int> last_half = s.last(5);    // {6, 7, 8, 9, 10}
    std::span<int> middle = s.subspan(2, 4); // {3, 4, 5, 6}
    
    // Iterators
    for (auto it = s.begin(); it != s.end(); ++it) {
        // Modify through the span
        *it *= 2;
    }
    
    // Original vector is modified
    for (const auto& element : vec) {
        std::cout << element << " "; // Prints: 2 4 6 8 10 12 14 16 18 20
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Static vs Dynamic Spans

```cpp
#include <span>
#include <vector>
#include <iostream>

int main() {
    std::vector<int> vec = {1, 2, 3, 4, 5};
    
    // Dynamic extent (size known at runtime)
    std::span<int> dynamic_span(vec);
    
    // Static extent (size known at compile time)
    std::span<int, 5> static_span(vec);
    
    // This would cause a compilation error:
    // std::span<int, 6> wrong_size(vec);
    
    return 0;
}
```

## Const Spans

```cpp
#include <span>
#include <vector>

void readOnly(std::span<const int> elements) {
    // Cannot modify elements through this span
    // elements[0] = 100; // Compilation error
    
    for (const auto& e : elements) {
        // Read-only access is fine
    }
}

int main() {
    std::vector<int> vec = {1, 2, 3, 4, 5};
    
    // Non-const span allows modification
    std::span<int> mutable_span(vec);
    mutable_span[0] = 100;  // OK
    
    // Const span prevents modification
    std::span<const int> const_span(vec);
    // const_span[0] = 200;  // Compilation error
    
    // Pass to read-only function
    readOnly(vec);
    
    return 0;
}
```

## Real-world Example: Processing Matrix Rows

```cpp
#include <span>
#include <vector>
#include <iostream>

// Process a single row of a matrix
double sumRow(std::span<const double> row) {
    double sum = 0.0;
    for (const auto& element : row) {
        sum += element;
    }
    return sum;
}

// Process all rows in a matrix
std::vector<double> processMatrix(std::span<const double> matrix, int rows, int cols) {
    std::vector<double> rowSums;
    rowSums.reserve(rows);
    
    for (int i = 0; i < rows; ++i) {
        // Create a span for each row
        std::span<const double> row(matrix.data() + i * cols, cols);
        rowSums.push_back(sumRow(row));
    }
    
    return rowSums;
}

int main() {
    // Flat array representing a 3x4 matrix
    std::vector<double> matrix = {
        1.0, 2.0, 3.0, 4.0,  // Row 0
        5.0, 6.0, 7.0, 8.0,  // Row 1
        9.0, 10.0, 11.0, 12.0 // Row 2
    };
    
    auto rowSums = processMatrix(matrix, 3, 4);
    
    std::cout << "Row sums: ";
    for (const auto& sum : rowSums) {
        std::cout << sum << " ";  // Outputs: 10.0 26.0 42.0
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Best Practices

1. **Use for function parameters**: Prefer `std::span` over reference parameters for contiguous sequences
   ```cpp
   // Instead of this:
   void process(const std::vector<int>& vec);
   
   // Do this:
   void process(std::span<const int> elements);
   ```

2. **Use const for read-only access**: Use `std::span<const T>` when you don't need to modify elements

3. **Be careful with lifetimes**: Ensure the underlying data outlives the span
   ```cpp
   std::span<int> createSpan() {
       std::vector<int> vec = {1, 2, 3};
       return std::span<int>(vec);  // DANGER: returns span to destroyed vector
   }
   ```

4. **Avoid unnecessary copies**: The whole point of span is to avoid copies
   ```cpp
   // Don't do this:
   std::vector<int> vec_copy = std::vector<int>(my_span.begin(), my_span.end());
   
   // Instead, work directly with the span:
   for (auto& elem : my_span) {
       // Process elem directly
   }
   ```

5. **Use static extent when possible**: If you know the size at compile time, use static extent for better performance and safety

## Comparison with Other Approaches

| Approach | Ownership | Size | Usage |
|----------|-----------|------|-------|
| `std::span` | Non-owning | Fixed at runtime or compile-time | View of contiguous elements |
| Reference to container | Non-owning | Tied to specific container type | Container-specific operations |
| Pointer + size | Non-owning | Manual tracking | C-style, error-prone |
| `std::vector` | Owning | Dynamic | When ownership is needed |
| `std::array` | Owning | Fixed at compile-time | Fixed-size collection |

## Conclusion

`std::span` provides a modern, safe, and efficient way to work with contiguous sequences of objects without ownership semantics. It helps create more flexible APIs that can work with various container types while avoiding unnecessary copying of data.

When deciding whether to use `std::span`, consider:
- Do you need a view of contiguous elements without ownership?
- Do you want to make your functions work with different container types?
- Do you want to avoid copying data?

If the answer to these questions is yes, `std::span` is likely the right choice.
