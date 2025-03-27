# C++ STL Containers Cheat Sheet

## Common Member Functions (All Containers)

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `begin()` | `iterator begin()` | Returns iterator to first element | `auto it = container.begin();` |
| `end()` | `iterator end()` | Returns iterator to one past the last element | `for(auto it = c.begin(); it != c.end(); ++it)` |
| `size()` | `size_type size() const` | Returns number of elements | `if(container.size() > 10) {...}` |
| `empty()` | `bool empty() const` | Checks if container is empty | `if(container.empty()) { return; }` |
| `clear()` | `void clear()` | Removes all elements | `container.clear();` |
| `swap()` | `void swap(container& other)` | Swaps contents with another container | `container1.swap(container2);` |

## Sequence Containers

### vector
```cpp
template < class T, class Allocator = allocator<T> > class vector;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push_back()` | `void push_back(const T& value)` | Adds element to the end | `vec.push_back(42);` |
| `pop_back()` | `void pop_back()` | Removes last element | `vec.pop_back();` |
| `at()` | `reference at(size_type pos)` | Access element with bounds checking | `int val = vec.at(5);` |
| `operator[]` | `reference operator[](size_type pos)` | Access element (no bounds checking) | `int val = vec[5];` |
| `front()` | `reference front()` | Access first element | `int first = vec.front();` |
| `back()` | `reference back()` | Access last element | `int last = vec.back();` |
| `reserve()` | `void reserve(size_type new_cap)` | Request capacity change | `vec.reserve(100);` |
| `capacity()` | `size_type capacity() const` | Returns current capacity | `size_t cap = vec.capacity();` |
| `resize()` | `void resize(size_type count, T value = T())` | Change size | `vec.resize(10, 0);` |
| `insert()` | `iterator insert(iterator pos, const T& value)` | Insert element at position | `vec.insert(vec.begin()+5, 42);` |
| `erase()` | `iterator erase(iterator pos)` | Remove element at position | `vec.erase(vec.begin()+5);` |

#### Example: vector
```cpp
#include <vector>
#include <iostream>

int main() {
    // Create a vector of integers
    std::vector<int> numbers;
    
    // Add elements to the end
    numbers.push_back(10);
    numbers.push_back(20);
    numbers.push_back(30);
    
    // Access elements
    std::cout << "First element: " << numbers.front() << std::endl;
    std::cout << "Last element: " << numbers.back() << std::endl;
    std::cout << "Element at index 1: " << numbers[1] << std::endl;
    
    // Iterate over elements
    std::cout << "All elements: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Insert an element at position 1
    numbers.insert(numbers.begin() + 1, 15);
    
    // Remove the second element
    numbers.erase(numbers.begin() + 1);
    
    // Get size
    std::cout << "Size: " << numbers.size() << std::endl;
    
    // Check if empty
    std::cout << "Is empty? " << (numbers.empty() ? "Yes" : "No") << std::endl;
    
    // Clear all elements
    numbers.clear();
    std::cout << "Size after clear: " << numbers.size() << std::endl;
    
    return 0;
}
```

### list
```cpp
template < class T, class Allocator = allocator<T> > class list;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push_back()` | `void push_back(const T& value)` | Add element to end | `lst.push_back(42);` |
| `push_front()` | `void push_front(const T& value)` | Add element to beginning | `lst.push_front(10);` |
| `pop_back()` | `void pop_back()` | Remove last element | `lst.pop_back();` |
| `pop_front()` | `void pop_front()` | Remove first element | `lst.pop_front();` |
| `front()` | `reference front()` | Access first element | `int first = lst.front();` |
| `back()` | `reference back()` | Access last element | `int last = lst.back();` |
| `insert()` | `iterator insert(iterator pos, const T& value)` | Insert element at position | `auto it = lst.begin(); lst.insert(++it, 25);` |
| `erase()` | `iterator erase(iterator pos)` | Remove element at position | `auto it = lst.begin(); lst.erase(++it);` |
| `splice()` | `void splice(iterator pos, list& other)` | Move elements from another list | `lst1.splice(lst1.begin(), lst2);` |
| `sort()` | `void sort()` | Sort elements | `lst.sort();` |
| `merge()` | `void merge(list& other)` | Merge sorted lists | `lst1.merge(lst2);` |
| `unique()` | `void unique()` | Remove consecutive duplicates | `lst.unique();` |
| `remove()` | `void remove(const T& value)` | Remove elements with specific value | `lst.remove(42);` |

