# STL std::map | Modern C++ Series Summary

## Introduction to std::map

`std::map` is an associative container in the C++ Standard Template Library (STL) that stores key-value pairs in a sorted order. It implements a self-balancing binary search tree (typically a red-black tree), providing logarithmic time complexity for insertions, deletions, and lookups.

## Key Characteristics

- **Ordered**: Elements are automatically sorted by keys
- **Unique Keys**: Each key can appear only once in the map
- **Associative**: Associates values with keys
- **Self-balancing**: Maintains a balanced tree structure
- **Time Complexity**: O(log n) for most operations

## Basic Usage

```cpp
#include <iostream>
#include <map>
#include <string>

int main() {
    // Create a map with string keys and int values
    std::map<std::string, int> userAges;
    
    // Insert elements using different methods
    userAges["Alice"] = 25;                         // Using operator[]
    userAges.insert({"Bob", 30});                   // Using insert() with initializer list
    userAges.insert(std::make_pair("Charlie", 35)); // Using insert() with make_pair
    
    // Access elements
    std::cout << "Alice's age: " << userAges["Alice"] << std::endl;
    std::cout << "Bob's age: " << userAges.at("Bob") << std::endl;
    
    // Iterate through the map (sorted by key)
    for (const auto& pair : userAges) {
        std::cout << pair.first << " is " << pair.second << " years old." << std::endl;
    }
    
    return 0;
}
```

## Key Methods and Operations

### Insertion

```cpp
std::map<int, std::string> m;

// Method 1: Using operator[]
m[1] = "One";
m[2] = "Two";

// Method 2: Using insert() with std::pair
m.insert(std::pair<int, std::string>(3, "Three"));

// Method 3: Using insert() with std::make_pair
m.insert(std::make_pair(4, "Four"));

// Method 4: Using emplace() (C++11 and later)
m.emplace(5, "Five");

// Insert with return value (pair of iterator and bool)
auto result = m.insert({6, "Six"});
if (result.second) {
    std::cout << "Insertion successful" << std::endl;
} else {
    std::cout << "Element with key 6 already exists" << std::endl;
}
```

### Accessing Elements

```cpp
std::map<int, std::string> m = {{1, "One"}, {2, "Two"}, {3, "Three"}};

// Method 1: Using operator[] (creates element if key doesn't exist)
std::string value1 = m[1];  // Returns "One"
std::string value4 = m[4];  // Creates new element with empty string

// Method 2: Using at() (throws std::out_of_range if key doesn't exist)
try {
    std::string value2 = m.at(2);  // Returns "Two"
    std::string value5 = m.at(5);  // Throws exception
} catch (const std::out_of_range& e) {
    std::cout << "Key not found!" << std::endl;
}

// Method 3: Using find() (returns iterator to end() if key doesn't exist)
auto it = m.find(3);
if (it != m.end()) {
    std::cout << "Found: " << it->first << " -> " << it->second << std::endl;
} else {
    std::cout << "Key not found!" << std::endl;
}
```

### Checking if a Key Exists

```cpp
std::map<int, std::string> m = {{1, "One"}, {2, "Two"}, {3, "Three"}};

// Method 1: Using find()
if (m.find(2) != m.end()) {
    std::cout << "Key 2 exists" << std::endl;
}

// Method 2: Using count() (returns 0 or 1 since keys are unique)
if (m.count(4) > 0) {
    std::cout << "Key 4 exists" << std::endl;
} else {
    std::cout << "Key 4 does not exist" << std::endl;
}

// Method 3: Using contains() (C++20 and later)
#if defined(__cplusplus) && __cplusplus >= 202002L
if (m.contains(3)) {
    std::cout << "Key 3 exists" << std::endl;
}
#endif
```

### Erasing Elements

```cpp
std::map<int, std::string> m = {{1, "One"}, {2, "Two"}, {3, "Three"}, {4, "Four"}};

// Method 1: Erase by key
m.erase(1);  // Removes key-value pair with key 1

// Method 2: Erase by iterator
auto it = m.find(2);
if (it != m.end()) {
    m.erase(it);  // Removes key-value pair with key 2
}

// Method 3: Erase by range
auto start = m.find(3);
auto end = m.find(4);
if (start != m.end() && end != m.end()) {
    m.erase(start, end);  // Removes elements from start to end (excluding end)
}
```

### Iteration

```cpp
std::map<int, std::string> m = {{1, "One"}, {2, "Two"}, {3, "Three"}};

// Method 1: Range-based for loop (C++11 and later)
for (const auto& pair : m) {
    std::cout << pair.first << " -> " << pair.second << std::endl;
}

// Method 2: Using iterators
for (auto it = m.begin(); it != m.end(); ++it) {
    std::cout << it->first << " -> " << it->second << std::endl;
}

// Method 3: Using structured bindings (C++17 and later)
for (const auto& [key, value] : m) {
    std::cout << key << " -> " << value << std::endl;
}
```

