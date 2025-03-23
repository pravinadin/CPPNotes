# STL std::unordered_multimap (C++11)

## Introduction

The `std::unordered_multimap` is a container introduced in C++11 that:

- Stores key-value pairs where multiple entries can have the same key
- Provides fast lookups using hash tables (average O(1) complexity)
- Does not maintain any specific order of elements
- Is part of the C++ Standard Template Library (STL)

## Key Characteristics

- **Multiple Keys**: Unlike `unordered_map`, it allows multiple elements with the same key
- **Hashing**: Uses hash functions for fast lookups
- **No Ordering**: Elements are not sorted in any particular order
- **Dynamic Size**: Automatically resizes as elements are added or removed
- **Template-Based**: Can work with any data types as keys and values

## Basic Usage

```cpp
#include <iostream>
#include <unordered_map>
#include <string>

int main() {
    // Create an unordered_multimap with string keys and int values
    std::unordered_multimap<std::string, int> scores;
    
    // Insert elements
    scores.insert({"Alice", 95});
    scores.insert({"Bob", 89});
    scores.insert({"Alice", 92});  // Another entry for Alice
    scores.insert({"Charlie", 78});
    scores.insert({"Bob", 91});    // Another entry for Bob
    
    // Print all elements
    std::cout << "All scores:" << std::endl;
    for (const auto& pair : scores) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    
    return 0;
}
```

## Common Operations

### Insertion

```cpp
// Method 1: Using insert with std::pair
scores.insert(std::make_pair("David", 88));

// Method 2: Using insert with initializer list
scores.insert({"Eva", 94});

// Method 3: Using emplace (more efficient)
scores.emplace("Frank", 76);
```

### Lookup

```cpp
// Find all elements with a specific key
std::string student = "Alice";
auto range = scores.equal_range(student);

std::cout << "Scores for " << student << ":" << std::endl;
for (auto it = range.first; it != range.second; ++it) {
    std::cout << it->second << std::endl;
}

// Count elements with a specific key
int count = scores.count("Bob");
std::cout << "Number of scores for Bob: " << count << std::endl;
```

### Deletion

```cpp
// Remove all elements with a specific key
scores.erase("Charlie");

// Remove a specific element (need an iterator)
auto it = scores.find("Bob");
if (it != scores.end()) {
    scores.erase(it);  // Removes only one entry for Bob
}

// Clear the entire container
scores.clear();
```

## Performance Considerations

- **Hash Function**: Performance depends on the quality of the hash function
- **Load Factor**: Too high load factor decreases performance
- **Bucket Count**: Can be adjusted for better performance

```cpp
// Get current load factor
float load = scores.load_factor();
std::cout << "Current load factor: " << load << std::endl;

// Get max load factor
float max_load = scores.max_load_factor();
std::cout << "Maximum load factor: " << max_load << std::endl;

// Set max load factor
scores.max_load_factor(0.7f);

// Reserve buckets for expected size
scores.reserve(100);  // Prepares container for 100 elements
```

## Comparison with Other Containers

| Container | Multiple Keys | Ordering | Lookup Complexity |
|-----------|---------------|----------|-------------------|
| `std::map` | No | Sorted | O(log n) |
| `std::multimap` | Yes | Sorted | O(log n) |
| `std::unordered_map` | No | Unsorted | O(1) average |
| `std::unordered_multimap` | Yes | Unsorted | O(1) average |

## Custom Key Types

To use a custom type as a key, you need to provide:

1. A hash function
2. An equality comparison function

```cpp
#include <iostream>
#include <unordered_map>
#include <string>

// Custom key type
struct Student {
    int id;
    std::string name;
    
    // Equality operator
    bool operator==(const Student& other) const {
        return id == other.id && name == other.name;
    }
};

// Custom hash function
namespace std {
    template<>
    struct hash<Student> {
        size_t operator()(const Student& s) const {
            return hash<int>()(s.id) ^ hash<string>()(s.name);
        }
    };
}

int main() {
    std::unordered_multimap<Student, double> student_gpas;
    
    // Insert elements
    student_gpas.insert({{101, "Alice"}, 3.9});
    student_gpas.insert({{102, "Bob"}, 3.7});
    student_gpas.insert({{101, "Alice"}, 4.0});  // Same student, different semester
    
    // Print all elements
    for (const auto& pair : student_gpas) {
        std::cout << "Student ID: " << pair.first.id 
                  << ", Name: " << pair.first.name
                  << ", GPA: " << pair.second << std::endl;
    }
    
    return 0;
}
```

## Common Pitfalls

1. Modifying keys after insertion can corrupt the container
2. Iterator invalidation after rehashing
3. Poor hash function leading to many collisions
4. Forgetting that elements are not stored in any specific order

## When to Use std::unordered_multimap

- When you need to store multiple key-value pairs with the same key
- When you need fast lookups
- When you don't need the elements to be sorted
- When memory overhead for hash tables is acceptable

## Conclusion

The `std::unordered_multimap` is a powerful container that provides fast lookups for multiple key-value pairs with the same key. It's particularly useful in situations where you need to store multiple values associated with a single key and need quick access to them without requiring any specific ordering.