#### Example: list
```cpp
#include <list>
#include <iostream>

int main() {
    // Create a list of integers
    std::list<int> numbers;
    
    // Add elements to both ends
    numbers.push_back(30);
    numbers.push_front(10);
    numbers.push_back(40);
    numbers.push_front(5);
    
    // Resulting list: 5, 10, 30, 40
    
    // Access elements
    std::cout << "First element: " << numbers.front() << std::endl;
    std::cout << "Last element: " << numbers.back() << std::endl;
    
    // Iterate over elements
    std::cout << "All elements: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Insert element in the middle
    auto it = numbers.begin();
    std::advance(it, 2); // Move iterator to the 3rd position
    numbers.insert(it, 20);
    
    // Remove element from the beginning
    numbers.pop_front();
    
    // Sort the list
    numbers.sort();
    
    std::cout << "After sort: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Remove all occurrences of value 20
    numbers.remove(20);
    
    // Create another list
    std::list<int> other = {15, 25, 35};
    
    // Splice the other list at the beginning of numbers
    numbers.splice(numbers.begin(), other);
    
    std::cout << "After splice: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

### deque
```cpp
template < class T, class Allocator = allocator<T> > class deque;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push_back()` | `void push_back(const T& value)` | Add element to end | `dq.push_back(42);` |
| `push_front()` | `void push_front(const T& value)` | Add element to beginning | `dq.push_front(10);` |
| `pop_back()` | `void pop_back()` | Remove last element | `dq.pop_back();` |
| `pop_front()` | `void pop_front()` | Remove first element | `dq.pop_front();` |
| `at()` | `reference at(size_type pos)` | Access element with bounds checking | `int val = dq.at(5);` |
| `operator[]` | `reference operator[](size_type pos)` | Access element (no bounds checking) | `int val = dq[5];` |
| `front()` | `reference front()` | Access first element | `int first = dq.front();` |
| `back()` | `reference back()` | Access last element | `int last = dq.back();` |
| `insert()` | `iterator insert(iterator pos, const T& value)` | Insert element at position | `dq.insert(dq.begin()+2, 25);` |
| `erase()` | `iterator erase(iterator pos)` | Remove element at position | `dq.erase(dq.begin()+2);` |

#### Example: deque
```cpp
#include <deque>
#include <iostream>

