# Operator Overloading in Modern C++

## Introduction

Operator overloading is a powerful feature in C++ that allows programmers to redefine the behavior of operators for user-defined types. This enables more intuitive and readable code by using familiar operators like `+`, `-`, `*`, `==`, etc. with custom classes.

## Key Concepts

- Operator overloading allows operators to work with user-defined types
- Can be implemented as member functions or non-member functions
- Should maintain intuitive operator semantics (follow the principle of least surprise)
- Commonly used for mathematical types, iterators, smart pointers, and custom containers

## Basic Syntax

There are two main ways to implement operator overloading:

1. **Member function approach**:
   ```cpp
   class MyClass {
   public:
       // Binary operator as member function
       MyClass operator+(const MyClass& rhs) const;
       
       // Unary operator as member function
       MyClass operator-() const;
       
       // Compound assignment operator
       MyClass& operator+=(const MyClass& rhs);
   };
   ```

2. **Non-member function approach**:
   ```cpp
   // Binary operator as non-member function
   MyClass operator+(const MyClass& lhs, const MyClass& rhs);
   
   // Binary operator with different types
   MyClass operator*(const MyClass& lhs, double factor);
   MyClass operator*(double factor, const MyClass& rhs);
   ```

## Common Operators to Overload

### Arithmetic Operators

```cpp
class Vector2D {
private:
    double x, y;

public:
    Vector2D(double x = 0.0, double y = 0.0) : x(x), y(y) {}
    
    // Addition
    Vector2D operator+(const Vector2D& rhs) const {
        return Vector2D(x + rhs.x, y + rhs.y);
    }
    
    // Subtraction
    Vector2D operator-(const Vector2D& rhs) const {
        return Vector2D(x - rhs.x, y - rhs.y);
    }
    
    // Compound assignment
    Vector2D& operator+=(const Vector2D& rhs) {
        x += rhs.x;
        y += rhs.y;
        return *this;
    }
    
    // Scalar multiplication (member function)
    Vector2D operator*(double scalar) const {
        return Vector2D(x * scalar, y * scalar);
    }
    
    // Getters
    double getX() const { return x; }
    double getY() const { return y; }
};

// Scalar multiplication (non-member function for commutative property)
Vector2D operator*(double scalar, const Vector2D& vec) {
    return vec * scalar;  // Reuse the member function
}
```

### Comparison Operators

```cpp
class Complex {
private:
    double real, imag;

public:
    Complex(double r = 0.0, double i = 0.0) : real(r), imag(i) {}
    
    // Equality
    bool operator==(const Complex& rhs) const {
        return (real == rhs.real) && (imag == rhs.imag);
    }
    
    // Inequality (C++20 provides this automatically if == is defined)
    bool operator!=(const Complex& rhs) const {
        return !(*this == rhs);
    }
    
    // Less than (for ordering in containers)
    bool operator<(const Complex& rhs) const {
        // Magnitude comparison
        return (real * real + imag * imag) < (rhs.real * rhs.real + rhs.imag * rhs.imag);
    }
    
    // Getters
    double getReal() const { return real; }
    double getImag() const { return imag; }
};
```

### Stream Operators

```cpp
class Person {
private:
    std::string name;
    int age;

public:
    Person(const std::string& n = "", int a = 0) : name(n), age(a) {}
    
    // These are typically non-member functions but declared as friends
    friend std::ostream& operator<<(std::ostream& os, const Person& p);
    friend std::istream& operator>>(std::istream& is, Person& p);
};

// Output stream operator
std::ostream& operator<<(std::ostream& os, const Person& p) {
    os << "Name: " << p.name << ", Age: " << p.age;
    return os;  // Return the stream for chaining
}

// Input stream operator
std::istream& operator>>(std::istream& is, Person& p) {
    is >> p.name >> p.age;
    return is;  // Return the stream for chaining
}
```

### Subscript Operator

```cpp
class Matrix {
private:
    std::vector<std::vector<double>> data;
    size_t rows, cols;

public:
    Matrix(size_t r, size_t c) : rows(r), cols(c) {
        data.resize(rows, std::vector<double>(cols, 0.0));
    }
    
    // Const version - for reading
    const std::vector<double>& operator[](size_t row) const {
        return data[row];
    }
    
    // Non-const version - for writing
    std::vector<double>& operator[](size_t row) {
        return data[row];
    }
};
```

### Function Call Operator

```cpp
class Adder {
private:
    double base;

public:
    Adder(double b = 0.0) : base(b) {}
    
    // Function call operator
    double operator()(double x) const {
        return base + x;
    }
};

// Usage
Adder add5(5.0);
double result = add5(3.0);  // Returns 8.0
```

### Increment and Decrement Operators

```cpp
class Counter {
private:
    int count;

public:
    Counter(int c = 0) : count(c) {}
    
    // Pre-increment
    Counter& operator++() {
        ++count;
        return *this;
    }
    
    // Post-increment (note the dummy int parameter)
    Counter operator++(int) {
        Counter temp(*this);  // Make a copy
        ++count;             // Increment original
        return temp;         // Return the copy (pre-incremented value)
    }
    
    // Pre-decrement
    Counter& operator--() {
        --count;
        return *this;
    }
    
    // Post-decrement
    Counter operator--(int) {
        Counter temp(*this);
        --count;
        return temp;
    }
    
    int getCount() const { return count; }
};
```

### Conversion Operators

