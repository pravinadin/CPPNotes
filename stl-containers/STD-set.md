# STL std::set | Modern C++ Series

## Introduction
`std::set` is an ordered associative container in the C++ Standard Template Library (STL) that stores unique elements in a specific order. It's implemented as a balanced binary search tree (typically a red-black tree), which ensures logarithmic complexity for most operations.

## Key Characteristics

1. **Ordered**: Elements are automatically sorted according to a comparison function
2. **Unique Elements**: Duplicates are not allowed
3. **Immutable Keys**: Once inserted, elements cannot be modified (but can be removed and re-inserted)
4. **Logarithmic Complexity**: O(log n) for insertion, deletion, and search operations

## Basic Usage

```cpp
#include <iostream>
#include <set>

int main() {
    // Create a set of integers
    std::set<int> mySet;
    
    // Insert elements
    mySet.insert(30);
    mySet.insert(10);
    mySet.insert(20);
    mySet.insert(10); // Duplicate - will be ignored
    
    // Iterate and print (will be in sorted order: 10, 20, 30)
    std::cout << "Set contents: ";
    for (const auto& element : mySet) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Important Operations

### Insertion

```cpp
#include <iostream>
#include <set>

int main() {
    std::set<int> mySet;
    
    // Method 1: Using insert()
    mySet.insert(100);
    
    // Method 2: Using emplace() (more efficient for complex objects)
    mySet.emplace(200);
    
    // Insert with return value (pair of iterator and success boolean)
    auto result = mySet.insert(300);
    if (result.second) {
        std::cout << "300 was inserted successfully" << std::endl;
    }
    
    // Insert a duplicate
    auto result2 = mySet.insert(300);
    if (!result2.second) {
        std::cout << "300 was not inserted (already exists)" << std::endl;
    }
    
    return 0;
}
```

### Finding Elements

```cpp
#include <iostream>
#include <set>

int main() {
    std::set<int> mySet = {10, 20, 30, 40, 50};
    
    // Using find()
    auto it = mySet.find(30);
    if (it != mySet.end()) {
        std::cout << "Found: " << *it << std::endl;
    }
    
    // Using count() - returns 1 if element exists, 0 otherwise
    if (mySet.count(20) > 0) {
        std::cout << "20 exists in the set" << std::endl;
    }
    
    // Using contains() (C++20)
    // if (mySet.contains(40)) {
    //     std::cout << "40 exists in the set" << std::endl;
    // }
    
    return 0;
}
```

### Removing Elements

```cpp
#include <iostream>
#include <set>

