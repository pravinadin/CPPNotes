[[CPP]]
https://www.youtube.com/watch?v=EhinJ94emf8&list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L&index=38


- **Default Constructor:**
    
    - **What it is:** A constructor that takes no arguments. It's used to create objects of a class when no initial values are provided.
    - **When is it implicitly generated?** The compiler automatically generates a default constructor for your class if you **do not define any constructors at all** (neither parameterized constructors nor a default constructor).
    - **What does the default constructor do?**
        - It performs **default initialization** of member variables.
        - For **built-in types** (like `int`, `float`, `pointers`), default initialization leaves them in an **uninitialized state** with indeterminate values. (Crucially, this point is often highlighted).
        - For **class type members**, it calls their default constructors (if they have them).
    
    C++
    
    ```cpp
    #include <iostream>
    #include <string>
    
    class MyClass {
    public:
        int number;        // Built-in type
        std::string text; // Class type (std::string has its own default constructor)
    
        // No constructors defined in MyClass - Compiler provides default constructor
    };
    
    int main() {
        MyClass obj1; // Default constructor of MyClass is implicitly called
    
        std::cout << "obj1.number: " << obj1.number << std::endl; // Could be garbage value!
        std::cout << "obj1.text: \"" << obj1.text << "\"" << std::endl;   // std::string default constructor called, likely empty string
    
        return 0;
    }
    ```
    
    - **Detail from Example:** In this example, `MyClass` has no constructors defined. Therefore, the compiler generates a default constructor. When `obj1` is created using `MyClass obj1;`, this default constructor is called. Notice that `obj1.number` is uninitialized and might contain any garbage value that was in that memory location previously. However, `obj1.text` (being a `std::string`) is initialized by the `std::string`'s default constructor, resulting in an empty string.
- **Default Destructor:**
    
    - **What it is:** A destructor that takes no arguments. It's called when an object of a class is destroyed (goes out of scope or is explicitly `delete`d if dynamically allocated).
    - **When is it implicitly generated?** The compiler automatically generates a default destructor for your class **in all cases**, even if you define your own constructors or other member functions.
    - **What does the default destructor do?**
        - It calls the destructors of its class-type member objects in reverse order of their construction.
        - For built-in types and pointers, it **does nothing** (no cleanup is performed on them by default destructor itself). This is crucial.
    - **Example (Illustrative, likely similar to video content):**
    
    C++
    
    ```cpp
    #include <iostream>
    
    class MyClassWithDestructor {
    public:
        MyClassWithDestructor() {
            std::cout << "MyClassWithDestructor Constructor called" << std::endl;
        }
        ~MyClassWithDestructor() {
            std::cout << "MyClassWithDestructor Destructor called" << std::endl;
        }
    };
    
    class ContainerClass {
    public:
        MyClassWithDestructor memberObject; // Member of class type
    
        // No constructors or destructors explicitly defined in ContainerClass
        // Compiler will provide default constructor and default destructor for ContainerClass
    };
    
    int main() {
        { // Start of scope
            ContainerClass containerObj; // Default constructor of ContainerClass called
    
            // When containerObj goes out of scope, default destructor of ContainerClass is called.
            // This default destructor will automatically call the destructor of memberObject.
        } // End of scope
    
        std::cout << "Scope ended" << std::endl;
        return 0;
    }
    ```
    
    - **Detail from Example:** `ContainerClass` does not have explicitly defined constructors or destructors. The compiler provides both defaults. When `containerObj` is created, the default constructor of `ContainerClass` is used (which does nothing special in this case, but if `ContainerClass` had members of other class types with constructors, those would be called). When `containerObj` goes out of scope at the end of the block `{}`, the **default destructor of `ContainerClass` is automatically called**. This default destructor then, in turn, automatically calls the destructor of its member `memberObject` (of type `MyClassWithDestructor`). You'll see the output from both destructors, demonstrating the automatic destructor calling chain.
- **When to define your own Constructors and Destructors (and when not to):**
    
    - **When to define Constructors:**
        - When you need to **initialize member variables with specific values** at object creation (using parameterized constructors).
        - When you need to perform **any setup operations** beyond default initialization upon object creation (e.g., opening files, allocating resources).
        - If you _define any constructor_ (parameterized or default), the compiler will **not** automatically generate the default constructor. If you _also_ need a default constructor, you must define it explicitly.
    - **When to define Destructors:**
        - **Resource Management is Key!** You **must** define a destructor if your class is responsible for managing resources that need to be cleaned up (released, deallocated) when an object is destroyed. The most common scenario is when your class **owns dynamically allocated memory** (using `new`). In this case, you _must_ use `delete` or `delete[]` in the destructor to prevent memory leaks.
        - Examples of resources that often require custom destructors:
            - Dynamically allocated memory (using `new`, `new[]`)
            - Open files
            - Network connections
            - External resources held by the object.
    - **When you might NOT need to define them (Rule of Zero/Zero-Five):**
        - In **modern C++**, it's often recommended to follow the **Rule of Zero (or Rule of Five)**. This principle encourages you to avoid writing custom constructors, destructors, and copy/move operations if your class **does not directly manage resources**.
        - Instead, utilize **resource-owning classes from the standard library** (like `std::string`, `std::vector`, smart pointers like `std::unique_ptr`, `std::shared_ptr`). These standard library classes handle resource management correctly for you. If you use these resource-managing classes as members in your own classes, their destructors will automatically take care of cleanup, often making custom destructors (and related special members) in your classes unnecessary.