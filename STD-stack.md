# C++ STL std::stack Summary

## Introduction

`std::stack` is a container adapter in the C++ Standard Template Library (STL) that provides a LIFO (Last-In-First-Out) data structure. Unlike sequence containers like `vector` or `deque`, `std::stack` is not a standalone container but rather an adapter that uses an underlying container to store its elements.

## Key Characteristics

- **LIFO Principle**: Elements are inserted and removed only from one end (the top).
- **Container Adapter**: It's implemented on top of other STL containers (by default `std::deque`).
- **Restricted Access**: Only the top element is accessible directly.
- **No Iterators**: Unlike most STL containers, stack doesn't provide iterators.
- **Header File**: `#include <stack>`

## Underlying Container

By default, `std::stack` uses `std::deque` as its underlying container, but it can also use:
- `std::vector`
- `std::list`
- Any container that supports:
  - `push_back()`, `pop_back()`
  - `back()`
  - `empty()`
  - `size()`

## Basic Operations

| Operation | Description | Time Complexity |
|-----------|-------------|-----------------|
| `push()` | Adds an element to the top | O(1) |
| `pop()` | Removes the top element | O(1) |
| `top()` | Accesses the top element | O(1) |
| `empty()` | Checks if the stack is empty | O(1) |
| `size()` | Returns the number of elements | O(1) |

## Code Examples

### Basic Usage

```cpp
#include <iostream>
#include <stack>

int main() {
    // Create a stack of integers (using default deque container)
    std::stack<int> myStack;
    
    // Push elements onto the stack
    myStack.push(10);
    myStack.push(20);
    myStack.push(30);
    
    // Check size
    std::cout << "Stack size: " << myStack.size() << std::endl;  // Output: 3
    
    // Access top element
    std::cout << "Top element: " << myStack.top() << std::endl;  // Output: 30
    
    // Pop elements
    myStack.pop();
    std::cout << "After pop, top element: " << myStack.top() << std::endl;  // Output: 20
    
    // Check if empty
    std::cout << "Is stack empty? " << (myStack.empty() ? "Yes" : "No") << std::endl;  // Output: No
    
    // Pop remaining elements
    while (!myStack.empty()) {
        std::cout << "Popping: " << myStack.top() << std::endl;
        myStack.pop();
    }
    
    return 0;
}
```

### Using Different Underlying Containers

```cpp
#include <iostream>
#include <stack>
#include <vector>
#include <list>

int main() {
    // Stack using vector as underlying container
    std::stack<int, std::vector<int>> vectorStack;
    vectorStack.push(100);
    vectorStack.push(200);
    
    // Stack using list as underlying container
    std::stack<int, std::list<int>> listStack;
    listStack.push(300);
    listStack.push(400);
    
    std::cout << "Vector stack top: " << vectorStack.top() << std::endl;  // Output: 200
    std::cout << "List stack top: " << listStack.top() << std::endl;      // Output: 400
    
    return 0;
}
```

### Stack of Custom Objects

```cpp
#include <iostream>
#include <stack>
#include <string>

struct User {
    std::string name;
    int id;
    
    User(const std::string& n, int i) : name(n), id(i) {}
};

int main() {
    std::stack<User> userStack;
    
    userStack.push(User("Alice", 1001));
    userStack.push(User("Bob", 1002));
    userStack.push(User("Charlie", 1003));
    
    while (!userStack.empty()) {
        User currentUser = userStack.top();
        std::cout << "User: " << currentUser.name << ", ID: " << currentUser.id << std::endl;
        userStack.pop();
    }
    
    return 0;
}
```

### Real-world Example: Balanced Parentheses

```cpp
#include <iostream>
#include <stack>
#include <string>

bool areParenthesesBalanced(const std::string& expr) {
    std::stack<char> s;
    
    for (char c : expr) {
        if (c == '(' || c == '[' || c == '{') {
            // Push opening brackets onto stack
            s.push(c);
        } else if (c == ')' || c == ']' || c == '}') {
            // For closing brackets, check if stack is empty
            if (s.empty()) {
                return false;
            }
            
            // Check if matching opening bracket
            char top = s.top();
            if ((c == ')' && top == '(') || 
                (c == ']' && top == '[') || 
                (c == '}' && top == '{')) {
                s.pop();
            } else {
                return false;
            }
        }
    }
    
    // If stack is empty, all brackets were matched
    return s.empty();
}

int main() {
    std::string expr1 = "{[()]}";
    std::string expr2 = "{[(])}";
    
    std::cout << expr1 << " is " << (areParenthesesBalanced(expr1) ? "balanced" : "not balanced") << std::endl;
    std::cout << expr2 << " is " << (areParenthesesBalanced(expr2) ? "balanced" : "not balanced") << std::endl;
    
    return 0;
}
```

## Limitations

1. **Limited Access**: Can only access the top element
2. **No Iterators**: Cannot iterate through elements
3. **No Random Access**: Cannot access elements by index
4. **No Sorting/Searching**: No built-in algorithms for sorting or searching

## When to Use std::stack

- When you need strict LIFO behavior
- For algorithms requiring backtracking
- For expression evaluation or parsing
- For undo mechanisms in applications
- For depth-first traversals in graph algorithms

## When Not to Use std::stack

- When you need random access to elements
- When you need to search for elements
- When you need to process elements in order other than LIFO
- When you need to iterate through all elements

## Performance Considerations

The performance of `std::stack` operations depends on the underlying container:

- With `std::deque` (default): O(1) for all operations
- With `std::vector`: O(1) for most operations, but potentially O(n) for `push()` when reallocation occurs
- With `std::list`: O(1) for all operations, but with higher constant factors due to memory allocation overhead

## Comparison with std::queue

| Feature | std::stack | std::queue |
|---------|-----------|------------|
| Principle | LIFO (Last-In-First-Out) | FIFO (First-In-First-Out) |
| Access | Top only | Front and Back |
| Default Container | deque | deque |
| Main Use Cases | Backtracking, Parsing | Sequential processing |