```cpp
class Fraction {
private:
    int numerator;
    int denominator;

public:
    Fraction(int num = 0, int denom = 1) : numerator(num), denominator(denom) {
        if (denominator == 0) throw std::invalid_argument("Denominator cannot be zero");
    }
    
    // Conversion operator to double
    explicit operator double() const {
        return static_cast<double>(numerator) / denominator;
    }
    
    // Conversion operator to bool
    explicit operator bool() const {
        return numerator != 0;
    }
};

// Usage
Fraction f(3, 4);
double d = static_cast<double>(f);  // d = 0.75
bool b = static_cast<bool>(f);      // b = true (because numerator is non-zero)
```

## Best Practices

1. **Maintain expected semantics**: Operators should behave as users would expect.

2. **Consistency with compound assignment**: When overloading binary operators like `+`, also overload the corresponding compound assignment operator like `+=`, and implement it efficiently.

3. **Return references from compound assignments**: Operators like `+=` should return a reference to allow chaining.

4. **Implement related operators together**: If you overload `==`, also overload `!=`. In C++20, only `==` is needed as `!=` is automatically derived.

5. **Mark conversion operators as explicit**: Use the `explicit` keyword to prevent unexpected implicit conversions.

6. **Use non-member functions when appropriate**: Especially for binary operators with symmetrical behavior.

7. **Leverage operator chaining**: Return references to enable idiomatic chaining of operators.

## Modern C++ Considerations (C++20)

1. **Defaulted comparison operators**: C++20 introduces the `<=>` spaceship operator and allows automatic generation of comparison operators.

```cpp
class Point {
private:
    int x, y;

public:
    Point(int x = 0, int y = 0) : x(x), y(y) {}
    
    // Automatically generates ==, !=, <, <=, >, >=
    auto operator<=>(const Point&) const = default;
};
```

2. **Using concepts to constrain operators**: C++20 concepts can be used to create more flexible yet type-safe operator overloads.

```cpp
template<typename T>
concept Numeric = std::is_arithmetic_v<T>;

class Value {
private:
    double val;

public:
    Value(double v) : val(v) {}
    
    // Only allows numeric types for the right-hand side
    template<Numeric T>
    Value operator+(T rhs) const {
        return Value(val + rhs);
    }
    
    double get() const { return val; }
};
```

## Common Mistakes to Avoid

1. Changing the expected behavior of operators
2. Not handling edge cases (e.g., division by zero)
3. Forgetting to return the correct reference types
4. Making conversion operators implicit when they should be explicit
5. Creating unnecessary temporary objects
6. Not considering const-correctness
7. Overloading operators that don't make logical sense for your class

## Example: A Complete String Class

```cpp
class MyString {
private:
    char* data;
    size_t length;

    // Helper to copy data
    void copyFrom(const char* src, size_t len) {
        data = new char[len + 1];
        memcpy(data, src, len);
        data[len] = '\0';
        length = len;
    }

public:
    // Constructor
    MyString(const char* str = "") {
        length = strlen(str);
        copyFrom(str, length);
    }
    
    // Copy constructor
    MyString(const MyString& other) {
        copyFrom(other.data, other.length);
    }
    
    // Move constructor
    MyString(MyString&& other) noexcept : data(other.data), length(other.length) {
        other.data = nullptr;
        other.length = 0;
    }
    
    // Destructor
    ~MyString() {
        delete[] data;
    }
    
    // Copy assignment
    MyString& operator=(const MyString& other) {
        if (this != &other) {
            delete[] data;
            copyFrom(other.data, other.length);
        }
        return *this;
    }
    
    // Move assignment
    MyString& operator=(MyString&& other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            length = other.length;
            other.data = nullptr;
            other.length = 0;
        }
        return *this;
    }
    
    // Addition operator
    MyString operator+(const MyString& other) const {
        MyString result;
        delete[] result.data;
        result.length = length + other.length;
        result.data = new char[result.length + 1];
        memcpy(result.data, data, length);
        memcpy(result.data + length, other.data, other.length + 1);
        return result;
    }
    
    // Compound addition
    MyString& operator+=(const MyString& other) {
        size_t newLength = length + other.length;
        char* newData = new char[newLength + 1];
        memcpy(newData, data, length);
        memcpy(newData + length, other.data, other.length + 1);
        delete[] data;
        data = newData;
        length = newLength;
        return *this;
    }
    
    // Subscript operator
    char& operator[](size_t index) {
        if (index >= length) throw std::out_of_range("Index out of bounds");
        return data[index];
    }
    
    // Const subscript operator
    const char& operator[](size_t index) const {
        if (index >= length) throw std::out_of_range("Index out of bounds");
        return data[index];
    }
    
    // Equality comparison
    bool operator==(const MyString& other) const {
        if (length != other.length) return false;
        return memcmp(data, other.data, length) == 0;
    }
    
    // Get length
    size_t size() const { return length; }
    
    // C-string conversion
    const char* c_str() const { return data; }
    
    // Stream insertion
    friend std::ostream& operator<<(std::ostream& os, const MyString& str);
};

// Stream insertion operator implementation
std::ostream& operator<<(std::ostream& os, const MyString& str) {
    os << str.data;
    return os;
}
```

## Conclusion

Operator overloading is a powerful feature in C++ that, when used correctly, can make code more readable and intuitive. By following the principles and best practices outlined above, you can create classes that feel natural to use with familiar operator syntax while maintaining type safety and performance.

Remember that the goal of operator overloading is to simplify code and make it more expressive, not to obscure functionality or create unexpected behavior.
