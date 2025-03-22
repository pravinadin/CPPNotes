# std::shared_ptr in Modern C++

## Introduction

`std::shared_ptr` is a smart pointer that manages memory through reference counting. It's part of the C++11 standard library and provides automatic memory management for dynamically allocated objects. This guide summarizes how `std::shared_ptr` works and provides practical code examples.

## Key Concepts

- **Reference Counting**: `std::shared_ptr` maintains a count of how many shared pointers point to the same object
- **Automatic Cleanup**: When the reference count reaches zero, the managed object is automatically deleted
- **Thread Safety**: The reference count is incremented and decremented in a thread-safe manner
- **Custom Deleters**: Support for custom deletion logic

## Basic Usage

```cpp
#include <iostream>
#include <memory>

int main() {
    // Create a shared_ptr managing an int
    std::shared_ptr<int> ptr1 = std::make_shared<int>(42);
    
    std::cout << "Value: " << *ptr1 << std::endl;          // Access value: 42
    std::cout << "Use count: " << ptr1.use_count() << std::endl;  // Count: 1
    
    // Create another shared_ptr pointing to the same object
    std::shared_ptr<int> ptr2 = ptr1;
    
    std::cout << "Use count: " << ptr1.use_count() << std::endl;  // Count: 2
    
    // Modify the value through either pointer
    *ptr2 = 100;
    std::cout << "New value via ptr1: " << *ptr1 << std::endl;  // 100
    
    // ptr1 and ptr2 will go out of scope and the memory will be automatically freed
    return 0;
}
```

## Creating shared_ptr

### Using make_shared (Recommended)

```cpp
// Preferred method: use make_shared
std::shared_ptr<int> ptr = std::make_shared<int>(42);
```

Benefits of using `std::make_shared`:
- More efficient (single allocation for both the object and control block)
- Exception safe
- Typically faster than separate allocation

### Using Constructor

```cpp
// Direct constructor approach (less efficient)
std::shared_ptr<int> ptr(new int(42));
```

### From Existing Raw Pointer (Use with Caution)

```cpp
int* rawPtr = new int(42);
std::shared_ptr<int> ptr1(rawPtr);

// DANGEROUS: This creates a second control block!
// std::shared_ptr<int> ptr2(rawPtr);  // Don't do this!
```

## Working with Classes

```cpp
#include <iostream>
#include <memory>
#include <string>

class Person {
private:
    std::string name;
    int age;

public:
    Person(std::string n, int a) : name(std::move(n)), age(a) {
        std::cout << "Person constructor called for " << name << std::endl;
    }
    
    ~Person() {
        std::cout << "Person destructor called for " << name << std::endl;
    }
    
    void introduce() const {
        std::cout << "Hi, I'm " << name << " and I'm " << age << " years old." << std::endl;
    }
};

int main() {
    // Create a shared_ptr to a Person
    std::shared_ptr<Person> person1 = std::make_shared<Person>("Alice", 30);
    person1->introduce();  // Use -> to access members
    
    // Share ownership
    {
        std::shared_ptr<Person> person2 = person1;
        std::cout << "Use count inside block: " << person1.use_count() << std::endl;  // 2
        
        // person2 goes out of scope here
    }
    
    std::cout << "Use count after block: " << person1.use_count() << std::endl;  // 1
    
    // When person1 goes out of scope, the Person object will be deleted
    return 0;
}
```

## Sharing Arrays

For arrays, it's better to use `std::shared_ptr` with a custom deleter or `std::vector` when possible:

```cpp
#include <iostream>
#include <memory>

int main() {
    // Managing an array with shared_ptr (requires custom deleter)
    std::shared_ptr<int[]> array = std::shared_ptr<int[]>(new int[10], 
                                                         std::default_delete<int[]>());
    
    // In C++17 and later, you can use this simpler syntax
    std::shared_ptr<int[]> modern_array = std::make_shared<int[]>(10);
    
    // Using the array
    for (int i = 0; i < 10; i++) {
        modern_array[i] = i * i;
    }
    
    // Print the contents
    for (int i = 0; i < 10; i++) {
        std::cout << modern_array[i] << " ";
    }
    std::cout << std::endl;
    
    return 0;
    // The arrays will be automatically deleted when the shared_ptrs go out of scope
}
```

## Custom Deleters

