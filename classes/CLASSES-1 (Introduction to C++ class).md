[[CPP]]
# C++ Classes and Access Specifiers

Video: https://www.youtube.com/watch?v=GVMmSmyZ_IA&list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L&index=38

## 1. Class Definition

```cpp
class Student
{
private:
    std::string m_name; // private data member
public:
    Student();        // constructor
    ~Student();       // destructor
    void printName(); // member function
};
```

## 2. Constructor and Destructor Implementation

```cpp
Student::Student() { std::cout << "Constructor called!" << std::endl; }
Student::~Student() { std::cout << "Destructor called!" << std::endl; }
```

## 3. Member Function Implementation

```cpp
void Student::printName() { std::cout << "Name is: " << m_name << std::endl; }
```

## 4. Creating Instances

```cpp
int main()
{
    Student mike;                 // Creating an instance of Student
    mike.printName();             // Calling the member function
    Student *sue = new Student(); // Dynamically creating an instance
    delete sue;                   // Explicitly calling the destructor
}
```

## 5. Header Guards in Header File

```cpp
#ifndef STUDENT_HPP 
#define STUDENT_HPP 

// Class definition here ...

#endif
```

## Understanding Access Specifiers

Access specifiers in C++—namely `private`, `public`, and `protected`—play a crucial role in encapsulation, which is one of the core principles of object-oriented programming. Encapsulation involves bundling data (attributes) and methods (functions) that operate on the data into a single unit or class, while restricting direct access to some of the object's components.

### Key Concepts

1. **Data Hiding**: By marking class members as `private`, you prevent external code from accessing or modifying these members directly. This safeguards the integrity of the object's state. For example, if `m_name` is private, it cannot be altered unexpectedly from outside the class.

2. **Controlled Access**: Public methods (getters and setters) allow controlled interaction with private attributes. This means you can validate or modify data before it is set or retrieved, ensuring that the object remains in a valid state.

3. **Maintainability**: By using access specifiers, the internal representation of a class can be changed without affecting code that uses the class, as long as the public interface remains the same. This is crucial for long-term software maintenance.

4. **Inheritance**: The `protected` specifier allows derived classes to access the base class's members while keeping them inaccessible to outside code. This is particularly useful in inheritance hierarchies, allowing subclasses to build upon the base class functionality.

## Implementing Getter and Setter Methods

Here's how to implement getters and setters for the private attribute `m_name`:

```cpp
class Student
{
private:
    std::string m_name;
    // Private attribute
public:
    // Getter for m_name
    std::string getName() const
    {
        return m_name; // Returns the name
    }
    // Setter for m_name
    void setName(const std::string &name)
    {
        if (!name.empty())
        {                  // Validation: name should not be empty
            m_name = name; // Sets the name
        }
    }
};
```

### Understanding Getters and Setters

1. **Getter (`getName`)**
   - Returns the value of `m_name`
   - Marked as `const` since it doesn't modify class members
   - Signals to users that calling this method won't change the object's state

2. **Setter (`setName`)**
   - Takes a `std::string` as an argument
   - Sets `m_name` to this value after validation
   - Includes validation to ensure the name is not empty
   - Maintains control over how `m_name` can be modified

Access specifiers are vital for encapsulating class data and methods in C++, ensuring data integrity and promoting a clean interface for interacting with objects. Implementing getter and setter methods further enhances this encapsulation by allowing controlled access to private attributes.