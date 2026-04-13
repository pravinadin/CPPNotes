# STL std::unordered_set & generate_n Summary

## Overview
This document summarizes the key concepts from "STL std::unordered_set (std::algorithm generate_n for creation of sets) | Modern Cpp Series Ep. 122". The video covers how to use `std::unordered_set` in C++ and demonstrates how to populate it using the `std::generate_n` algorithm.

## What is std::unordered_set?

`std::unordered_set` is a container in the C++ Standard Template Library (STL) that:

- Stores unique elements (no duplicates allowed)
- Uses a hash table for implementation (O(1) average case lookup)
- Does not maintain any specific order of elements
- Is part of the `<unordered_set>` header

Unlike `std::set` which uses a balanced binary tree (typically red-black tree) and maintains elements in sorted order, `std::unordered_set` offers faster lookups at the cost of not maintaining element order.

## Basic Usage

### Including the Header

```cpp
#include <iostream>
#include <unordered_set>
```

### Creating an Unordered Set

```cpp
// Empty set of integers
std::unordered_set<int> numbers;

// Initializer list construction
std::unordered_set<std::string> fruits = {"apple", "banana", "orange"};
```

### Key Operations

```cpp
std::unordered_set<int> set = {1, 2, 3, 4, 5};

// Insertion
set.insert(6);        // Insert single element
set.insert({7, 8, 9}); // Insert multiple elements

// Check if element exists
if(set.count(5)) {
    std::cout << "5 exists in the set" << std::endl;
}
// Alternative using find
if(set.find(5) != set.end()) {
    std::cout << "5 exists in the set" << std::endl;
}

// Removing elements
set.erase(3);  // Remove by value

// Size
std::cout << "Set size: " << set.size() << std::endl;

// Clear all elements
set.clear();
```

## Using generate_n to Create Sets

The video demonstrates how to use `std::generate_n` to populate a set with unique random numbers.

```cpp
#include <iostream>
#include <unordered_set>
#include <algorithm>
#include <random>
#include <iterator>

int main() {
    std::unordered_set<int> random_numbers;
    
    // Create random number generator
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> distrib(1, 100);
    
    // Generate 20 unique random numbers
    std::generate_n(
        std::inserter(random_numbers, random_numbers.begin()),
        20,
        [&gen, &distrib]() {
            return distrib(gen);
        }
    );
    
    // Print the unique random numbers
    for(const auto& num : random_numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

### Explanation of the generate_n Example:

1. We create an empty `std::unordered_set<int>` called `random_numbers`
2. We set up a random number generator using `std::mt19937` and a uniform distribution between 1 and 100
3. We use `std::generate_n` to populate the set with:
   - The first parameter is an iterator where we want to insert elements (`std::inserter`)
   - The second parameter is how many elements we want to generate (20)
   - The third parameter is a generator function (lambda) that returns random numbers
4. Since `unordered_set` only keeps unique values, duplicate random numbers are automatically discarded
5. Note that the set might contain fewer than 20 numbers if duplicates were generated

## Differences Between set and unordered_set

| Feature | std::set | std::unordered_set |
|---------|----------|-----------------|
| Implementation | Balanced Binary Tree | Hash Table |
| Ordering | Sorted (ascending) | No specific order |
| Lookup Time | O(log n) | O(1) average, O(n) worst case |
| Insertion Time | O(log n) | O(1) average, O(n) worst case |
| Memory Usage | Lower | Higher (hash table overhead) |
| Iterator Stability | Yes | No (rehashing invalidates) |

## Custom Types in unordered_set

To use custom types in an `unordered_set`, you need to provide:

1. A hash function
2. An equality operator

```cpp
#include <iostream>
#include <unordered_set>
#include <string>

struct Person {
    std::string name;
    int age;
    
    // Equality operator
    bool operator==(const Person& other) const {
        return name == other.name && age == other.age;
    }
};

// Custom hash function
namespace std {
    template<>
    struct hash<Person> {
        size_t operator()(const Person& p) const {
            // Combine the hash of name and age
            return hash<string>()(p.name) ^ hash<int>()(p.age);
        }
    };
}

int main() {
    std::unordered_set<Person> people;
    
    people.insert({"Alice", 30});
    people.insert({"Bob", 25});
    people.insert({"Alice", 30}); // This will be ignored (duplicate)
    
    std::cout << "Set size: " << people.size() << std::endl; // Output: 2
    
    return 0;
}
```

## Performance Considerations

- `unordered_set` is generally faster for lookups than `set`
- The performance of `unordered_set` depends on:
  - Quality of the hash function
  - Load factor (ratio of elements to buckets)
- You can control the load factor:
  ```cpp
  std::unordered_set<int> numbers;
  std::cout << "Load factor: " << numbers.load_factor() << std::endl;
  std::cout << "Max load factor: " << numbers.max_load_factor() << std::endl;
  
  // Set custom max load factor
  numbers.max_load_factor(0.7f);
  
  // Reserve space for elements (buckets)
  numbers.reserve(1000);
  ```

## Common Pitfalls

1. Modifying elements while they're in the set (can corrupt the hash table)
2. Using a poor hash function (causes collisions and degrades performance)
3. Forgetting that elements have no defined order
4. Iterators becoming invalid after rehashing

## Conclusion

`std::unordered_set` is a powerful container for storing unique elements with fast lookup times. Combined with algorithms like `std::generate_n`, it provides an efficient way to generate and store unique values.

The choice between `std::set` and `std::unordered_set` depends on whether you need ordered elements (use `set`) or faster lookups (use `unordered_set`).
