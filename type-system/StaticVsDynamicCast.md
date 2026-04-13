# C++ Casting: static_cast vs dynamic_cast

## Introduction
This document summarizes the key differences between `static_cast` and `dynamic_cast` in C++, a common interview question for C++ developers. These casting operators serve different purposes and have distinct behaviors, particularly when working with class hierarchies and polymorphism.

## Key Differences

| Feature | `static_cast` | `dynamic_cast` |
|---------|--------------|----------------|
| Runtime Check | No runtime type checking | Performs runtime type checking |
| RTTI Requirement | Does not require RTTI | Requires RTTI (Run-Time Type Information) |
| Performance | Faster (compile-time resolution) | Slower (runtime verification) |
| Safety | Less safe, no runtime verification | Safer, verifies cast validity at runtime |
| Failed Cast Behavior | Undefined behavior for invalid downcasts | Returns `nullptr` for pointer types or throws `std::bad_cast` for references |
| Usage Scope | General-purpose casting | Primarily for polymorphic class hierarchies |

## static_cast

`static_cast` performs conversions that are checked at compile time with no runtime overhead. It's the "trust me, I know what I'm doing" approach to casting.

### Use Cases:
- Numeric type conversions (int to float, etc.)
- Upcasting (derived class pointer to base class pointer)
- Downcasting (base class pointer to derived class pointer, but without runtime checks)
- Converting void* back to typed pointers

### Code Example:

```cpp
#include <iostream>

class Base {
public:
    virtual void print() { std::cout << "Base class" << std::endl; }
    virtual ~Base() {}
};

class Derived : public Base {
public:
    void print() override { std::cout << "Derived class" << std::endl; }
    void derivedMethod() { std::cout << "Method only in Derived" << std::endl; }
};

int main() {
    // Numeric conversion
    int i = 10;
    float f = static_cast<float>(i);
    std::cout << "Integer " << i << " converted to float: " << f << std::endl;
    
    // Upcast (always safe)
    Derived* derived = new Derived();
    Base* base = static_cast<Base*>(derived);  // Upcast is always safe
    base->print();  // Will call Derived::print() due to virtual function
    
    // Downcast (potentially unsafe)
    Base* basePtr = new Derived();  // Points to a Derived object
    Derived* derivedPtr = static_cast<Derived*>(basePtr);  // Works as expected
    derivedPtr->derivedMethod();  // Safe because basePtr actually points to a Derived
    
    // DANGER: Incorrect downcast
    Base* baseOnly = new Base();  // Points to a Base object
    Derived* wrongDerived = static_cast<Derived*>(baseOnly);  // Compiles but is incorrect
    // wrongDerived->derivedMethod();  // Undefined behavior! Could crash
    
    // Clean up
    delete derived;
    delete basePtr;
    delete baseOnly;
    
    return 0;
}
```

## dynamic_cast

`dynamic_cast` performs runtime checking to ensure the validity of the cast. It's the "let me check if this is valid first" approach to casting.

### Use Cases:
- Safe downcasting in polymorphic class hierarchies
- Determining the actual type of an object at runtime
- Implementation of runtime type checking and type-safe operations

### Requirements:
- Base class must have at least one virtual function (to enable RTTI)
- RTTI must be enabled (it is by default in most compilers)

### Code Example:

```cpp
#include <iostream>
#include <typeinfo>

class Base {
public:
    virtual void print() { std::cout << "Base class" << std::endl; }
    virtual ~Base() {}  // Virtual destructor is important!
};

class Derived1 : public Base {
public:
    void print() override { std::cout << "Derived1 class" << std::endl; }
    void derived1Method() { std::cout << "Method specific to Derived1" << std::endl; }
};

class Derived2 : public Base {
public:
    void print() override { std::cout << "Derived2 class" << std::endl; }
    void derived2Method() { std::cout << "Method specific to Derived2" << std::endl; }
};

void processObject(Base* obj) {
    // We don't know the exact type here, so we use dynamic_cast to check
    
    if (Derived1* d1 = dynamic_cast<Derived1*>(obj)) {
        std::cout << "This is a Derived1 object" << std::endl;
        d1->derived1Method();
    }
    else if (Derived2* d2 = dynamic_cast<Derived2*>(obj)) {
        std::cout << "This is a Derived2 object" << std::endl;
        d2->derived2Method();
    }
    else {
        std::cout << "This is a Base object or some other derived class" << std::endl;
    }
    
    // Using typeid to get the actual type
    std::cout << "The actual type is: " << typeid(*obj).name() << std::endl;
}

int main() {
    Base* base = new Base();
    Base* derived1 = new Derived1();
    Base* derived2 = new Derived2();
    
    std::cout << "Processing Base object:" << std::endl;
    processObject(base);
    std::cout << "\nProcessing Derived1 object:" << std::endl;
    processObject(derived1);
    std::cout << "\nProcessing Derived2 object:" << std::endl;
    processObject(derived2);
    
    // Example with references and exception handling
    try {
        Base baseObj;
        Derived1 derived1Obj;
        Base& baseRef = baseObj;
        
        // This will throw std::bad_cast because baseRef actually refers to a Base object
        Derived1& derived1Ref = dynamic_cast<Derived1&>(baseRef);
        
        // This line won't execute due to the exception
        std::cout << "Cast successful" << std::endl;
    }
    catch (const std::bad_cast& e) {
        std::cout << "Exception caught: " << e.what() << std::endl;
        std::cout << "dynamic_cast failed for reference cast" << std::endl;
    }
    
    // Clean up
    delete base;
    delete derived1;
    delete derived2;
    
    return 0;
}
```

## When to Use Each Cast

### Use `static_cast` when:
- You're doing numeric type conversions
- You're doing upcasts in a class hierarchy
- You're certain about the object type (you know better than the compiler)
- Performance is critical and you can guarantee the correctness
- You're working with non-polymorphic types

### Use `dynamic_cast` when:
- You need to safely downcast in a polymorphic hierarchy
- You need to determine object type at runtime
- You need to verify the type before performing type-specific operations
- Safety is more important than performance
- You're working with objects whose exact type is unknown at compile time

## Compilation Flags

To use `dynamic_cast`, RTTI must be enabled (usually the default). If you're compiling with GCC or Clang, make sure you're not using the flag `-fno-rtti` which disables RTTI.

## Common Interview Questions

1. **What's the main difference between static_cast and dynamic_cast?**
   - `static_cast` performs compile-time checking, while `dynamic_cast` performs runtime checking of the actual object type.

2. **When would you choose dynamic_cast over static_cast?**
   - When working with polymorphic types and you need to safely downcast or determine the actual type at runtime.

3. **What happens if dynamic_cast fails?**
   - For pointers, it returns `nullptr`; for references, it throws a `std::bad_cast` exception.

4. **Can you use dynamic_cast with non-polymorphic classes?**
   - No, the base class must have at least one virtual function.

5. **Which cast is more efficient and why?**
   - `static_cast` is more efficient as it has no runtime overhead, but it's also less safe.

## Conclusion

Understanding the differences between `static_cast` and `dynamic_cast` is crucial for writing safe and efficient C++ code. While `static_cast` offers better performance, `dynamic_cast` provides safer type conversions when working with polymorphic types. Your choice should depend on the specific requirements of your application, balancing safety with performance considerations.
