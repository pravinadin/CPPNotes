# STL std::multimap Summary

## Introduction

This is a summary of the YouTube video "STL std::multimap (ordered, stable, multiple keys -trick with equal_range) | Modern C++ Series Ep. 128". The video explains the `std::multimap` container from the C++ Standard Template Library, which allows multiple elements with the same key.

## What is std::multimap?

`std::multimap` is an associative container in the STL that:
- Stores key-value pairs where multiple entries can have the same key
- Maintains elements in a sorted order based on keys
- Uses a self-balancing binary search tree (typically red-black tree) implementation
- Provides logarithmic complexity for most operations
- Guarantees stable ordering of elements with the same key (insertion order is preserved)

## Key Features

1. **Multiple identical keys**: Unlike `std::map`, `std::multimap` allows storing multiple elements with the same key.
2. **Ordered**: Elements are automatically sorted by key.
3. **Stable**: Elements with the same key maintain their insertion order.
4. **No direct access**: No `operator[]` - must use methods like `insert()`, `find()`, and `equal_range()`.
5. **Logarithmic complexity**: Most operations are O(log n).

## Basic Usage

```cpp
#include <iostream>
#include <map>
#include <string>

int main() {
    // Create a multimap with string keys and int values
    std::multimap<std::string, int> student_scores;
    
    // Insert elements - note we can have duplicate keys
    student_scores.insert({"Alice", 85});
    student_scores.insert({"Bob", 92});
    student_scores.insert({"Alice", 78});  // Another score for Alice
    student_scores.insert({"Charlie", 90});
    student_scores.insert({"Alice", 91});  // Third score for Alice
    
    // Print all elements
    for (const auto& [name, score] : student_scores) {
        std::cout << name << ": " << score << std::endl;
    }
    
    return 0;
}
```

Output:
```
Alice: 85
Alice: 78
Alice: 91
Bob: 92
Charlie: 90
```

Note that entries are sorted by key, and multiple entries with the same key (Alice) are maintained in insertion order.

## Finding Elements

Unlike `std::map`, working with duplicate keys requires special techniques:

### Using find()

The `find()` method returns an iterator to the first occurrence of a key:

```cpp
auto it = student_scores.find("Alice");
if (it != student_scores.end()) {
    std::cout << "Found: " << it->first << " - " << it->second << std::endl;
} else {
    std::cout << "Key not found" << std::endl;
}
```

Output:
```
Found: Alice - 85
```

### Using count()

The `count()` method returns the number of elements with the specified key:

```cpp
std::cout << "Number of scores for Alice: " << student_scores.count("Alice") << std::endl;
```

Output:
```
Number of scores for Alice: 3
```

## Working with Multiple Values: equal_range()

The most powerful way to work with duplicate keys is the `equal_range()` method, which returns a pair of iterators representing the range of elements with the specified key.

```cpp
#include <iostream>
#include <map>
#include <string>

int main() {
    std::multimap<std::string, int> student_scores = {
        {"Alice", 85},
        {"Bob", 92},
        {"Alice", 78},
        {"Charlie", 90},
        {"Alice", 91}
    };
    
    // Get all scores for Alice using equal_range
    auto range = student_scores.equal_range("Alice");
    
    std::cout << "All scores for Alice:" << std::endl;
    for (auto it = range.first; it != range.second; ++it) {
        std::cout << it->second << std::endl;
    }
    
    // Calculate average score for Alice
    int sum = 0;
    int count = 0;
    
    for (auto it = range.first; it != range.second; ++it) {
        sum += it->second;
        count++;
    }
    
    if (count > 0) {
        double average = static_cast<double>(sum) / count;
        std::cout << "Average score for Alice: " << average << std::endl;
    }
    
    return 0;
}
```

Output:
```
All scores for Alice:
85
78
91
Average score for Alice: 84.6667
```

## Advanced Example: Grouping and Processing

This example demonstrates a real-world use case where we group data by category using `std::multimap` and process each group:

```cpp
#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <algorithm>

struct Product {
    std::string name;
    double price;
    int quantity;
};

int main() {
    // Create a vector of products
    std::vector<Product> inventory = {
        {"Apple", 1.25, 50},
        {"Banana", 0.75, 30},
        {"Apple", 1.50, 20},
        {"Orange", 1.75, 25},
        {"Banana", 0.80, 40},
        {"Apple", 1.30, 35}
    };
    
    // Create a multimap to group products by category
    std::multimap<std::string, Product> product_groups;
    
    // Insert all products into the multimap
    for (const auto& product : inventory) {
        product_groups.insert({product.name, product});
    }
    
    // Process each product category
    std::string current_category;
    
    for (auto it = product_groups.begin(); it != product_groups.end(); ) {
        // Get the current category
        current_category = it->first;
        std::cout << "Category: " << current_category << std::endl;
        
        // Get range of products in this category
        auto range = product_groups.equal_range(current_category);
        
        // Calculate total inventory and average price for this category
        double total_value = 0.0;
        int total_quantity = 0;
        int item_count = 0;
        
        for (auto product_it = range.first; product_it != range.second; ++product_it) {
            const auto& product = product_it->second;
            total_value += product.price * product.quantity;
            total_quantity += product.quantity;
            item_count++;
            
            std::cout << "  - " << product.name 
                      << ", Price: $" << product.price 
                      << ", Quantity: " << product.quantity << std::endl;
        }
        
        double average_price = (item_count > 0) ? 
            (total_value / total_quantity) : 0.0;
            
        std::cout << "  Summary: " << item_count << " product variants, " 
                  << total_quantity << " total units" << std::endl;
        std::cout << "  Average price: $" << average_price << std::endl;
        std::cout << "  Total inventory value: $" << total_value << std::endl;
        std::cout << std::endl;
        
        // Move iterator to the next category
        it = range.second;
    }
    
    return 0;
}
```

Output:
```
Category: Apple
  - Apple, Price: $1.25, Quantity: 50
  - Apple, Price: $1.5, Quantity: 20
  - Apple, Price: $1.3, Quantity: 35
  Summary: 3 product variants, 105 total units
  Average price: $1.33095
  Total inventory value: $139.75

Category: Banana
  - Banana, Price: $0.75, Quantity: 30
  - Banana, Price: $0.8, Quantity: 40
  Summary: 2 product variants, 70 total units
  Average price: $0.778571
  Total inventory value: $54.5

Category: Orange
  - Orange, Price: $1.75, Quantity: 25
  Summary: 1 product variants, 25 total units
  Average price: $1.75
  Total inventory value: $43.75
```

## Performance Considerations

- Insertion: O(log n)
- Lookup: O(log n)
- Deletion: O(log n)
- `equal_range()`: O(log n)

## When to Use std::multimap

Use `std::multimap` when:
1. You need to store multiple elements with the same key
2. Elements must be sorted by key
3. You need to preserve insertion order for elements with the same key
4. You need efficient lookup for ranges of elements with the same key

## Alternatives

- `std::map`: When each key must be unique
- `std::unordered_multimap`: When you need multiple keys but don't need ordering
- `std::vector` of pairs: When you need more flexibility or simpler semantics

## Conclusion

`std::multimap` is a powerful container for working with grouped data where multiple items can share the same key. The `equal_range()` method provides an elegant way to work with all elements sharing a key, making it ideal for categorization and grouping operations.
