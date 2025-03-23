# STL std::vector | Modern C++ Series

## Introduction
`std::vector` is one of the most commonly used containers in the C++ Standard Template Library (STL). It provides a dynamic array implementation that automatically handles memory management while offering fast random access to elements.

## Key Features of std::vector

- Dynamic array that grows automatically as elements are added
- Contiguous memory storage (elements stored in adjacent memory locations)
- Fast random access to elements (constant time)
- Efficient insertion/removal at the end (amortized constant time)
- Automatic memory management

## Basic Usage

### Including the Vector Header

```cpp
#include <vector>
```

### Creating Vectors

```cpp
// Empty vector of integers
std::vector<int> vec1;

// Vector with 5 elements, all initialized to 0
std::vector<int> vec2(5);

// Vector with 5 elements, all initialized to 42
std::vector<int> vec3(5, 42);

// Vector initialized with list
std::vector<int> vec4 = {1, 2, 3, 4, 5};

// C++11 list initialization
std::vector<int> vec5{10, 20, 30, 40, 50};

// Vector constructed from another vector
std::vector<int> vec6(vec5);

// Using iterators to construct a vector
std::vector<int> vec7(vec4.begin(), vec4.end());
```

## Element Access

```cpp
std::vector<int> vec = {10, 20, 30, 40, 50};

// Access using the subscript operator
int first = vec[0];       // 10 (no bounds checking)

// Access using at() method
int second = vec.at(1);   // 20 (with bounds checking, throws std::out_of_range)

// Get the first element
int front_val = vec.front();  // 10

// Get the last element
int back_val = vec.back();    // 50

// Get pointer to the underlying array
int* data = vec.data();   // Direct access to memory
```

## Modifying the Vector

```cpp
std::vector<int> vec;

// Add elements to the end
vec.push_back(10);    // vec: {10}
vec.push_back(20);    // vec: {10, 20}

// C++11 emplace_back (constructs element in-place)
vec.emplace_back(30); // vec: {10, 20, 30}

// Insert at a specific position (slower than push_back)
vec.insert(vec.begin() + 1, 15);  // vec: {10, 15, 20, 30}

// Insert multiple elements
vec.insert(vec.begin(), 2, 5);    // vec: {5, 5, 10, 15, 20, 30}

// Remove the last element
vec.pop_back();               // vec: {5, 5, 10, 15, 20}

// Remove element at a specific position
vec.erase(vec.begin() + 2);   // vec: {5, 5, 15, 20}

// Remove a range of elements
vec.erase(vec.begin(), vec.begin() + 2);  // vec: {15, 20}

// Clear all elements
vec.clear();  // vec: {}
```

## Vector Size and Capacity

```cpp
std::vector<int> vec = {1, 2, 3, 4, 5};

// Get the number of elements
size_t size = vec.size();       // 5

// Check if vector is empty
bool is_empty = vec.empty();    // false

// Get current capacity
size_t capacity = vec.capacity();  // Implementation-dependent, >= 5

// Change the size
vec.resize(10);      // vec: {1, 2, 3, 4, 5, 0, 0, 0, 0, 0}
vec.resize(3);       // vec: {1, 2, 3}

// Reserve capacity (doesn't change size)
vec.reserve(20);     // Capacity >= 20, size still 3

// Shrink capacity to fit current size
vec.shrink_to_fit(); // Capacity becomes close to size
```

## Iterating Through a Vector

```cpp
std::vector<int> vec = {10, 20, 30, 40, 50};

// Using index-based for loop
for (size_t i = 0; i < vec.size(); ++i) {
    std::cout << vec[i] << " ";
}  // Output: 10 20 30 40 50

// Using iterator-based for loop
for (auto it = vec.begin(); it != vec.end(); ++it) {
    std::cout << *it << " ";
}  // Output: 10 20 30 40 50

// Using range-based for loop (C++11)
for (const auto& element : vec) {
    std::cout << element << " ";
}  // Output: 10 20 30 40 50
```

## Vector Performance Considerations

- **Accessing elements**: O(1) time complexity
- **push_back/pop_back**: Amortized O(1) time complexity
- **insert/erase in the middle**: O(n) time complexity
- **Memory reallocation**: When capacity is exceeded, vector typically doubles its capacity
- **Memory layout**: Contiguous, which is cache-friendly and optimizes performance

## Vector of Objects

```cpp
// Custom class example
class Person {
private:
    std::string name;
    int age;
    
public:
    Person(std::string n, int a) : name(n), age(a) {}
    
    void display() const {
        std::cout << name << ", " << age << " years old" << std::endl;
    }
};

// Creating a vector of Person objects
std::vector<Person> people;

// Adding elements
people.push_back(Person("Alice", 25));
people.emplace_back("Bob", 30);  // More efficient with emplace_back

// Accessing and using
for (const auto& person : people) {
    person.display();
}
```

## Vector of Vectors (2D Vector)

```cpp
// Creating a 2D vector (3x4 matrix initialized to 0)
std::vector<std::vector<int>> matrix(3, std::vector<int>(4, 0));

// Setting values
matrix[0][0] = 1;
matrix[1][2] = 5;

// Accessing the 2D vector
for (const auto& row : matrix) {
    for (const auto& element : row) {
        std::cout << element << " ";
    }
    std::cout << std::endl;
}
```

## Common Vector Algorithms

```cpp
#include <algorithm>
#include <vector>

std::vector<int> vec = {5, 2, 8, 1, 3};

// Sorting a vector
std::sort(vec.begin(), vec.end());  // vec: {1, 2, 3, 5, 8}

// Finding an element
auto it = std::find(vec.begin(), vec.end(), 3);
if (it != vec.end()) {
    std::cout << "Found " << *it << " at position " << (it - vec.begin()) << std::endl;
}

// Checking if a value exists
bool exists = std::binary_search(vec.begin(), vec.end(), 5);  // true

// Reversing a vector
std::reverse(vec.begin(), vec.end());  // vec: {8, 5, 3, 2, 1}

// Transforming elements
std::transform(vec.begin(), vec.end(), vec.begin(),
               [](int x) { return x * 2; });  // vec: {16, 10, 6, 4, 2}
```

## Best Practices

1. **Use reserve() for known sizes**: Pre-allocate memory to avoid reallocations
   ```cpp
   vec.reserve(1000);  // Before adding many elements
   ```

2. **Prefer emplace_back() over push_back()**: More efficient for complex objects
   ```cpp
   vec.emplace_back(args...);  // Constructs in-place
   ```

3. **Use the right access method**: 
   - Use `[]` when performance matters and you're sure index is valid
   - Use `at()` when you need bounds checking

4. **Clear vs Shrink**: 
   - `clear()` sets size to 0 but keeps capacity
   - `shrink_to_fit()` reduces capacity to match size

5. **Range-based for loops**: Use them for cleaner, more readable code
   ```cpp
   for (const auto& element : vec) { /* ... */ }
   ```

## Conclusion

`std::vector` is a versatile and efficient container that should be the default choice for most sequential container needs in C++. It combines dynamic sizing with the performance benefits of contiguous memory storage, making it suitable for a wide range of applications.
