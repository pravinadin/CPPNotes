# C++ STL std::queue: Container Adaptor

## Introduction
This document summarizes the key concepts and usage of `std::queue` from the C++ Standard Template Library (STL), based on "C++ STL std::queue a container adaptor | Modern C++ Series Ep. 132".

`std::queue` is a container adaptor that gives the programmer the functionality of a queue - specifically, a FIFO (First-In-First-Out) data structure. Elements are inserted at the back and extracted from the front.

## Basic Characteristics

* **Container Adaptor**: `std::queue` is not a standalone container but adapts another container to provide queue operations
* **Default Container**: By default, `std::queue` uses `std::deque` as its underlying container
* **Alternative Containers**: Can also be implemented with `std::list` or any container that supports:
  * `back()`
  * `front()`
  * `push_back()`
  * `pop_front()`

## Header File
```cpp
#include <queue>
```

## Basic Operations

### Constructing a Queue

```cpp
#include <iostream>
#include <queue>

int main() {
    // Default queue using std::deque
    std::queue<int> q1;
    
    // Queue with different underlying container
    std::queue<int, std::list<int>> q2;
    
    // Queue from another queue
    std::queue<int> q3(q1);
    
    return 0;
}
```

### Adding Elements (push)

```cpp
std::queue<int> q;
q.push(10);  // Adds element to the back of the queue
q.push(20);
q.push(30);
// Queue now contains: [10, 20, 30] (front -> back)
```

### Removing Elements (pop)

```cpp
std::queue<int> q;
q.push(10);
q.push(20);
q.push(30);

q.pop();  // Removes the front element (10)
// Queue now contains: [20, 30]
```

### Accessing Elements

```cpp
std::queue<int> q;
q.push(10);
q.push(20);
q.push(30);

std::cout << "Front element: " << q.front() << std::endl;  // Outputs: 10
std::cout << "Back element: " << q.back() << std::endl;    // Outputs: 30
```

### Size and Empty Checks

```cpp
std::queue<int> q;
std::cout << "Is empty: " << (q.empty() ? "Yes" : "No") << std::endl;  // Outputs: Yes

q.push(10);
q.push(20);

std::cout << "Size: " << q.size() << std::endl;  // Outputs: 2
std::cout << "Is empty: " << (q.empty() ? "Yes" : "No") << std::endl;  // Outputs: No
```

### Swapping Queues

```cpp
std::queue<int> q1;
q1.push(10);
q1.push(20);

std::queue<int> q2;
q2.push(30);
q2.push(40);
q2.push(50);

// Swap contents
q1.swap(q2);

// Now q1 contains [30, 40, 50] and q2 contains [10, 20]
```

## Complete Example: Simple Queue Implementation

```cpp
#include <iostream>
#include <queue>
#include <string>

int main() {
    // Create a queue of strings
    std::queue<std::string> taskQueue;
    
    // Add tasks to the queue
    taskQueue.push("Send email");
    taskQueue.push("Generate report");
    taskQueue.push("Update database");
    
    std::cout << "Number of tasks: " << taskQueue.size() << std::endl;
    
    // Process tasks in FIFO order
    while (!taskQueue.empty()) {
        // Get the front task
        std::string currentTask = taskQueue.front();
        
        // Remove it from the queue
        taskQueue.pop();
        
        // Process the task
        std::cout << "Processing task: " << currentTask << std::endl;
    }
    
    std::cout << "All tasks completed!" << std::endl;
    return 0;
}
```

## Practical Example: Breadth-First Search using Queue

```cpp
#include <iostream>
#include <queue>
#include <vector>
#include <unordered_map>
#include <unordered_set>

// Simple graph represented as an adjacency list
using Graph = std::unordered_map<int, std::vector<int>>;

// Breadth-First Search using std::queue
void bfs(const Graph& graph, int start) {
    std::queue<int> q;
    std::unordered_set<int> visited;
    
    // Start with the initial node
    q.push(start);
    visited.insert(start);
    
    while (!q.empty()) {
        // Get the front node
        int current = q.front();
        q.pop();
        
        std::cout << "Visiting node: " << current << std::endl;
        
        // Visit all neighbors
        for (int neighbor : graph.at(current)) {
            if (visited.find(neighbor) == visited.end()) {
                // Add unvisited neighbors to the queue
                q.push(neighbor);
                visited.insert(neighbor);
            }
        }
    }
}

int main() {
    // Create a simple graph
    Graph graph = {
        {1, {2, 3, 4}},
        {2, {1, 5}},
        {3, {1, 6, 7}},
        {4, {1, 8}},
        {5, {2}},
        {6, {3}},
        {7, {3}},
        {8, {4}}
    };
    
    // Perform BFS starting from node 1
    std::cout << "BFS traversal starting from node 1:" << std::endl;
    bfs(graph, 1);
    
    return 0;
}
```

## Performance Considerations

* **Time Complexity**:
  * `push()`: O(1) amortized
  * `pop()`: O(1)
  * `front()`: O(1)
  * `back()`: O(1)
  * `empty()`: O(1)
  * `size()`: O(1)

* **Memory**: Depends on the underlying container, but generally efficient

## Limitations

* Cannot access elements in the middle of the queue directly
* Cannot iterate through elements (no begin/end iterators)
* No random access to elements
* Cannot remove elements from arbitrary positions

## When to Use std::queue

* When you need a strict FIFO policy
* Task scheduling
* BFS algorithms
* Print job spooling
* Any scenario where elements must be processed in the order they arrive

## Comparison with Other Containers

* **std::stack**: LIFO (Last-In-First-Out) vs `std::queue`'s FIFO
* **std::priority_queue**: Elements processed based on priority rather than insertion order
* **std::deque**: More flexible - allows insertion/removal at both ends and random access

## Conclusion

`std::queue` is a simple but powerful container adaptor that provides efficient FIFO operations. It's highly useful for scenarios where maintaining processing order is critical, such as BFS algorithms or task scheduling.
