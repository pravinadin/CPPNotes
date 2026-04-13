# STL std::unordered_map (C++11) | Modern C++ Series Summary

## Introduction

`std::unordered_map` is a container introduced in C++11 that implements a hash table, allowing for fast data retrieval based on keys. Unlike the ordered `std::map` (which uses a binary search tree structure), `unordered_map` uses a hash function to map keys to buckets, offering average constant-time complexity O(1) for search, insert, and delete operations.

## Key Characteristics

- **Hash-based**: Uses a hash function to distribute elements into buckets
- **Unordered**: Elements are not stored in any particular order
- **Fast lookup**: O(1) average time complexity for lookup operations
- **No duplicates**: Each key can appear only once
- **Introduced in C++11**: Part of the modern C++ standard

## Basic Usage

```cpp
#include <iostream>
#include <unordered_map>
#include <string>

int main() {
    // Declare an unordered_map with string keys and int values
    std::unordered_map<std::string, int> ages;
    
    // Insert elements using different methods
    ages["Alice"] = 25;           // Using operator[]
    ages.insert({"Bob", 30});     // Using insert() with initializer list
    ages.emplace("Charlie", 35);  // Using emplace()
    
    // Access elements
    std::cout << "Alice's age: " << ages["Alice"] << std::endl;
    std::cout << "Bob's age: " << ages.at("Bob") << std::endl;
    
    // Check if a key exists
    if (ages.count("David") == 0) {
        std::cout << "David is not in the map" << std::endl;
    }
    
    // Iterate through all elements
    for (const auto& pair : ages) {
        std::cout << pair.first << " is " << pair.second << " years old" << std::endl;
    }
    
    return 0;
}
```

## Key Operations

### Insertion

```cpp
// Different ways to insert elements
std::unordered_map<int, std::string> map;

// Method 1: Using operator[]
map[1] = "One";

// Method 2: Using insert()
map.insert({2, "Two"});
map.insert(std::make_pair(3, "Three"));

// Method 3: Using emplace()
map.emplace(4, "Four");

// Insert with check
auto result = map.insert({1, "Another One"});
if (!result.second) {
    std::cout << "Key 1 already exists with value: " << result.first->second << std::endl;
}
```

### Element Access

```cpp
std::unordered_map<int, std::string> map = {
    {1, "One"},
    {2, "Two"},
    {3, "Three"}
};

// Using operator[] - creates element if key doesn't exist
std::string val1 = map[1];        // Returns "One"
std::string val4 = map[4];        // Creates new entry with empty string

// Using at() - throws exception if key doesn't exist
try {
    std::string val2 = map.at(2); // Returns "Two"
    std::string val5 = map.at(5); // Throws std::out_of_range
} catch (const std::out_of_range& e) {
    std::cout << "Key not found: " << e.what() << std::endl;
}

// Check if key exists
if (map.count(3) > 0) {
    std::cout << "Key 3 exists" << std::endl;
}

// Finding elements
auto it = map.find(2);
if (it != map.end()) {
    std::cout << "Found: " << it->first << " -> " << it->second << std::endl;
}
```

### Removal

```cpp
std::unordered_map<char, int> char_freq = {
    {'a', 10},
    {'b', 15},
    {'c', 20},
    {'d', 25}
};

// Erase by key
char_freq.erase('a');

// Erase by iterator
auto it = char_freq.find('b');
if (it != char_freq.end()) {
    char_freq.erase(it);
}

// Clear the entire map
char_freq.clear();
```

### Bucket Interface

```cpp
std::unordered_map<int, std::string> map = {
    {1, "One"}, {2, "Two"}, {3, "Three"}, {4, "Four"}, 
    {5, "Five"}, {6, "Six"}, {7, "Seven"}, {8, "Eight"}
};

// Bucket information
std::cout << "Bucket count: " << map.bucket_count() << std::endl;
std::cout << "Load factor: " << map.load_factor() << std::endl;
std::cout << "Max load factor: " << map.max_load_factor() << std::endl;

// Find bucket for a specific key
std::cout << "Key 5 is in bucket: " << map.bucket(5) << std::endl;

// Count elements in a specific bucket
std::cout << "Bucket 2 contains " << map.bucket_size(2) << " elements" << std::endl;

// Rehash to change bucket count
map.rehash(20);  // Set bucket count to at least 20
map.reserve(15); // Reserve space for at least 15 elements
```

## Performance Considerations

1. **Hash Function**: The efficiency of `unordered_map` depends heavily on the quality of the hash function.

2. **Collision Resolution**: When multiple keys hash to the same bucket, performance degrades.

3. **Load Factor**: The ratio of elements to buckets affects performance:
   - Low load factor: Better performance but higher memory usage
   - High load factor: Lower memory usage but more collisions

4. **Comparison with `std::map`**:
   - `unordered_map`: O(1) average lookup, but O(n) worst case
   - `map`: O(log n) lookup (always)

```cpp
// Custom hash function example for a struct
struct Person {
    std::string name;
    int age;
    
    bool operator==(const Person& other) const {
        return name == other.name && age == other.age;
    }
};

// Custom hash function for Person
namespace std {
    template<>
    struct hash<Person> {
        size_t operator()(const Person& p) const {
            return hash<string>()(p.name) ^ hash<int>()(p.age);
        }
    };
}

// Now we can use Person as a key
std::unordered_map<Person, std::string> person_locations;
person_locations[{"Alice", 30}] = "New York";
person_locations[{"Bob", 25}] = "San Francisco";
```

## Common Use Cases

1. **Fast Lookups**: When you need to quickly find values based on keys
2. **Frequency Counting**: Tallying occurrences of elements
3. **Caching**: Storing computed results for quick retrieval
4. **De-duplication**: Keeping track of unique items

```cpp
// Example: Word frequency counter
std::string text = "the quick brown fox jumps over the lazy dog";
std::unordered_map<std::string, int> word_count;

std::istringstream iss(text);
std::string word;
while (iss >> word) {
    word_count[word]++;
}

// Display results
for (const auto& pair : word_count) {
    std::cout << pair.first << ": " << pair.second << std::endl;
}
```

## C++17 and Beyond Enhancements

C++17 added structured bindings which make working with maps more elegant:

```cpp
std::unordered_map<std::string, int> scores = {
    {"Alice", 95},
    {"Bob", 87},
    {"Charlie", 92}
};

// Using structured bindings (C++17)
for (const auto& [name, score] : scores) {
    std::cout << name << " scored " << score << " points" << std::endl;
}

// Try/emplace in one step (C++17)
auto [it, inserted] = scores.try_emplace("David", 78);
if (inserted) {
    std::cout << "David was added with score " << it->second << std::endl;
} else {
    std::cout << "David already exists with score " << it->second << std::endl;
}
```

## Conclusion

`std::unordered_map` is a powerful container in modern C++ that provides fast lookup operations through hash-based implementation. It's ideal for situations where lookup speed is critical and the ordering of elements is not important. Understanding its behavior, particularly regarding hash functions and collision resolution, is key to using it effectively in your applications.
