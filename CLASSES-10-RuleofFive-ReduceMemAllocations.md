# Rule of Five in C++: Memory Management and Move Semantics

This document summarizes the "Rule of Five" in C++ as explained in Mike Shah's video, focusing on the `IntArray` class example. The Rule of Five is crucial for efficient memory and resource management in C++ classes, especially when dealing with dynamic memory allocation.

[[CPP]]
https://youtu.be/2U1eHurVnXE

## Understanding the Rule of Five

The Rule of Five, also known as the "Law of Five" or "Big Five," expands upon the earlier "Rule of Three" (or "Big Three"). It encompasses five special member functions that are essential for classes managing their own resources (like dynamically allocated memory):

1.  **Constructor:** Initializes objects and allocates necessary resources.
2.  **Destructor:** Releases resources acquired by the object, preventing memory leaks.
3.  **Copy Constructor:** Creates a new object as a distinct copy of an existing object (deep copy).
4.  **Copy Assignment Operator:**  Handles assignment from one existing object to another, ensuring proper deep copying and resource management.
5.  **Move Constructor:** Transfers resources from a temporary or expiring object to a new object (move semantics), avoiding expensive deep copies.
6.  **Move Assignment Operator:** Transfers resources from a temporary or expiring object to an existing object (move semantics), optimizing assignment operations.

Move semantics (move constructor and move assignment operator), introduced in C++11, are designed to improve performance by reducing unnecessary copying, especially when dealing with temporary objects.

## C++ Code Example: `IntArray` Class

Below is the C++ code example demonstrating the Rule of Five with an `IntArray` class that manages a dynamically allocated integer array:

```cpp
#include <iostream>
#include <algorithm> // std::copy
#include <vector>

class IntArray {
private:
    int* data;
    size_t size;

public:
    // Constructor
    IntArray(size_t size) : size(size) {
        data = new int[size];
        for (size_t i = 0; i < size; ++i) {
            data[i] = 0; // Initialize to 0
        }
        std::cout << "Constructor called for size: " << size << std::endl;
    }

    // Destructor
    ~IntArray() {
        delete[] data;
        std::cout << "Destructor called for size: " << size << std::endl;
    }

    // Copy Constructor
    IntArray(const IntArray& other) : size(other.size) {
        data = new int[size];
        std::copy(other.data, other.data + size, data);
        std::cout << "Copy Constructor called for size: " << size << std::endl;
    }

    // Copy Assignment Operator
    IntArray& operator=(const IntArray& other) {
        std::cout << "Copy Assignment Operator called" << std::endl;
        if (this == &other) {
            return *this; // Handle self-assignment
        }
        delete[] data; // Free existing memory
        size = other.size;
        data = new int[size];
        std::copy(other.data, other.data + size, data);
        return *this;
    }

    // Move Constructor
    IntArray(IntArray&& other) noexcept : data(other.data), size(other.size) {
        std::cout << "Move Constructor called for size: " << size << std::endl;
        other.data = nullptr; // Prevent double deletion
        other.size = 0;
    }

    // Move Assignment Operator
    IntArray& operator=(IntArray&& other) noexcept {
        std::cout << "Move Assignment Operator called" << std::endl;
        if (this == &other) {
            return *this; // Handle self-assignment
        }
        delete[] data; // Free existing memory
        data = other.data;  // Steal the data
        size = other.size;
        other.data = nullptr; // Prevent double deletion
        other.size = 0;
        return *this;
    }


    size_t getSize() const { return size; }
    int& operator[](size_t index) { return data[index]; }
    const int& operator[](size_t index) const { return data[index]; }
};

int main() {
    std::vector<IntArray> arrays;
    for (size_t i = 1; i <= 5; ++i) {
        std::cout << "--- Iteration " << i << " ---" << std::endl;
        arrays.push_back(IntArray(i * 1000)); // Demonstrates move semantics in push_back
    }

    IntArray a(5);
    IntArray b = a; // Copy constructor
    IntArray c(10);
    c = a;        // Copy assignment

    IntArray d = std::move(a); // Move constructor
    IntArray e(20);
    e = std::move(c);         // Move assignment

    return 0;
}