You can specify custom deletion logic:

```cpp
#include <iostream>
#include <memory>
#include <fstream>

void closeFile(std::FILE* fp) {
    if (fp) {
        std::fclose(fp);
        std::cout << "File closed via custom deleter" << std::endl;
    }
}

int main() {
    // Using a custom deleter with a lambda
    {
        std::shared_ptr<int> ptr(new int(42), [](int* p) {
            std::cout << "Custom deleting int with value: " << *p << std::endl;
            delete p;
        });
    }  // Custom deleter runs here
    
    // Using a custom deleter for file handling
    {
        std::FILE* fp = std::fopen("example.txt", "w");
        std::shared_ptr<std::FILE> filePtr(fp, closeFile);
        
        // Use the file...
        if (filePtr) {
            std::fprintf(filePtr.get(), "Hello, shared_ptr with custom deleter!");
        }
    }  // File is automatically closed when filePtr goes out of scope
    
    return 0;
}
```

## Circular References and weak_ptr

Circular references can cause memory leaks with `std::shared_ptr`. The solution is to use `std::weak_ptr`:

```cpp
#include <iostream>
#include <memory>
#include <string>

class Person;  // Forward declaration

class Car {
private:
    std::string model;
    std::weak_ptr<Person> owner;  // Weak pointer to avoid circular reference

public:
    Car(const std::string& m) : model(m) {
        std::cout << "Car " << model << " created" << std::endl;
    }
    
    ~Car() {
        std::cout << "Car " << model << " destroyed" << std::endl;
    }
    
    void setOwner(const std::shared_ptr<Person>& p) {
        owner = p;  // Store a weak reference
    }
    
    void printOwner() const;
};

class Person {
private:
    std::string name;
    std::shared_ptr<Car> car;  // Strong reference to Car

public:
    Person(const std::string& n) : name(n) {
        std::cout << "Person " << name << " created" << std::endl;
    }
    
    ~Person() {
        std::cout << "Person " << name << " destroyed" << std::endl;
    }
    
    void setCar(const std::shared_ptr<Car>& c) {
        car = c;
    }
    
    const std::string& getName() const {
        return name;
    }
};

void Car::printOwner() const {
    // Convert weak_ptr to shared_ptr to check if the Person still exists
    if (auto p = owner.lock()) {
        std::cout << model << " is owned by " << p->getName() << std::endl;
    } else {
        std::cout << model << " has no owner" << std::endl;
    }
}

int main() {
    // Create objects with circular references
    std::shared_ptr<Person> person = std::make_shared<Person>("Alice");
    std::shared_ptr<Car> car = std::make_shared<Car>("Tesla");
    
    // Establish relationships
    person->setCar(car);
    car->setOwner(person);
    
    car->printOwner();  // Tesla is owned by Alice
    
    // Without weak_ptr, these objects would never be destroyed due to circular references
    return 0;
}  // Both Person and Car objects are properly destroyed
```

## Best Practices

1. **Use `std::make_shared` when possible** for better performance and exception safety
2. **Avoid creating shared_ptr from raw pointers multiple times**
3. **Use weak_ptr to break circular references**
4. **Consider ownership semantics carefully** - use `std::unique_ptr` when you need exclusive ownership
5. **Watch out for performance implications** - shared_ptr has overhead due to reference counting
6. **Be careful with custom deleters** when needed
7. **Prefer standard containers** like `std::vector` over manual array management

## Common Mistakes to Avoid

```cpp
// MISTAKE 1: Creating multiple control blocks
int* raw = new int(42);
std::shared_ptr<int> p1(raw);
std::shared_ptr<int> p2(raw);  // ERROR: Double deletion will occur

// MISTAKE 2: Creating shared_ptr from this in constructors
class Widget {
    void createShared() {
        // BAD: Creates a new control block unrelated to any existing shared_ptr
        std::shared_ptr<Widget> self(this);  // Don't do this!
    }
};

// MISTAKE 3: Forgetting about the performance overhead
// For small, frequently created objects where shared ownership
// isn't needed, consider alternatives like unique_ptr
```

## Conclusion

`std::shared_ptr` is a powerful tool for managing shared ownership of resources in C++. When used correctly, it helps prevent memory leaks and resource management errors. However, it's important to understand its limitations and performance implications, and use it only when shared ownership is actually needed.
