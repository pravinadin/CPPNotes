# C++ STL std::priority_queue Container Adaptor

## Overview
`std::priority_queue` is a container adaptor in the C++ Standard Template Library (STL) that provides constant time lookup of the largest (by default) element, at the expense of logarithmic insertion and extraction. It is implemented as a max heap by default.

## Key Characteristics
- A container adaptor (like `std::stack` and `std::queue`) that wraps an underlying container
- Default underlying container is `std::vector`
- Elements are ordered according to a comparison function
- Default comparison function is `std::less<T>`, creating a max heap
- Provides a restricted interface compared to the underlying container

## Common Operations

| Operation | Description | Time Complexity |
|-----------|-------------|-----------------|
| `top()` | Access the top element | O(1) |
| `push()` | Insert element and reheapify | O(log n) |
| `pop()` | Remove the top element and reheapify | O(log n) |
| `size()` | Return the number of elements | O(1) |
| `empty()` | Check if the container is empty | O(1) |

## Basic Usage

```cpp
#include <iostream>
#include <queue>  // Required for std::priority_queue

int main() {
    // Default max-heap (largest element at the top)
    std::priority_queue<int> pq;
    
    // Insert elements
    pq.push(10);
    pq.push(30);
    pq.push(20);
    pq.push(5);
    
    // Print and remove elements
    while (!pq.empty()) {
        std::cout << pq.top() << " ";  // Prints: 30 20 10 5
        pq.pop();
    }
    
    return 0;
}
```

## Creating a Min-Heap

There are two ways to create a min-heap (smallest element at the top):

### 1. Using `std::greater` comparison function

```cpp
#include <iostream>
#include <queue>
#include <functional>  // For std::greater

int main() {
    // Min-heap using greater comparison
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_pq;
    
    min_pq.push(10);
    min_pq.push(30);
    min_pq.push(20);
    min_pq.push(5);
    
    while (!min_pq.empty()) {
        std::cout << min_pq.top() << " ";  // Prints: 5 10 20 30
        min_pq.pop();
    }
    
    return 0;
}
```

### 2. Negating the values (hacky approach)

```cpp
#include <iostream>
#include <queue>

int main() {
    std::priority_queue<int> pq;
    
    // Insert negated values
    pq.push(-10);
    pq.push(-30);
    pq.push(-20);
    pq.push(-5);
    
    while (!pq.empty()) {
        std::cout << -pq.top() << " ";  // Prints: 5 10 20 30
        pq.pop();
    }
    
    return 0;
}
```

## Using Custom Types

To use custom types with `std::priority_queue`, you need to ensure they're comparable:

### 1. Using operator overloading

```cpp
#include <iostream>
#include <queue>
#include <string>

struct Person {
    std::string name;
    int age;
    
    // For max-heap based on age
    bool operator<(const Person& other) const {
        return age < other.age;  // Note: reversed for max-heap
    }
};

int main() {
    std::priority_queue<Person> pq;
    
    pq.push({"Alice", 25});
    pq.push({"Bob", 30});
    pq.push({"Charlie", 20});
    
    while (!pq.empty()) {
        std::cout << pq.top().name << " - " << pq.top().age << "\n";
        pq.pop();
    }
    // Output:
    // Bob - 30
    // Alice - 25
    // Charlie - 20
    
    return 0;
}
```

### 2. Using custom comparator

```cpp
#include <iostream>
#include <queue>
#include <string>

struct Person {
    std::string name;
    int age;
};

// Custom comparator as a function object
struct PersonCompare {
    bool operator()(const Person& a, const Person& b) const {
        // For min-heap based on age
        return a.age > b.age;
    }
};

int main() {
    std::priority_queue<Person, std::vector<Person>, PersonCompare> pq;
    
    pq.push({"Alice", 25});
    pq.push({"Bob", 30});
    pq.push({"Charlie", 20});
    
    while (!pq.empty()) {
        std::cout << pq.top().name << " - " << pq.top().age << "\n";
        pq.pop();
    }
    // Output:
    // Charlie - 20
    // Alice - 25
    // Bob - 30
    
    return 0;
}
```

### 3. Using lambda expression (C++14 and later)

```cpp
#include <iostream>
#include <queue>
#include <string>
#include <functional>

struct Person {
    std::string name;
    int age;
};

int main() {
    auto compare = [](const Person& a, const Person& b) {
        return a.age > b.age;  // Min-heap based on age
    };
    
    std::priority_queue<Person, std::vector<Person>, decltype(compare)> pq(compare);
    
    pq.push({"Alice", 25});
    pq.push({"Bob", 30});
    pq.push({"Charlie", 20});
    
    while (!pq.empty()) {
        std::cout << pq.top().name << " - " << pq.top().age << "\n";
        pq.pop();
    }
    // Output:
    // Charlie - 20
    // Alice - 25
    // Bob - 30
    
    return 0;
}
```

## Practical Applications

1. **Priority Task Management**
   ```cpp
   struct Task {
       std::string name;
       int priority;
       
       bool operator<(const Task& other) const {
           return priority < other.priority;
       }
   };
   
   std::priority_queue<Task> taskQueue;
   ```

2. **Dijkstra's Algorithm**
   ```cpp
   struct Node {
       int id;
       int distance;
       
       bool operator>(const Node& other) const {
           return distance > other.distance;
       }
   };
   
   std::priority_queue<Node, std::vector<Node>, std::greater<Node>> pq;
   ```

3. **Heap Sort Implementation**
   ```cpp
   std::vector<int> heapSort(std::vector<int>& nums) {
       std::priority_queue<int> pq(nums.begin(), nums.end());
       std::vector<int> result;
       while (!pq.empty()) {
           result.push_back(pq.top());
           pq.pop();
       }
       return result;
   }
   ```

4. **K Largest Elements**
   ```cpp
   std::vector<int> findKLargest(std::vector<int>& nums, int k) {
       std::priority_queue<int> pq(nums.begin(), nums.end());
       std::vector<int> result;
       for (int i = 0; i < k && !pq.empty(); ++i) {
           result.push_back(pq.top());
           pq.pop();
       }
       return result;
   }
   ```

## Common Mistakes and Gotchas

1. Forgetting that `std::priority_queue` is a max-heap by default
2. Not understanding the comparison logic (less than for max-heap seems counter-intuitive)
3. Trying to access elements other than the top element (not supported)
4. Forgetting to define proper comparison for custom types
5. No direct iterator support or methods to modify elements after insertion

## Performance Considerations

- Underlying container affects performance characteristics
- Default `std::vector` works well for most cases
- `std::deque` might be more efficient for certain operations
- Consider custom allocators for performance-critical applications

## Alternative to std::priority_queue

If you need more functionality than `std::priority_queue` provides, consider using `std::make_heap`, `std::push_heap`, `std::pop_heap` directly with a regular container:

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> v = {10, 30, 20, 5};
    
    // Create a heap
    std::make_heap(v.begin(), v.end());
    
    // Access the largest element
    std::cout << "Top element: " << v.front() << "\n";  // 30
    
    // Add a new element
    v.push_back(40);
    std::push_heap(v.begin(), v.end());
    
    // Remove the largest element
    std::pop_heap(v.begin(), v.end());
    int top = v.back();
    v.pop_back();
    
    return 0;
}
```
