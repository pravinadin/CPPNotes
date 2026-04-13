# STL std::unordered_multiset in C++11

## Introduction

This document summarizes the key concepts and usage of `std::unordered_multiset` in C++11, including custom hash functions, as covered in "Modern C++ Series Episode 124".

`std::unordered_multiset` is a container in the C++ Standard Template Library (STL) that:
- Stores multiple occurrences of the same value
- Provides fast lookup operations using hash tables
- Does not maintain any particular order of elements
- Provides average constant-time complexity O(1) for search, insert, and delete operations

## Basic Usage

### Including the Header

```cpp
#include <unordered_set>
```

### Creating an Unordered Multiset

```cpp
// Create an empty unordered_multiset of integers
std::unordered_multiset<int> numbers;

// Initialize with values
std::unordered_multiset<int> numbers = {1, 2, 3, 2, 1, 4, 5, 1};

// Create with custom hash function and key equality
std::unordered_multiset<MyClass, MyHashFunction, MyKeyEqual> customSet;
```

### Common Operations

#### Insertion

```cpp
std::unordered_multiset<int> numbers;

// Insert single elements
numbers.insert(10);
numbers.insert(20);
numbers.insert(10);  // Duplicate allowed

// Insert multiple elements
numbers.insert({30, 40, 50, 30});

// Emplace (construct in-place)
numbers.emplace(60);
```

#### Searching

```cpp
std::unordered_multiset<int> numbers = {1, 2, 3, 2, 1, 4};

// Check if element exists
if (numbers.find(2) != numbers.end()) {
    std::cout << "Found 2" << std::endl;
}

// Count occurrences of an element
std::cout << "Count of 2: " << numbers.count(2) << std::endl;  // Outputs: Count of 2: 2

// Check if element exists (C++20)
if (numbers.contains(3)) {
    std::cout << "Contains 3" << std::endl;
}
```

#### Deletion

```cpp
std::unordered_multiset<int> numbers = {1, 2, 3, 2, 1, 4};

// Remove a single occurrence of an element
numbers.erase(numbers.find(2));  // Removes only one occurrence of 2

// Remove all occurrences of an element
numbers.erase(1);  // Removes all occurrences of 1

// Clear the entire container
numbers.clear();
```

#### Iterating

```cpp
std::unordered_multiset<int> numbers = {1, 2, 3, 2, 1, 4};

// Range-based for loop (C++11)
for (const auto& num : numbers) {
    std::cout << num << " ";
}

// Iterator-based loop
for (auto it = numbers.begin(); it != numbers.end(); ++it) {
    std::cout << *it << " ";
}
```

## Hash Function and Key Equality

### Default Hash Function

For built-in types and standard library types like `std::string`, the STL provides default hash functions.

```cpp
std::unordered_multiset<std::string> names = {"Alice", "Bob", "Charlie", "Alice"};
```

### Custom Hash Function

For user-defined types, you need to provide a custom hash function:

#### Method 1: Function Object (Functor)

```cpp
// User-defined class
struct Person {
    std::string name;
    int age;
    
    bool operator==(const Person& other) const {
        return name == other.name && age == other.age;
    }
};

// Custom hash function as a functor
struct PersonHash {
    std::size_t operator()(const Person& p) const {
        return std::hash<std::string>()(p.name) ^ std::hash<int>()(p.age);
    }
};

// Using the custom hash
std::unordered_multiset<Person, PersonHash> people;
```

#### Method 2: Specializing std::hash

```cpp
// User-defined class
struct Point {
    int x, y;
    
    bool operator==(const Point& other) const {
        return x == other.x && y == other.y;
    }
};

// Specializing std::hash for Point
namespace std {
    template<>
    struct hash<Point> {
        std::size_t operator()(const Point& p) const {
            return hash<int>()(p.x) ^ (hash<int>()(p.y) << 1);
        }
    };
}

// Now you can use Point with default hash
std::unordered_multiset<Point> points;
```

## Bucket Interface

`std::unordered_multiset` provides access to its internal structure:

