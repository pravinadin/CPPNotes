# STL std::multiset Summary

## Introduction to std::multiset

`std::multiset` is an associative container in the C++ Standard Template Library (STL) that:

- Stores elements in a sorted order
- Allows duplicate elements (unlike `std::set`)
- Provides logarithmic complexity for insertion, deletion, and search operations
- Automatically keeps elements sorted according to a specified comparison function

## Basic Usage

```cpp
#include <iostream>
#include <set>

int main() {
    // Create a multiset of integers
    std::multiset<int> numbers{5, 3, 8, 3, 1, 5, 5};
    
    // Print all elements
    for (const auto& num : numbers) {
        std::cout << num << " ";
    }
    // Output: 1 3 3 5 5 5 8 (automatically sorted)
    
    // Count occurrences of a value
    std::cout << "\nCount of 5: " << numbers.count(5) << std::endl;
    // Output: Count of 5: 3
    
    // Insert more elements
    numbers.insert(2);
    numbers.insert(5); // Adding another 5
    
    // Find elements
    auto it = numbers.find(3);
    if (it != numbers.end()) {
        std::cout << "Found: " << *it << std::endl;
    }
    
    // Erase all occurrences of a value
    numbers.erase(5); // Removes ALL instances of 5
    
    // Erase a single occurrence
    auto it2 = numbers.find(3);
    if (it2 != numbers.end()) {
        numbers.erase(it2); // Removes only one instance of 3
    }
    
    return 0;
}
```

## Comparing Non-Trivial Types

When using `std::multiset` with custom types, you need to provide a way to compare elements. There are three main approaches:

### 1. Using a Comparison Function Object

```cpp
#include <iostream>
#include <set>
#include <string>

struct Person {
    std::string name;
    int age;
    
    Person(std::string n, int a) : name(std::move(n)), age(a) {}
};

// Comparison function object (functor)
struct PersonComparator {
    bool operator()(const Person& lhs, const Person& rhs) const {
        // Sort by age ascending
        return lhs.age < rhs.age;
    }
};

int main() {
    // Create a multiset of Person objects with custom comparator
    std::multiset<Person, PersonComparator> people;
    
    people.insert(Person("Alice", 30));
    people.insert(Person("Bob", 25));
    people.insert(Person("Charlie", 35));
    people.insert(Person("David", 25)); // Same age as Bob
    
    // Print people sorted by age
    for (const auto& person : people) {
        std::cout << person.name << ": " << person.age << std::endl;
    }
    // Output:
    // Bob: 25
    // David: 25
    // Alice: 30
    // Charlie: 35
    
    return 0;
}
```

### 2. Using std::less and operator<

```cpp
#include <iostream>
#include <set>
#include <string>

struct Person {
    std::string name;
    int age;
    
    Person(std::string n, int a) : name(std::move(n)), age(a) {}
    
    // Define operator< for comparison
    bool operator<(const Person& other) const {
        // Sort primarily by age, then by name if ages are equal
        if (age != other.age) {
            return age < other.age;
        }
        return name < other.name;
    }
};

int main() {
    // Create a multiset that uses operator< by default
    std::multiset<Person> people;
    
    people.insert(Person("Alice", 30));
    people.insert(Person("Bob", 25));
    people.insert(Person("Charlie", 35));
    people.insert(Person("David", 25)); // Same age as Bob, but different name
    
    // Print people sorted by age, then by name
    for (const auto& person : people) {
        std::cout << person.name << ": " << person.age << std::endl;
    }
    // Output:
    // Bob: 25
    // David: 25 (comes after Bob alphabetically)
    // Alice: 30
    // Charlie: 35
    
    return 0;
}
```

### 3. Using Lambda Functions (C++14 and later)