## Custom Comparators

By default, `std::map` uses `std::less<Key>` to sort keys. You can provide a custom comparator:

```cpp
#include <iostream>
#include <map>
#include <string>

// Custom comparator for case-insensitive string comparison
struct CaseInsensitiveCompare {
    bool operator()(const std::string& a, const std::string& b) const {
        return std::lexicographical_compare(
            a.begin(), a.end(),
            b.begin(), b.end(),
            [](char c1, char c2) { return std::tolower(c1) < std::tolower(c2); }
        );
    }
};

int main() {
    // Using custom comparator for case-insensitive keys
    std::map<std::string, int, CaseInsensitiveCompare> caseInsensitiveMap;
    
    caseInsensitiveMap["Apple"] = 1;
    caseInsensitiveMap["orange"] = 2;
    caseInsensitiveMap["Banana"] = 3;
    
    // "apple" and "Apple" are considered the same key
    caseInsensitiveMap["apple"] = 4;  // This will overwrite the existing "Apple" entry
    
    for (const auto& pair : caseInsensitiveMap) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    
    return 0;
}
```

## Performance Considerations

- **Time Complexity**:
  - Insert: O(log n)
  - Erase: O(log n)
  - Find: O(log n)
  - Lower/Upper bound: O(log n)
  - Iteration: O(n)

- **Memory Overhead**: Higher than unordered_map due to the balanced tree structure

- **Use `std::map` when**:
  - You need keys to be sorted
  - You need to find elements within a range
  - You need to iterate in a specific order
  - You need predecessor/successor operations

- **Consider `std::unordered_map` when**:
  - You don't need sorted keys
  - You need faster average-case lookups (O(1) vs O(log n))
  - You don't need range queries

## Advanced Usage

### Using with Custom Types

```cpp
#include <iostream>
#include <map>
#include <string>

class Person {
public:
    Person(std::string name, int age) : name_(std::move(name)), age_(age) {}
    
    const std::string& getName() const { return name_; }
    int getAge() const { return age_; }
    
private:
    std::string name_;
    int age_;
};

// Comparator for Person objects based on name
struct PersonCompare {
    bool operator()(const Person& a, const Person& b) const {
        return a.getName() < b.getName();
    }
};

int main() {
    // Map with custom type as key
    std::map<Person, std::string, PersonCompare> personMap;
    
    personMap.insert({Person("Alice", 25), "Engineer"});
    personMap.insert({Person("Bob", 30), "Designer"});
    personMap.insert({Person("Charlie", 35), "Manager"});
    
    for (const auto& pair : personMap) {
        std::cout << pair.first.getName() << " (" << pair.first.getAge() 
                  << "): " << pair.second << std::endl;
    }
    
    return 0;
}
```

### Multi-level Maps

```cpp
#include <iostream>
#include <map>
#include <string>

int main() {
    // Map of maps: department -> (employee -> salary)
    std::map<std::string, std::map<std::string, double>> company;
    
    // Add departments and employees
    company["Engineering"]["Alice"] = 85000.0;
    company["Engineering"]["Bob"] = 82000.0;
    company["Marketing"]["Charlie"] = 70000.0;
    company["Marketing"]["David"] = 72000.0;
    
    // Print company structure
    for (const auto& dept : company) {
        std::cout << "Department: " << dept.first << std::endl;
        for (const auto& employee : dept.second) {
            std::cout << "  - " << employee.first << ": $" << employee.second << std::endl;
        }
    }
    
    // Find an employee across all departments
    std::string targetEmployee = "Alice";
    for (const auto& dept : company) {
        auto it = dept.second.find(targetEmployee);
        if (it != dept.second.end()) {
            std::cout << targetEmployee << " works in " << dept.first 
                      << " and earns $" << it->second << std::endl;
            break;
        }
    }
    
    return 0;
}
```

## Comparison with Other STL Containers

| Container | Ordering | Duplicates | Implementation | Lookup | Insertion |
|-----------|----------|------------|----------------|--------|-----------|
| std::map | Sorted | No | Tree | O(log n) | O(log n) |
| std::unordered_map | Unordered | No | Hash table | O(1) avg | O(1) avg |
| std::multimap | Sorted | Yes | Tree | O(log n) | O(log n) |
| std::unordered_multimap | Unordered | Yes | Hash table | O(1) avg | O(1) avg |

## Summary

`std::map` is a powerful associative container that provides:
- Ordered key-value storage
- Logarithmic time complexity for most operations
- Automatic sorting based on keys
- Support for custom comparators
- Flexibility for handling complex data relationships

It's particularly useful when you need to maintain elements in a sorted order or when you need to perform range-based operations on your data.