int main() {
    // Create a deque of integers
    std::deque<int> numbers;
    
    // Add elements to both ends
    numbers.push_back(30);
    numbers.push_front(10);
    numbers.push_back(40);
    numbers.push_front(5);
    
    // Resulting deque: 5, 10, 30, 40
    
    // Access elements using operator[]
    std::cout << "Element at index 1: " << numbers[1] << std::endl;
    std::cout << "Element at index 2: " << numbers[2] << std::endl;
    
    // Access elements with bounds checking
    try {
        std::cout << "Element at index 10: " << numbers.at(10) << std::endl;
    } catch(const std::out_of_range& e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    // Iterate over elements
    std::cout << "All elements: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Insert element in the middle
    numbers.insert(numbers.begin() + 2, 20);
    
    // Remove first element
    numbers.pop_front();
    
    std::cout << "After modifications: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Associative Containers

### map
```cpp
template < class Key, class T, class Compare = less<Key>, class Allocator = allocator<pair<const Key,T>> > class map;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `operator[]` | `T& operator[](const Key& key)` | Access or insert element | `map["key"] = value;` |
| `at()` | `T& at(const Key& key)` | Access element with bounds checking | `int val = map.at("key");` |
| `insert()` | `pair<iterator,bool> insert(const pair<Key,T>& value)` | Insert element | `map.insert({"key", 42});` |
| `erase()` | `size_type erase(const Key& key)` | Remove element by key | `map.erase("key");` |
| `find()` | `iterator find(const Key& key)` | Find element by key | `auto it = map.find("key");` |
| `count()` | `size_type count(const Key& key) const` | Count elements with key | `if(map.count("key") > 0) {...}` |
| `lower_bound()` | `iterator lower_bound(const Key& key)` | Return iterator to first element not less than key | `auto it = map.lower_bound("key");` |
| `upper_bound()` | `iterator upper_bound(const Key& key)` | Return iterator to first element greater than key | `auto it = map.upper_bound("key");` |

#### Example: map
```cpp
#include <map>
#include <string>
#include <iostream>

int main() {
    // Create a map with string keys and integer values
    std::map<std::string, int> scores;
    
    // Insert elements using different methods
    scores["Alice"] = 95;
    scores["Bob"] = 89;
    scores.insert({"Charlie", 78});
    scores.insert(std::make_pair("David", 92));
    
    // Access elements using operator[]
    std::cout << "Alice's score: " << scores["Alice"] << std::endl;
    
    // Access elements with bounds checking
    try {
        std::cout << "Eve's score: " << scores.at("Eve") << std::endl;
    } catch(const std::out_of_range& e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    // Check if a key exists
    if(scores.count("Bob") > 0) {
        std::cout << "Bob's score exists" << std::endl;
    }
    
    // Find an element
    auto it = scores.find("Charlie");
    if(it != scores.end()) {
        std::cout << "Found Charlie, score: " << it->second << std::endl;
    }
    
    // Iterate over all elements
    std::cout << "All scores:" << std::endl;
    for(const auto& pair : scores) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    
    // Erase an element
    scores.erase("David");
    
    // Use lower_bound and upper_bound
    auto lower = scores.lower_bound("Bob");
    auto upper = scores.upper_bound("Charlie");
    
    std::cout << "Range from Bob to Charlie:" << std::endl;
    for(auto it = lower; it != upper; ++it) {
        std::cout << it->first << ": " << it->second << std::endl;
    }
    
    return 0;
}
```

### set
```cpp
template < class Key, class Compare = less<Key>, class Allocator = allocator<Key> > class set;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `insert()` | `pair<iterator,bool> insert(const Key& value)` | Insert element | `set.insert(42);` |
| `erase()` | `size_type erase(const Key& key)` | Remove element by key | `set.erase(42);` |
| `find()` | `iterator find(const Key& key)` | Find element by key | `auto it = set.find(42);` |
| `count()` | `size_type count(const Key& key) const` | Count elements with key | `if(set.count(42) > 0) {...}` |
| `lower_bound()` | `iterator lower_bound(const Key& key)` | Return iterator to first element not less than key | `auto it = set.lower_bound(42);` |
| `upper_bound()` | `iterator upper_bound(const Key& key)` | Return iterator to first element greater than key | `auto it = set.upper_bound(42);` |

#### Example: set
```cpp
#include <set>
#include <iostream>

int main() {
    // Create a set of integers
    std::set<int> numbers;
    
    // Insert elements
    numbers.insert(30);
    numbers.insert(10);
    numbers.insert(50);
    numbers.insert(20);
    numbers.insert(10); // Duplicate, won't be inserted
    
    // Check size
    std::cout << "Size: " << numbers.size() << std::endl;
    
    // Iterate over elements (will be in sorted order: 10, 20, 30, 50)
    std::cout << "Elements: ";
    for(const auto& num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Check if element exists
    if(numbers.count(20) > 0) {
        std::cout << "20 exists in the set" << std::endl;
    }
    
    // Find an element
    auto it = numbers.find(30);
    if(it != numbers.end()) {
        std::cout << "Found: " << *it << std::endl;
    }
    
    // Erase an element
    numbers.erase(20);
    
    // Use lower_bound and upper_bound
    auto lower = numbers.lower_bound(15);
    auto upper = numbers.upper_bound(40);
    
    std::cout << "Range from 15 to 40:" << std::endl;
    for(auto it = lower; it != upper; ++it) {
        std::cout << *it << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

### unordered_map (C++11)
```cpp
template < class Key, class T, class Hash = hash<Key>, class KeyEqual = equal_to<Key>, class Allocator = allocator<pair<const Key,T>> > class unordered_map;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `operator[]` | `T& operator[](const Key& key)` | Access or insert element | `umap["key"] = value;` |
| `at()` | `T& at(const Key& key)` | Access element with bounds checking | `int val = umap.at("key");` |
| `insert()` | `pair<iterator,bool> insert(const pair<Key,T>& value)` | Insert element | `umap.insert({"key", 42});` |
| `erase()` | `size_type erase(const Key& key)` | Remove element by key | `umap.erase("key");` |
| `find()` | `iterator find(const Key& key)` | Find element by key | `auto it = umap.find("key");` |
| `count()` | `size_type count(const Key& key) const` | Count elements with key | `if(umap.count("key") > 0) {...}` |
| `bucket_count()` | `size_type bucket_count() const` | Number of buckets | `size_t buckets = umap.bucket_count();` |
| `load_factor()` | `float load_factor() const` | Average elements per bucket | `float lf = umap.load_factor();` |
| `rehash()` | `void rehash(size_type n)` | Set number of buckets | `umap.rehash(100);` |

#### Example: unordered_map
```cpp
#include <unordered_map>
#include <string>
#include <iostream>

int main() {
    // Create an unordered_map with string keys and integer values
    std::unordered_map<std::string, int> scores;
    
    // Insert elements
    scores["Alice"] = 95;
    scores["Bob"] = 89;
    scores.insert({"Charlie", 78});
    scores.insert(std::make_pair("David", 92));
    
    // Access elements
    std::cout << "Alice's score: " << scores["Alice"] << std::endl;
    
    // Check if key exists and find element
    if(scores.count("Bob") > 0) {
        auto it = scores.find("Bob");
        std::cout << "Found Bob, score: " << it->second << std::endl;
    }
    
    // Iterate over elements (order is not guaranteed)
    std::cout << "All scores:" << std::endl;
    for(const auto& pair : scores) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    
    // Get hash table stats
    std::cout << "Bucket count: " << scores.bucket_count() << std::endl;
    std::cout << "Load factor: " << scores.load_factor() << std::endl;
    
    // Rehash to increase bucket count
    scores.rehash(20);
    std::cout << "Bucket count after rehash: " << scores.bucket_count() << std::endl;
    
    // Erase an element
    scores.erase("David");
    
    return 0;
}
```

### unordered_set (C++11)
```cpp
template < class Key, class Hash = hash<Key>, class KeyEqual = equal_to<Key>, class Allocator = allocator<Key> > class unordered_set;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `insert()` | `pair<iterator,bool> insert(const Key& value)` | Insert element | `uset.insert(42);` |
| `erase()` | `size_type erase(const Key& key)` | Remove element by key | `uset.erase(42);` |
| `find()` | `iterator find(const Key& key)` | Find element by key | `auto it = uset.find(42);` |
| `count()` | `size_type count(const Key& key) const` | Count elements with key | `if(uset.count(42) > 0) {...}` |
| `bucket_count()` | `size_type bucket_count() const` | Number of buckets | `size_t buckets = uset.bucket_count();` |
| `load_factor()` | `float load_factor() const` | Average elements per bucket | `float lf = uset.load_factor();` |
| `rehash()` | `void rehash(size_type n)` | Set number of buckets | `uset.rehash(100);` |

#### Example: unordered_set
```cpp
#include <unordered_set>
#include <iostream>
#include <string>

int main() {
    // Create an unordered_set of strings
    std::unordered_set<std::string> names;
    
    // Insert elements
    names.insert("Alice");
    names.insert("Bob");
    names.insert("Charlie");
    names.insert("Alice"); // Duplicate, won't be inserted
    
    // Check size
    std::cout << "Size: " << names.size() << std::endl;
    
    // Check if element exists
    if(names.count("Bob") > 0) {
        std::cout << "Bob exists in the set" << std::endl;
    }
    
    // Find an element
    auto it = names.find("Charlie");
    if(it != names.end()) {
        std::cout << "Found: " << *it << std::endl;
    }
    
    // Iterate over elements (order is not guaranteed)
    std::cout << "Elements: ";
    for(const auto& name : names) {
        std::cout << name << " ";
    }
    std::cout << std::endl;
    
    // Get hash table stats
    std::cout << "Bucket count: " << names.bucket_count() << std::endl;
    std::cout << "Load factor: " << names.load_factor() << std::endl;
    
    // Erase an element
    names.erase("Bob");
    
    // Iterate again to see change
    std::cout << "After erasing Bob: ";
    for(const auto& name : names) {
        std::cout << name << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Container Adapters

### stack
```cpp
template < class T, class Container = deque<T> > class stack;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push()` | `void push(const T& value)` | Insert element at top | `stack.push(42);` |
| `pop()` | `void pop()` | Remove top element | `stack.pop();` |
| `top()` | `reference top()` | Access top element | `int val = stack.top();` |

#### Example: stack
```cpp
#include <stack>
#include <iostream>

int main() {
    // Create a stack of integers
    std::stack<int> numbers;
    
    // Push elements onto the stack
    numbers.push(10);
    numbers.push(20);
    numbers.push(30);
    
    // Get the top element
    std::cout << "Top element: " << numbers.top() << std::endl;
    
    // Check size
    std::cout << "Size: " << numbers.size() << std::endl;
    
    // Check if empty
    std::cout << "Is empty? " << (numbers.empty() ? "Yes" : "No") << std::endl;
    
    // Pop elements and print
    std::cout << "Elements (from top to bottom): ";
    while(!numbers.empty()) {
        std::cout << numbers.top() << " ";
        numbers.pop();
    }
    std::cout << std::endl;
    
    return 0;
}
```

### queue
```cpp
template < class T, class Container = deque<T> > class queue;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push()` | `void push(const T& value)` | Insert element at back | `queue.push(42);` |
| `pop()` | `void pop()` | Remove front element | `queue.pop();` |
| `front()` | `reference front()` | Access first element | `int val = queue.front();` |
| `back()` | `reference back()` | Access last element | `int val = queue.back();` |

#### Example: queue
```cpp
#include <queue>
#include <iostream>

int main() {
    // Create a queue of integers
    std::queue<int> numbers;
    
    // Push elements into the queue
    numbers.push(10);
    numbers.push(20);
    numbers.push(30);
    
    // Access front and back
    std::cout << "Front element: " << numbers.front() << std::endl;
    std::cout << "Back element: " << numbers.back() << std::endl;
    
    // Check size
    std::cout << "Size: " << numbers.size() << std::endl;
    
    // Pop elements and print
    std::cout << "Elements (in order of removal): ";
    while(!numbers.empty()) {
        std::cout << numbers.front() << " ";
        numbers.pop();
    }
    std::cout << std::endl;
    
    return 0;
}
```

### priority_queue
```cpp
template < class T, class Container = vector<T>, class Compare = less<typename Container::value_type> > class priority_queue;
```

| Function | Signature | Description | Example |
|----------|-----------|-------------|---------|
| `push()` | `void push(const T& value)` | Insert element | `pq.push(42);` |
| `pop()` | `void pop()` | Remove top element | `pq.pop();` |
| `top()` | `const_reference top() const` | Access top element | `int val = pq.top();` |

#### Example: priority_queue
```cpp
#include <queue>
#include <iostream>
#include <functional> // For std::greater

int main() {
    // Create a max heap (default)
    std::priority_queue<int> max_heap;
    
    // Create a min heap using std::greater
    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;
    
    // Push elements into max heap
    max_heap.push(30);
    max_heap.push(10);
    max_heap.push(50);
    max_heap.push(20);
    
    // Push same elements into min heap
    min_heap.push(30);
    min_heap.push(10);
    min_heap.push(50);
    min_heap.push(20);
    
    // Print top element of max heap (should be the largest)
    std::cout << "Max heap top: " << max_heap.top() << std::endl;
    
    // Print top element of min heap (should be the smallest)
    std::cout << "Min heap top: " << min_heap.top() << std::endl;
    
    // Pop and print all elements from max heap
    std::cout << "Max heap elements (in order of removal): ";
    while(!max_heap.empty()) {
        std::cout << max_heap.top() << " ";
        max_heap.pop();
    }
    std::cout << std::endl;
    
    // Pop and print all elements from min heap
    std::cout << "Min heap elements (in order of removal): ";
    while(!min_heap.empty()) {
        std::cout << min_heap.top() << " ";
        min_heap.pop();
    }
    std::cout << std::endl;
    
    return 0;
}
```

## Iterators

| Iterator | Container | Properties | Example |
|----------|-----------|------------|---------|
| Random Access | vector, deque, array | `it + n`, `it - n`, `it[n]`, `it1 < it2` | `auto it = vec.begin(); it += 5;` |
| Bidirectional | list, set, map, multiset, multimap | `++it`, `--it`, no random access | `auto it = lst.begin(); ++it; --it;` |
| Forward | forward_list, unordered_set, unordered_map | `++it`, no `--it` | `auto it = fwdlst.begin(); ++it;` |

## Algorithms (Common)

| Algorithm | Signature | Description | Example |
|-----------|-----------|-------------|---------|
| `sort` | `void sort(Iterator first, Iterator last)` | Sort elements | `std::sort(vec.begin(), vec.end());` |
| `find` | `Iterator find(Iterator first, Iterator last, const T& value)` | Find element | `auto it = std::find(vec.begin(), vec.end(), 42);` |
| `count` | `size_t count(Iterator first, Iterator last, const T& value)` | Count elements with value | `auto n = std::count(vec.begin(), vec.end(), 42);` |
| `copy` | `OutputIterator copy(Iterator first, Iterator last, OutputIterator result)` | Copy elements | `std::copy(vec1.begin(), vec1.end(), vec2.begin());` |
| `for_each` | `Function for_each(Iterator first, Iterator last, Function fn)` | Apply function to range | `std::for_each(vec.begin(), vec.end(), [](int& n){ n *= 2; });` |
| `transform` | `OutputIterator transform(Iterator first, Iterator last, OutputIterator result, Function fn)` | Transform range with function | `std::transform(vec1.begin(), vec1.end(), vec2.begin(), [](int n){ return n * 2; });` |
| `remove` | `Iterator remove(Iterator first, Iterator last, const T& value)` | Remove elements with value | `auto it = std::remove(vec.begin(), vec.end(), 42);` |
| `replace` | `void replace(Iterator first, Iterator last, const T& old_value, const T& new_value)` | Replace old values with new