```cpp
#include <iostream>
#include <set>
#include <string>
#include <functional>

struct Person {
    std::string name;
    int age;
    
    Person(std::string n, int a) : name(std::move(n)), age(a) {}
};

int main() {
    // Create a multiset with a lambda comparator
    auto nameComparator = [](const Person& lhs, const Person& rhs) {
        // Sort by name alphabetically
        return lhs.name < rhs.name;
    };
    
    std::multiset<Person, decltype(nameComparator)> people(nameComparator);
    
    people.insert(Person("Alice", 30));
    people.insert(Person("Bob", 25));
    people.insert(Person("Charlie", 35));
    people.insert(Person("Alice", 40)); // Same name, different age
    
    // Print people sorted by name
    for (const auto& person : people) {
        std::cout << person.name << ": " << person.age << std::endl;
    }
    // Output:
    // Alice: 30
    // Alice: 40
    // Bob: 25
    // Charlie: 35
    
    return 0;
}
```

## Common Operations and Their Complexity

| Operation | Time Complexity |
|-----------|-----------------|
| Insertion | O(log n) |
| Deletion | O(log n) |
| Search | O(log n) |
| Count | O(log n + count) |
| lower_bound | O(log n) |
| upper_bound | O(log n) |
| equal_range | O(log n) |

## Useful Member Functions

```cpp
#include <iostream>
#include <set>

int main() {
    std::multiset<int> numbers{1, 5, 5, 5, 8, 10, 15};
    
    // Find lower and upper bounds for a value
    auto lower = numbers.lower_bound(5); // Iterator to first 5
    auto upper = numbers.upper_bound(5); // Iterator to element after last 5
    
    std::cout << "Elements between lower_bound and upper_bound: ";
    for (auto it = lower; it != upper; ++it) {
        std::cout << *it << " ";
    }
    // Output: 5 5 5
    
    // Get equal_range (both bounds in one call)
    auto range = numbers.equal_range(5);
    std::cout << "\nEqual range contains: ";
    for (auto it = range.first; it != range.second; ++it) {
        std::cout << *it << " ";
    }
    // Output: 5 5 5
    
    // Check if element exists
    bool exists = numbers.find(7) != numbers.end();
    std::cout << "\nElement 7 exists: " << std::boolalpha << exists << std::endl;
    // Output: Element 7 exists: false
    
    // Size and max size
    std::cout << "Size: " << numbers.size() << std::endl;
    std::cout << "Max size: " << numbers.max_size() << std::endl;
    
    // Check if empty
    std::cout << "Is empty: " << std::boolalpha << numbers.empty() << std::endl;
    
    return 0;
}
```

## When to Use std::multiset

- When you need to maintain a sorted collection that allows duplicates
- When you need to quickly find elements or ranges of elements
- When you need to count occurrences of elements
- When efficient insertions and deletions are required in a sorted container

## Comparison with Other Containers

| Container | Allows Duplicates | Keeps Sorted | Implementation |
|-----------|-------------------|--------------|----------------|
| std::set | No | Yes | Usually balanced tree |
| std::multiset | Yes | Yes | Usually balanced tree |
| std::unordered_set | No | No | Hash table |
| std::unordered_multiset | Yes | No | Hash table |
| std::vector (sorted) | Yes | Manual | Dynamic array |

## Practical Tips

1. Use `std::multiset` when you need to maintain a sorted collection with duplicates and need fast lookups/insertions/deletions.

2. For non-trivial types, consider which comparison approach makes the most sense:
   - Custom comparator class: Good for multiple comparison strategies
   - Overloaded operator<: Simple and intuitive for a natural ordering
   - Lambda functions: Flexible and good for local scope comparisons

3. Remember that modifying an element's key value directly would break the container's ordering. If you need to modify a key value, remove the element and reinsert it.

4. For large datasets where order doesn't matter, consider using `std::unordered_multiset` for potentially better performance with O(1) average complexity.

5. When erasing elements, use `.erase(value)` to remove all matching elements, or `.erase(iterator)` to remove a single element at the specified position.
