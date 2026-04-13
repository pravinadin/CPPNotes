# std::string_view vs std::string in Modern C++

## Introduction

`std::string_view` was introduced in C++17 as a non-owning reference to a string. It provides a lightweight, read-only view of a sequence of characters, without the overhead of copying that comes with `std::string`. This summary explores when and how to use `std::string_view` compared to `std::string`, with practical examples.

## Key Concepts

### What is `std::string_view`?

- A non-owning reference to a string
- Read-only access to the character sequence
- Lightweight alternative to `std::string` when ownership is not needed
- Available since C++17
- Lives in the `<string_view>` header

### Advantages of `std::string_view`

1. **Performance**: No memory allocation or copying when passing strings
2. **Versatility**: Works with any contiguous character sequence (C-style strings, `std::string`, character arrays)
3. **Memory Efficiency**: Smaller object size (typically just a pointer and a length)
4. **Reduced Copying**: Ideal for functions that only need to read string data

## When to Use `std::string_view`

Use `std::string_view` when:

- You need read-only access to string data
- You want to avoid unnecessary copying
- The function doesn't need to own or modify the string
- The lifetime of the referenced string is guaranteed to outlive the view

```cpp
// Function parameter that doesn't need ownership
bool starts_with(std::string_view str, std::string_view prefix) {
    return str.substr(0, prefix.size()) == prefix;
}

// Can be called with various string types
starts_with("Hello World", "Hello");  // C-string literals
std::string s = "Hello World";
starts_with(s, "Hello");  // std::string
```

## When to Use `std::string`

Use `std::string` when:

- You need to own the string data
- You need to modify the string
- The string needs to outlive the scope where it was created
- You need the guarantees of null-termination

```cpp
std::string build_greeting(std::string_view name) {
    // Need to create and return a new string
    return "Hello, " + std::string(name) + "!";
}
```

## Lifetime Considerations (Important!)

A common pitfall with `std::string_view` is using it after the underlying string has been destroyed:

```cpp
// DANGEROUS: Don't do this!
std::string_view dangerous() {
    std::string temp = "Temporary string";
    return std::string_view(temp);  // Returns view to destroyed string!
}

// SAFE: The string outlives the view
std::string_view safe(const std::string& s) {
    return std::string_view(s);  // Safe because 's' outlives the view
}
```

## Performance Comparison

### Memory Usage

```cpp
#include <iostream>
#include <string>
#include <string_view>

int main() {
    std::cout << "sizeof(std::string): " << sizeof(std::string) << " bytes\n";
    std::cout << "sizeof(std::string_view): " << sizeof(std::string_view) << " bytes\n";
    return 0;
}

// Output (may vary by implementation):
// sizeof(std::string): 32 bytes
// sizeof(std::string_view): 16 bytes
```

### Passing Large Strings

```cpp
#include <chrono>
#include <iostream>
#include <string>
#include <string_view>

// Using std::string (copying)
void process_string(const std::string& s) {
    // Process the string
}

// Using std::string_view (no copying)
void process_string_view(std::string_view s) {
    // Process the string
}

int main() {
    // Create a large string
    std::string large_string(1000000, 'a');
    
    // Measure time with std::string
    auto start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < 1000; ++i) {
        process_string(large_string);
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::cout << "Time with std::string: " 
              << std::chrono::duration_cast<std::chrono::microseconds>(end - start).count() 
              << " us\n";
    
    // Measure time with std::string_view
    start = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < 1000; ++i) {
        process_string_view(large_string);
    }
    end = std::chrono::high_resolution_clock::now();
    std::cout << "Time with std::string_view: " 
              << std::chrono::duration_cast<std::chrono::microseconds>(end - start).count() 
              << " us\n";
    
    return 0;
}
```

## Common Operations with `std::string_view`

### Substring Operations

```cpp
#include <iostream>
#include <string_view>

int main() {
    std::string_view sv = "Hello, World!";
    
    // Get a substring (no allocation, just adjusts pointer and length)
    std::string_view hello = sv.substr(0, 5);
    std::cout << hello << '\n';  // Outputs: Hello
    
    // Find operations
    size_t pos = sv.find(',');
    if (pos != std::string_view::npos) {
        std::string_view after_comma = sv.substr(pos + 1);
        std::cout << after_comma << '\n';  // Outputs:  World!
    }
    
    return 0;
}
```

### Working with Mixed String Types

```cpp
#include <iostream>
#include <string>
#include <string_view>

void print_length(std::string_view sv) {
    std::cout << "Length: " << sv.length() << '\n';
}

int main() {
    // Works with C-style strings
    const char* cstr = "C-style string";
    print_length(cstr);
    
    // Works with string literals
    print_length("String literal");
    
    // Works with std::string
    std::string str = "Standard string";
    print_length(str);
    
    // Works with character arrays
    char arr[] = {'A', 'r', 'r', 'a', 'y', '\0'};
    print_length(arr);
    
    return 0;
}
```

## Converting Between `std::string` and `std::string_view`

```cpp
#include <iostream>
#include <string>
#include <string_view>

int main() {
    // string_view to string (requires copying)
    std::string_view sv = "Hello";
    std::string s1(sv);
    
    // string to string_view (no copying)
    std::string s2 = "World";
    std::string_view sv2 = s2;
    
    std::cout << s1 << ' ' << sv2 << '\n';  // Outputs: Hello World
    
    return 0;
}
```

## Best Practices

1. **Use `std::string_view` for function parameters** when you only need to read the string
   ```cpp
   void analyze(std::string_view text);  // Preferred over const std::string&
   ```

2. **Be careful with string literals containing null characters**
   ```cpp
   // The view will include the null character
   std::string_view sv = "Hello\0World";
   std::cout << sv.size() << '\n';  // Prints: 11 (not 5!)
   ```

3. **Don't use `std::string_view` for class members** unless you can guarantee the lifetime of the referenced string
   ```cpp
   // Potentially dangerous
   class Widget {
       std::string_view name_;  // Risky! What does this reference?
   public:
       Widget(std::string_view name) : name_(name) {}  // Dangerous if name is temporary
   };
   
   // Better
   class Widget {
       std::string name_;  // Owns the string data
   public:
       Widget(std::string_view name) : name_(name) {}  // Copies the data
   };
   ```

4. **Prefer `std::string_view` for string literal template parameters**
   ```cpp
   template<std::string_view Name>
   class NamedEntity {
       // Use the compile-time string literal
   };
   
   // Usage
   constexpr std::string_view company = "Acme";
   NamedEntity<company> entity;
   ```

5. **Be cautious when modifying the source string**
   ```cpp
   std::string s = "Hello";
   std::string_view sv = s;
   s += ", World!";  // Modifies s, but sv might now be invalid if reallocation occurred
   ```

## Conclusion

`std::string_view` is a powerful tool for improving performance in C++ code that handles strings. It provides a lightweight, non-owning way to reference string data without unnecessary copying. However, it comes with important lifetime considerations that must be carefully managed to avoid dangling references.

- Use `std::string_view` for read-only operations and function parameters
- Use `std::string` when you need ownership or need to modify the string
- Always be mindful of the lifetime of the underlying character sequence
- Consider the trade-offs between convenience, safety, and performance

By understanding when and how to use `std::string_view` versus `std::string`, you can write more efficient C++ code without sacrificing safety or readability.
