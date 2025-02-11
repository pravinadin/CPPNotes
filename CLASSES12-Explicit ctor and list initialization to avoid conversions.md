## Summary: C++ Tips for Safer Code - `explicit` Constructor & List Initialization

This document summarizes the YouTube video "Classes part 12-Explicit ctor and list initialization to avoid conversions | Modern Cpp Series Ep. 48" by Mike Shah. The video discusses two C++ techniques to improve code safety by preventing unintended type conversions: using the `explicit` keyword for constructors and employing list initialization with curly braces.

### 1\. Explicit Constructors

**Problem: Implicit Conversions**

C++ constructors with a single parameter, by default, allow *implicit conversions*. This means the compiler can automatically convert values of different types to the class type. While sometimes convenient, this can lead to unexpected behavior and subtle errors, especially when unintended type conversions occur without warning.

**Code Example (Implicit Conversion Allowed):**

```cpp
class udt {
public:
    udt(int value) : val(value) {} // Constructor (implicit conversion allowed)
private:
    int val;
};

int main() {
    udt u1 = 500;     // Implicit conversion: int 500 to udt (OK)
    udt u2 = 500.5f;  // Implicit conversion: float 500.5f to udt (truncated to 500 - Potential Data Loss!)
    return 0;
}
```

In this example, the code compiles even when initializing a udt object with a float (500.5f). The float is implicitly converted to an int (500), potentially leading to data loss without any compiler warning.

Solution: The explicit Keyword

Prefixing a constructor with the explicit keyword prevents implicit conversions. An explicit constructor can only be used for direct initialization, making the code safer and more predictable.

Code Example (Explicit Constructor):

C++

```cpp

class udt {
public:
    explicit udt(int value) : val(value) {} // Explicit constructor
private:
    int val;
};

int main() {
    udt u1 = 500;     // Compile-time error: implicit conversion not allowed
    udt u2 = 500.5f;  // Compile-time error: implicit conversion not allowed
    udt u3(500);    // Direct initialization: OK
    udt u4 = udt(500); // Direct initialization: OK
    return 0;
}

With the explicit keyword, lines attempting implicit conversions (udt u1 = 500; and udt u2 = 500.5f;) will now result in compile-time errors, enforcing explicit initialization and improving type safety.

### 2\. List Initialization (Curly Braces)

**Problem: Narrowing Conversions

Narrowing conversions occur when a value is converted to a data type that cannot fully represent it (e.g., converting a double to an int, potentially losing precision).  Standard initialization might allow these conversions without explicit warnings in some cases.

Solution: List Initialization with Curly Braces {}

Using curly braces {} for list initialization when creating objects provides enhanced type safety by disallowing narrowing conversions.

Code Example (List Initialization):

C++

```cpp
class udt {
public:
    explicit udt(int value) : val(value) {}
private:
    int val;
};

int main() {
    udt u1{500};     // OK: Direct initialization with integer
    udt u2{500.5f};  // Compile-time error: Narrowing conversion from float to int - Prevents Data Loss!
    return 0;
}
```
Here, udt u2{500.5f}; will cause a compile-time error because list initialization prevents the narrowing conversion from float to int. This helps catch potential data loss issues during compilation.

### Conclusion:

Employing explicit constructors and list initialization are valuable C++ practices that contribute to writing more robust and safer code. They help prevent unintended type conversions and data loss, making your code more maintainable and less prone to errors, especially in larger and more complex projects.
