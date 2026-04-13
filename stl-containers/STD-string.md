# C++ String Handling: std::string, char*, const char*, and String Literals

## Introduction

This document summarizes the key concepts from "STL std::string, char*, const char*, and string literals in C++ | Modern Cpp Series Ep. 112". It covers the different ways to represent and work with strings in C++, with a focus on modern C++ practices.

## String Representations in C++

C++ offers multiple ways to represent strings:

1. **C-style strings**: Null-terminated character arrays (`char*`, `const char*`)
2. **std::string**: C++ Standard Library string class
3. **String literals**: Text enclosed in quotes, which are `const char[]` arrays
4. **Raw string literals**: A C++11 feature for handling special characters

## C-style Strings

C-style strings are arrays of characters with a null terminator (`\0`).

```cpp
// C-style string declarations
char greeting[] = "Hello"; // Creates a char array with {'H','e','l','l','o','\0'}
char* ptr = greeting;      // Pointer to the first character
const char* constPtr = "World"; // Pointer to string literal (immutable)
```

### Key points about C-style strings:

- Must be null-terminated to work properly with C string functions
- Have no built-in bounds checking
- Require manual memory management
- Cannot be easily resized once allocated

```cpp
// Common operations with C-style strings
#include <cstring> // For string functions

// String length
size_t len = strlen(greeting); // Returns 5 (not counting null terminator)

// String copy
char destination[20];
strcpy(destination, greeting); // Copies "Hello" to destination

// String concatenation
strcat(destination, " World"); // destination now contains "Hello World"

// String comparison
int result = strcmp(greeting, "Hello"); // Returns 0 if equal
```

## std::string

The `std::string` class provides a safer, more flexible alternative to C-style strings.

```cpp
#include <string>

// std::string declarations
std::string str1 = "Hello";
std::string str2{"World"};
std::string str3(10, 'a'); // Creates "aaaaaaaaaa"
```

### Advantages of std::string:

- Dynamic size management
- Bounds checking
- Rich set of member functions
- No need to worry about null terminators
- Proper memory management (RAII)

```cpp
// Common operations with std::string
#include <string>

std::string s1 = "Hello";
std::string s2 = "World";

// String concatenation
std::string result = s1 + " " + s2; // "Hello World"

// Substring
std::string sub = result.substr(0, 5); // "Hello"

// Find
size_t pos = result.find("World"); // Returns 6

// Length
size_t len = result.length(); // Returns 11

// Element access
char firstChar = result[0]; // 'H'
char lastChar = result.back(); // 'd'

// Append
s1.append(" there"); // s1 becomes "Hello there"

// Insert
s1.insert(5, ","); // s1 becomes "Hello, there"

// Erase
s1.erase(5, 2); // s1 becomes "Hello there" again

// Replace
s1.replace(0, 5, "Hi"); // s1 becomes "Hi there"
```

## Conversions Between Types

Converting between string types is a common operation:

```cpp
// From std::string to const char*
std::string str = "Hello";
const char* cstr = str.c_str(); // Returns pointer to null-terminated array

// From const char* to std::string
const char* cstr2 = "World";
std::string str2(cstr2); // Constructs string from const char*

// Be careful with scope!
const char* dangerous;
{
    std::string temp = "Temporary";
    dangerous = temp.c_str(); // DANGEROUS! Points to memory that will be freed
} // temp is destroyed here, dangerous now points to invalid memory

// Safe approach
std::string keepAlive = "Safe";
const char* safe = keepAlive.c_str(); // Safe as long as keepAlive exists
```

## String Literals

String literals in C++ have specific types and properties:

```cpp
// Regular string literal
const char* s1 = "Hello"; // Type is const char[6]

// Raw string literals (C++11)
const char* s2 = R"(Hello\nWorld)"; // Backslash is treated as literal character

// Custom delimiter for raw strings
const char* s3 = R"delim(Hello "quoted" text)delim"; // Handles quotes inside

// String literal suffix (C++14)
auto s4 = "Hello"s; // Type is std::string (requires using namespace std::string_literals)
auto s5 = u8"Hello"; // UTF-8 string (char8_t in C++20)
auto s6 = u"Hello";  // UTF-16 string (char16_t)
auto s7 = U"Hello";  // UTF-32 string (char32_t)
auto s8 = L"Hello";  // Wide string (wchar_t)
```

## Using string_view (C++17)

`std::string_view` provides a non-owning reference to a string:

```cpp
#include <string_view>

void process(std::string_view sv) {
    // Works efficiently with both std::string and const char*
    // without making copies
    std::cout << "First char: " << sv[0] << std::endl;
    std::cout << "Length: " << sv.length() << std::endl;
}

int main() {
    std::string str = "Hello";
    const char* cstr = "World";
    
    process(str);   // No conversion needed
    process(cstr);  // No conversion needed
    process("Literal"); // Works directly with literals
    
    return 0;
}
```

## Best Practices

1. **Prefer std::string** for general string handling
2. **Use std::string_view** for read-only string arguments (C++17)
3. **Use const char*** when interfacing with C libraries
4. **Use raw string literals** for regex patterns, file paths, or multi-line strings
5. **Be aware of ownership** when converting between types
6. **Avoid C-style functions** like `strcpy` and `strcat` in modern C++ code

```cpp
// Modern C++ string handling example
#include <string>
#include <string_view>
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std::string_literals; // For "..."s string literal

void printUppercase(std::string_view text) {
    std::string copy{text}; // Create modifiable copy
    std::transform(copy.begin(), copy.end(), copy.begin(), ::toupper);
    std::cout << copy << std::endl;
}

int main() {
    // Collection of strings
    std::vector<std::string> names = {
        "Alice"s,
        "Bob"s,
        "Charlie"s
    };
    
    // Process a std::string
    printUppercase(names[0]); // ALICE
    
    // Process a string literal
    printUppercase("Direct literal"); // DIRECT LITERAL
    
    // Raw string with multiple lines
    std::string multiline = R"(
        This is a
        multi-line
        string
    )";
    
    // Process part of a string (no copy created)
    std::string_view view = multiline;
    std::string_view firstLine = view.substr(0, view.find('\n'));
    std::cout << "First line: " << firstLine << std::endl;
    
    return 0;
}
```

## Conclusion

Understanding the different string types in C++ is essential for writing efficient and correct code. While C-style strings are still used (especially when interfacing with C libraries), modern C++ code should generally prefer `std::string` and `std::string_view` for safety, flexibility, and convenience.
