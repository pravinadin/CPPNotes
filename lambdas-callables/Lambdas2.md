# C++ Lambdas Part 2: The Capture Clause

## Introduction

This document summarizes the key concepts from "C++ Lambdas Part 2 - 'The capture'" (Episode 102 of the Modern C++ series), focusing on the lambda capture clause and its various capabilities in C++.

## Lambda Basics Recap

A C++ lambda expression has the following syntax:

```cpp
[ capture-clause ] ( parameters ) -> return-type { body }
```

The capture clause, represented by the square brackets `[]`, is what makes lambdas particularly powerful as it allows them to access variables from the surrounding scope.

## The Capture Clause Explained

The capture clause determines which variables from the surrounding scope can be accessed within the lambda function body, and how they are accessed.

### Types of Captures

#### 1. Empty Capture `[]`

An empty capture means the lambda doesn't access any local variables from the surrounding scope.

```cpp
int main() {
    auto lambda = [] () { return 42; };
    std::cout << lambda() << std::endl; // Outputs: 42
}
```

#### 2. Capture by Value `[var]`

Variables captured by value are copied into the lambda.

```cpp
int main() {
    int x = 10;
    
    auto lambda = [x] () { return x * 2; };
    
    x = 20; // This doesn't affect the lambda's copy of x
    
    std::cout << lambda() << std::endl; // Outputs: 20 (10 * 2)
}
```

#### 3. Capture by Reference `[&var]`

Variables captured by reference allow the lambda to access and modify the original variable.

```cpp
int main() {
    int x = 10;
    
    auto lambda = [&x] () { x *= 2; };
    
    lambda();
    
    std::cout << x << std::endl; // Outputs: 20 (x was modified by the lambda)
}
```

#### 4. Capture All by Value `[=]`

Captures all variables mentioned in the lambda by value.

```cpp
int main() {
    int x = 10;
    int y = 20;
    
    auto lambda = [=] () { return x + y; };
    
    x = 30; // Doesn't affect the lambda
    y = 40; // Doesn't affect the lambda
    
    std::cout << lambda() << std::endl; // Outputs: 30 (10 + 20)
}
```

#### 5. Capture All by Reference `[&]`

Captures all variables mentioned in the lambda by reference.

```cpp
int main() {
    int x = 10;
    int y = 20;
    
    auto lambda = [&] () { x *= 2; y *= 3; };
    
    lambda();
    
    std::cout << x << " " << y << std::endl; // Outputs: 20 40
}
```

#### 6. Mixed Captures

You can mix value and reference captures for different variables.

```cpp
int main() {
    int x = 10;
    int y = 20;
    
    auto lambda = [x, &y] () { y = x * 2; };
    
    lambda();
    
    std::cout << x << " " << y << std::endl; // Outputs: 10 20
}
```

#### 7. Default Capture with Exceptions

You can set a default capture mode and specify exceptions.

```cpp
int main() {
    int x = 10;
    int y = 20;
    int z = 30;
    
    // Capture everything by value except y which is by reference
    auto lambda = [=, &y] () { y = x + z; };
    
    lambda();
    
    std::cout << y << std::endl; // Outputs: 40
}
```

```cpp
int main() {
    int x = 10;
    int y = 20;
    int z = 30;
    
    // Capture everything by reference except x which is by value
    auto lambda = [&, x] () { y = x + z; z *= 2; };
    
    lambda();
    
    std::cout << x << " " << y << " " << z << std::endl; // Outputs: 10 40 60
}
```

## Mutable Lambdas

By default, a lambda's function call operator is `const`, meaning it cannot modify captured variables (even if they're captured by value). The `mutable` keyword allows modifying captured-by-value variables within the lambda.

```cpp
int main() {
    int x = 10;
    
    // Without mutable, this would cause a compilation error
    auto lambda = [x] () mutable { x += 5; return x; };
    
    std::cout << lambda() << std::endl; // Outputs: 15
    std::cout << lambda() << std::endl; // Outputs: 20 (the lambda's internal copy keeps changing)
    std::cout << x << std::endl;        // Outputs: 10 (original x is unchanged)
}
```

## Capture Initialization

C++14 introduced init capture (or "generalized lambda capture"), allowing you to initialize variables in the capture clause.

```cpp
int main() {
    int x = 10;
    
    // Create a new variable y in the lambda that's initialized with x + 5
    auto lambda = [y = x + 5] () { return y; };
    
    std::cout << lambda() << std::endl; // Outputs: 15
}
```

This is particularly useful for moving non-copyable objects into a lambda:

```cpp
int main() {
    std::unique_ptr<int> ptr = std::make_unique<int>(10);
    
    // Move the unique_ptr into the lambda
    auto lambda = [ptr = std::move(ptr)] () { return *ptr; };
    
    // ptr is now nullptr
    std::cout << lambda() << std::endl; // Outputs: 10
}
```

## Lifetime Considerations

One crucial aspect of lambda captures is understanding the lifetime of captured references:

```cpp
// Dangerous example - returning a lambda that captures a local variable by reference
auto createLambda() {
    int local = 42;
    return [&local] { return local; }; // DANGEROUS! local will be destroyed
}

int main() {
    auto lambda = createLambda();
    std::cout << lambda() << std::endl; // Undefined behavior - accessing destroyed variable
}
```

## Capturing `this` Pointer

When working with lambdas inside a class, you can capture the `this` pointer to access class members:

```cpp
class Example {
private:
    int value = 42;

public:
    void doSomething() {
        // Captures this pointer, allowing access to class members
        auto lambda = [this] () { return value; };
        
        std::cout << lambda() << std::endl; // Outputs: 42
    }
};
```

In C++17, you can use `[*this]` to capture a copy of the current object rather than a pointer to it.

## Performance Considerations

1. **Capture by Value**: Creates copies which can be expensive for large objects but ensures safety.
2. **Capture by Reference**: More efficient but requires careful lifetime management.
3. **Default Captures**: Convenient but may accidentally capture too many variables or pointers.

## Best Practices

1. **Be explicit**: Prefer explicitly listing captured variables over default captures.
2. **Minimize captures**: Only capture what you need to reduce lambda object size.
3. **Be careful with references**: Ensure captured references outlive the lambda.
4. **Use init captures**: For moving objects or creating lambda-local variables.
5. **Consider `mutable` carefully**: Only use when you need to modify captured values.

## Conclusion

The capture clause is what makes C++ lambdas truly powerful, allowing them to be both self-contained and context-aware. Understanding the different capture mechanisms enables writing more effective, efficient, and safe lambda expressions in modern C++ code.
