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
