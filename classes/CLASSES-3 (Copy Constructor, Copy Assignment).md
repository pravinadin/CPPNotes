[[CPP]]
https://www.youtube.com/watch?v=EBgBM7rPDic&list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L&index=39

- **Introduction to Copy Control and the Need for Copying:**
    
    - The video likely starts by explaining that copying objects is a fundamental operation in C++. It happens in various situations like:
        - **Initialization by Copy:** Creating a new object as a copy of an existing one (`MyClass obj2 = obj1;` or `MyClass obj2(obj1);`.
        - **Passing Objects by Value to Functions:** When you pass an object as an argument to a function _by value_, a copy of the object is made for the function parameter.
        - **Returning Objects by Value from Functions:** When a function returns an object _by value_, a copy is often created to be returned to the caller.
    - The key issue is _how_ this copying is performed, especially when classes manage resources.
- **Shallow Copy:**
    
    - **Definition:** Shallow copy is the default copying behavior in C++ if you don't explicitly define a copy constructor or copy assignment operator. It's also what the compiler-generated default copy constructor and copy assignment operator do.
    - **Mechanism:** A shallow copy performs a **bitwise copy** of all member variables from the source object to the destination object. This means:
        - For value-type members (like `int`, `float`, `char`), the _values_ are copied directly.
        - For **pointer members**, the _pointer values_ (memory addresses) are copied. **Crucially, the data pointed to is _not_ copied.** Both the original and the copied object end up pointing to the _same memory location_.
    - **Example (Illustrative - likely similar to video content):**
    
    C++
    
    ```cpp
    #include <iostream>
    
    class MyClass {
    public:
        int* data; // Pointer to dynamically allocated integer
    
        MyClass(int value) {
            data = new int(value); // Allocate memory in constructor
            std::cout << "Constructor: Allocated memory for data at " << data << std::endl;
        }
    
        ~MyClass() {
            std::cout << "Destructor: Deallocating memory at " << data << std::endl;
            delete data;
        }
    
        void printData() const {
            std::cout << "Data value: " << *data << ", Memory address: " << data << std::endl;
        }
    };
    
    int main() {
        MyClass obj1(10);
        std::cout << "obj1: "; obj1.printData();
    
        MyClass obj2 = obj1; // Shallow copy using default copy constructor
    
        std::cout << "obj2 (after shallow copy from obj1): "; obj2.printData();
    
        std::cout << "Modifying data through obj2..." << std::endl;
        *obj2.data = 20;
    
        std::cout << "obj1 (after modifying obj2's data): "; obj1.printData(); // obj1's data also changed!
        std::cout << "obj2 (after modification): "; obj2.printData();
    
        // Problem: Destructor will be called for obj2 first, deleting the memory.
        // Then destructor for obj1 will be called, trying to delete already freed memory!
        return 0; // Likely leads to double-free error or undefined behavior when destructors are called.
    }
    ```
    
    - **Problems with Shallow Copy (as highlighted by the video):**
        - **Shared Resources:** Both objects end up sharing the same dynamically allocated memory. Changes made through one object affect the other. This violates encapsulation and can lead to unexpected behavior.
        - **Double Free Error:** When objects go out of scope and their destructors are called, the destructor of `obj2` will `delete data`. Then, when the destructor of `obj1` is called, it will try to `delete` the _same_ memory again, which is already freed. This is a "double-free" error, leading to crashes or memory corruption.
        - **Dangling Pointers:** If one object deallocates the shared memory, the pointer in the other object becomes a dangling pointer, pointing to invalid memory.
- **Deep Copy:**
    
    - **Definition:** Deep copy involves creating a completely **independent copy** of the object, including any dynamically allocated resources it manages. For pointer members, instead of just copying the pointer, deep copy allocates new memory and copies the _content_ of the data pointed to.
    - **Implementation:** To achieve deep copy, you need to define your own:
        - **Copy Constructor:** `MyClass(const MyClass& other)` - to handle initialization by copy.
        - **Copy Assignment Operator:** `MyClass& operator=(const MyClass& other)` - to handle assignment between existing objects.
    - **Example of Deep Copy Implementation (within `MyClass`):**
    
    ```cpp
    class MyClass {
    public:
        int* data; // Pointer to dynamically allocated integer
    
        MyClass(int value) { // Constructor
            data = new int(value);
            std::cout << "Constructor: Allocated memory for data at " << data << std::endl;
        }
    
        // Copy Constructor (Deep Copy)
        MyClass(const MyClass& other) {
            data = new int(*other.data); // Allocate *new* memory and copy the *value*
            std::cout << "Copy Constructor: Deep copy, new memory at " << data << " from " << other.data << std::endl;
        }
    
        // Copy Assignment Operator (Deep Copy)
        MyClass& operator=(const MyClass& other) {
            std::cout << "Copy Assignment Operator: Deep copy, assigning from " << other.data << " to " << data << std::endl;
            if (this != &other) { // Self-assignment check (important!)
                delete data;      // Deallocate existing memory (if any)
                data = new int(*other.data); // Allocate new and copy
            }
            return *this; // Return *this for chaining
        }
    
        ~MyClass() { // Destructor (same as before - needed for resource cleanup)
            std::cout << "Destructor: Deallocating memory at " << data << std::endl;
            delete data;
        }
    
        void printData() const {
            std::cout << "Data value: " << *data << ", Memory address: " << data << std::endl;
        }
    };
    ```
    
    - **Deep Copy Behavior (with the corrected code):** With the deep copy implementations, when you copy `obj1` to `obj2`, `obj2` gets its _own_ independent memory allocation, and the _value_ is copied. Modifying `obj2.data` will _not_ affect `obj1.data`. Destructors will then correctly deallocate separate memory blocks, avoiding errors.
- **Copy Constructor Signature and Usage:**
    
    - **Signature:** `ClassName(const ClassName& other);` - Takes a constant reference to an object of the same class as input. The `const` ensures you don't accidentally modify the source object during copying, and `&` avoids unnecessary copying of the source object itself.
    - **Usage:** Called implicitly during initialization by copy: `MyClass obj2 = obj1;` or `MyClass obj3(obj1);`
- **Copy Assignment Operator Signature and Usage:**
    
    - **Signature:** `ClassName& operator=(const ClassName& other);` - Takes a constant reference to an object of the same class as input and returns a reference to the _current_ object (`ClassName&`). ==Returning a reference allows for chained assignments like `a = b = c;`==.
    - **Self-Assignment Check (`if (this != &other)`):** ==Crucial inside the copy assignment operator to prevent problems if you accidentally do `obj = obj;`==. Without this check, you might deallocate your own object's resources before copying from yourself, leading to disaster.
    - **Deallocate Existing Resources in Assignment:** In the assignment operator, before copying data, you need to deallocate any resources that the _left-hand side_ object (`*this`) might already be managing. This prevents memory leaks if the object is being assigned to after it has already been used and allocated memory.
    - **Usage:** Called during assignment between existing objects: `obj2 = obj1;`
- **When to Implement Deep Copy:**
    
    - **Resource Management is Key:** You need to implement deep copy (by defining custom copy constructor and copy assignment operator) if your class manages resources that need to be independently copied. The most common resource is dynamically allocated memory.
    - **When Shallow Copy is Sufficient (and maybe Preferable - Modern C++ Perspective):** If your class _only_ contains value-type members or members that are themselves resource-managing classes (like `std::string`, `std::vector`, smart pointers), then often, the default shallow copy behavior is sufficient and correct. In modern C++, the trend is to design classes that lean towards shallow copy being safe by using RAII (Resource Acquisition Is Initialization) and standard library resource managers.
- **Modern C++ Perspective and Rule of Zero/Five (likely highlighted in a "Modern Cpp Series"):**
    
    - **Rule of Zero:** The video is likely to reinforce the modern C++ principle of the "Rule of Zero." This rule states that if your class does not directly manage any resources, you probably don't need to define any of the special member functions (destructor, copy constructor, copy assignment, move constructor, move assignment). The compiler-generated defaults will often work correctly.
    - **Rule of Five (if you violate Rule of Zero):** If you _do_ need to manage resources directly (and thus can't follow Rule of Zero completely), then you likely need to carefully consider and implement _all five_ special member functions (destructor, copy constructor, copy assignment, move constructor, move assignment) to handle resource management and copying correctly and efficiently. However, the strong preference in modern C++ is to try to adhere to Rule of Zero as much as possible by using standard library facilities.