```cpp
std::unordered_multiset<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

// Get number of buckets
std::cout << "Bucket count: " << numbers.bucket_count() << std::endl;

// Get bucket size for a specific key
std::cout << "Bucket size for key 3: " << numbers.bucket_size(numbers.bucket(3)) << std::endl;

// Get load factor
std::cout << "Load factor: " << numbers.load_factor() << std::endl;

// Get max load factor
std::cout << "Max load factor: " << numbers.max_load_factor() << std::endl;

// Set max load factor (controls rehashing)
numbers.max_load_factor(0.7f);

// Reserve space for elements
numbers.reserve(100);

// Rehash to specific number of buckets
numbers.rehash(20);
```

## Performance Considerations

1. **Time Complexity**:
   - Average case: O(1) for search, insert, and delete
   - Worst case: O(n) if hash function generates many collisions

2. **Hash Function Quality**:
   - Good distribution reduces collisions
   - Poor distribution degrades to O(n) performance

3. **Memory Overhead**:
   - Higher than ordered containers
   - Stores hash table infrastructure

4. **Load Factor**:
   - Lower load factor means fewer collisions but more memory usage
   - Higher load factor saves memory but increases collision probability

## Complete Example

```cpp
#include <iostream>
#include <unordered_set>
#include <string>

// Custom class
struct Student {
    std::string name;
    int id;
    
    // Required for equality comparison
    bool operator==(const Student& other) const {
        return id == other.id;  // Only comparing by ID
    }
    
    // Constructor for convenience
    Student(const std::string& n, int i) : name(n), id(i) {}
};

// Custom hash function
struct StudentHash {
    std::size_t operator()(const Student& s) const {
        return std::hash<int>()(s.id);  // Only hashing by ID
    }
};

int main() {
    // Create unordered_multiset with custom class
    std::unordered_multiset<Student, StudentHash> students;
    
    // Insert elements
    students.insert(Student("Alice", 101));
    students.insert(Student("Bob", 102));
    students.insert(Student("Charlie", 103));
    students.insert(Student("Dave", 101));  // Same ID as Alice
    
    // Print all students
    std::cout << "All students:" << std::endl;
    for (const auto& student : students) {
        std::cout << "Name: " << student.name << ", ID: " << student.id << std::endl;
    }
    
    // Count students with ID 101
    std::cout << "\nNumber of students with ID 101: " << students.count(Student("", 101)) << std::endl;
    
    // Find and print all students with ID 101
    std::cout << "\nStudents with ID 101:" << std::endl;
    auto range = students.equal_range(Student("", 101));
    for (auto it = range.first; it != range.second; ++it) {
        std::cout << "Name: " << it->name << ", ID: " << it->id << std::endl;
    }
    
    return 0;
}
```

## Differences from std::unordered_set

| Feature | `std::unordered_set` | `std::unordered_multiset` |
|---------|----------------------|----------------------------|
| Duplicates | No duplicates allowed | Allows duplicate elements |
| `insert()` | Returns pair<iterator, bool> | Returns iterator |
| `count()` | Returns 0 or 1 | Returns number of occurrences |
| `erase(value)` | Removes all matching elements (0 or 1) | Removes all matching elements (0 or more) |
| Use case | Storing unique elements | Tracking multiple occurrences |

## When to Use std::unordered_multiset

- When you need to store duplicate elements
- When order doesn't matter
- When you need fast lookup operations
- When you need to count occurrences
- When you need to find all instances of a value

## When Not to Use std::unordered_multiset

- When you need elements to be ordered (use `std::multiset` instead)
- When you need stable iterators that don't invalidate on rehashing
- When memory usage is a critical concern
- When you can't provide a good hash function

## Conclusion

`std::unordered_multiset` provides a powerful, efficient container for storing multiple occurrences of elements with fast lookup capabilities through hash tables. While it requires more memory than ordered containers, it offers significantly faster access times for large datasets. For custom types, implementing a good hash function is essential to maintain the container's performance characteristics.