int main() {
    std::set<int> mySet = {10, 20, 30, 40, 50};
    
    // Erase by value
    size_t numErased = mySet.erase(30);
    std::cout << "Elements erased: " << numErased << std::endl; // 1
    
    // Erase by iterator
    auto it = mySet.find(20);
    if (it != mySet.end()) {
        mySet.erase(it);
    }
    
    // Erase a range
    auto first = mySet.find(40);
    auto last = mySet.end();
    mySet.erase(first, last);
    
    // Print remaining elements
    for (const auto& element : mySet) {
        std::cout << element << " "; // Only 10 should remain
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Using Custom Comparators

By default, `std::set` uses `std::less<T>` for comparison, but you can provide your own comparator:

```cpp
#include <iostream>
#include <set>
#include <string>

// Custom comparator for case-insensitive string comparison
struct CaseInsensitiveCompare {
    bool operator()(const std::string& a, const std::string& b) const {
        std::string a_lower = a, b_lower = b;
        
        // Convert to lowercase
        for (auto& c : a_lower) c = std::tolower(c);
        for (auto& c : b_lower) c = std::tolower(c);
        
        return a_lower < b_lower;
    }
};

int main() {
    // Set using custom comparator
    std::set<std::string, CaseInsensitiveCompare> names;
    
    names.insert("John");
    names.insert("alice");
    names.insert("Bob");
    names.insert("ALICE"); // Will be considered a duplicate
    
    std::cout << "Set size: " << names.size() << std::endl; // 3, not 4
    
    for (const auto& name : names) {
        std::cout << name << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Working with User-Defined Types

When using custom classes in a `std::set`, you need to provide a way to compare objects:

```cpp
#include <iostream>
#include <set>
#include <string>

class Person {
public:
    Person(std::string name, int age) : name(name), age(age) {}
    
    std::string getName() const { return name; }
    int getAge() const { return age; }
    
private:
    std::string name;
    int age;
};

// Option 1: Define a comparison operator
struct PersonCompare {
    bool operator()(const Person& a, const Person& b) const {
        // Sort by name, then by age
        if (a.getName() != b.getName())
            return a.getName() < b.getName();
        return a.getAge() < b.getAge();
    }
};

int main() {
    std::set<Person, PersonCompare> people;
    
    people.insert(Person("Alice", 30));
    people.insert(Person("Bob", 25));
    people.insert(Person("Alice", 25)); // Different age, will be included
    
    std::cout << "Set size: " << people.size() << std::endl;
    
    for (const auto& person : people) {
        std::cout << person.getName() << " - " << person.getAge() << std::endl;
    }
    
    return 0;
}
```

## Common Member Functions

* `begin()`, `end()` - Return iterators to the beginning and end
* `size()` - Returns the number of elements
* `empty()` - Checks if the set is empty
* `clear()` - Removes all elements
* `insert()` - Inserts an element if it doesn't exist
* `emplace()` - Constructs and inserts an element in-place
* `erase()` - Removes elements by value, iterator, or range
* `find()` - Returns an iterator to the element if found
* `count()` - Returns the number of elements with a specific value (0 or 1)
* `lower_bound()`, `upper_bound()` - Return iterators to elements 
* `contains()` - Checks if an element exists (C++20)

## Performance Considerations

* Insertions, deletions, and lookups are all O(log n) operations
* Iterating through the set is O(n)
* Since `std::set` maintains order, it's slower than `std::unordered_set` for most operations
* Use `std::set` when you need ordered elements or when you need to perform range queries

## Practical Applications

* Maintaining a sorted collection of unique elements
* Implementing dictionaries or maps with ordered keys
* Set operations (union, intersection, difference) on ordered data
* Range queries (finding all elements between x and y)
* Removing duplicates while maintaining order

## Example: Set Operations

```cpp
#include <iostream>
#include <set>
#include <algorithm>
#include <iterator>

int main() {
    std::set<int> set1 = {1, 2, 3, 4, 5};
    std::set<int> set2 = {4, 5, 6, 7, 8};
    std::set<int> result;
    
    // Set union
    std::set_union(set1.begin(), set1.end(),
                  set2.begin(), set2.end(),
                  std::inserter(result, result.begin()));
    
    std::cout << "Union: ";
    for (const auto& element : result) {
        std::cout << element << " "; // 1 2 3 4 5 6 7 8
    }
    std::cout << std::endl;
    
    // Set intersection
    result.clear();
    std::set_intersection(set1.begin(), set1.end(),
                         set2.begin(), set2.end(),
                         std::inserter(result, result.begin()));
    
    std::cout << "Intersection: ";
    for (const auto& element : result) {
        std::cout << element << " "; // 4 5
    }
    std::cout << std::endl;
    
    // Set difference
    result.clear();
    std::set_difference(set1.begin(), set1.end(),
                       set2.begin(), set2.end(),
                       std::inserter(result, result.begin()));
    
    std::cout << "Difference (set1 - set2): ";
    for (const auto& element : result) {
        std::cout << element << " "; // 1 2 3
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Conclusion

`std::set` is a powerful container that provides an efficient way to store and retrieve unique sorted elements. Its balanced binary tree implementation ensures good performance for most operations, making it suitable for many applications that require maintaining an ordered set of unique items.
