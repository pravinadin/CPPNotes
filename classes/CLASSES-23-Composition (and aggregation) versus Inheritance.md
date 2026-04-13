# Composition vs Inheritance in C++ - Summary

## Introduction

This document summarizes the key concepts from "Classes part 23 - Composition (and aggregation) versus Inheritance in C++ | Modern Cpp Series Ep. 60". The video discusses two fundamental object-oriented programming concepts in C++: inheritance and composition, and how to choose between them in different scenarios.

## Inheritance vs Composition: Key Concepts

### Inheritance

Inheritance represents an "is-a" relationship between classes:
- A derived class is a specialized version of a base class
- The derived class inherits attributes and behaviors from the base class
- Enables code reuse and polymorphism

```cpp
// Base class
class Vehicle {
protected:
    int numWheels;
    double maxSpeed;
    
public:
    Vehicle(int wheels, double speed) : numWheels(wheels), maxSpeed(speed) {}
    
    void accelerate() {
        std::cout << "Vehicle accelerating...\n";
    }
    
    void brake() {
        std::cout << "Vehicle braking...\n";
    }
    
    virtual void displayInfo() const {
        std::cout << "Wheels: " << numWheels << ", Max Speed: " << maxSpeed << " mph\n";
    }
};

// Derived class - "Car is-a Vehicle"
class Car : public Vehicle {
private:
    std::string model;
    
public:
    Car(std::string carModel, double speed) 
        : Vehicle(4, speed), model(carModel) {}
    
    void displayInfo() const override {
        std::cout << "Car Model: " << model << "\n";
        Vehicle::displayInfo();
    }
};
```

### Composition

Composition represents a "has-a" relationship between classes:
- One class contains objects of other classes as members
- The contained objects are integral parts of the containing class
- The lifetime of the contained objects is typically managed by the containing class

```cpp
// Component class
class Engine {
private:
    double horsepower;
    int cylinders;
    
public:
    Engine(double hp, int cyl) : horsepower(hp), cylinders(cyl) {}
    
    void start() {
        std::cout << "Engine starting...\n";
    }
    
    void stop() {
        std::cout << "Engine stopping...\n";
    }
    
    void displaySpecs() const {
        std::cout << "Engine: " << cylinders << " cylinders, " 
                  << horsepower << " hp\n";
    }
};

// Container class - "Car has-an Engine"
class Car {
private:
    std::string model;
    Engine engine;  // Composition relationship
    
public:
    Car(std::string carModel, double hp, int cyl) 
        : model(carModel), engine(hp, cyl) {}
    
    void start() {
        std::cout << "Car starting...\n";
        engine.start();
    }
    
    void stop() {
        engine.stop();
        std::cout << "Car stopped.\n";
    }
    
    void displayInfo() const {
        std::cout << "Car Model: " << model << "\n";
        engine.displaySpecs();
    }
};
```

### Aggregation

Aggregation is a special form of composition:
- Represents a "has-a" relationship, but with looser coupling
- The contained object can exist independently of the container
- The contained object's lifetime is not controlled by the container

```cpp
// Separate class that can exist independently
class Driver {
private:
    std::string name;
    int licenseNumber;
    
public:
    Driver(std::string driverName, int license) 
        : name(driverName), licenseNumber(license) {}
    
    std::string getName() const { return name; }
    
    void displayInfo() const {
        std::cout << "Driver: " << name << ", License: " << licenseNumber << "\n";
    }
};

// Container class with aggregation relationship
class Car {
private:
    std::string model;
    Engine engine;          // Composition relationship
    Driver* driver;         // Aggregation relationship
    
public:
    Car(std::string carModel, double hp, int cyl) 
        : model(carModel), engine(hp, cyl), driver(nullptr) {}
    
    // Set driver for this car (aggregation)
    void setDriver(Driver* d) {
        driver = d;
    }
    
    void start() {
        if (driver) {
            std::cout << driver->getName() << " is starting the car...\n";
            engine.start();
        } else {
            std::cout << "Car cannot start without a driver!\n";
        }
    }
    
    void displayInfo() const {
        std::cout << "Car Model: " << model << "\n";
        engine.displaySpecs();
        
        if (driver) {
            driver->displayInfo();
        } else {
            std::cout << "No driver assigned.\n";
        }
    }
};
```

## When to Use Inheritance vs Composition

### Use Inheritance When:

1. There is a clear "is-a" relationship between classes
2. You want to reuse code from a base class
3. You need to use polymorphism (treating derived class objects as base class objects)
4. The derived class is truly a specialization of the base class

```cpp
// Example of appropriate inheritance
class Shape {
protected:
    double x, y;  // Position coordinates
    
public:
    Shape(double posX, double posY) : x(posX), y(posY) {}
    
    void move(double deltaX, double deltaY) {
        x += deltaX;
        y += deltaY;
    }
    
    virtual double area() const = 0;  // Pure virtual function
    
    virtual void draw() const = 0;    // Pure virtual function
};

class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(double posX, double posY, double r) 
        : Shape(posX, posY), radius(r) {}
    
    double area() const override {
        return 3.14159 * radius * radius;
    }
    
    void draw() const override {
        std::cout << "Drawing Circle at (" << x << ", " << y << ") with radius " << radius << "\n";
    }
};

class Rectangle : public Shape {
private:
    double width, height;
    
public:
    Rectangle(double posX, double posY, double w, double h) 
        : Shape(posX, posY), width(w), height(h) {}
    
    double area() const override {
        return width * height;
    }
    
    void draw() const override {
        std::cout << "Drawing Rectangle at (" << x << ", " << y 
                  << ") with width " << width << " and height " << height << "\n";
    }
};
```

### Use Composition When:

1. There is a "has-a" relationship between classes
2. You want to reuse implementation without exposing the interface of the contained class
3. You need more flexibility than inheritance provides
4. You want to avoid the problems of inheritance (e.g., tight coupling, fragile base class problem)

```cpp
// Example of appropriate composition
class Address {
private:
    std::string street;
    std::string city;
    std::string state;
    std::string zipCode;
    
public:
    Address(std::string st, std::string c, std::string s, std::string z)
        : street(st), city(c), state(s), zipCode(z) {}
    
    std::string getFullAddress() const {
        return street + "\n" + city + ", " + state + " " + zipCode;
    }
};

class Person {
private:
    std::string name;
    Address homeAddress;  // Composition
    
public:
    Person(std::string n, std::string st, std::string c, std::string s, std::string z)
        : name(n), homeAddress(st, c, s, z) {}
    
    void displayInfo() const {
        std::cout << "Name: " << name << "\nAddress:\n" << homeAddress.getFullAddress() << "\n";
    }
};
```

## Best Practices and Design Principles

1. **Favor Composition Over Inheritance**
   - The "Composition Over Inheritance" principle suggests that composition is often more flexible and less problematic than inheritance
   - Composition allows for more decoupled code and easier maintenance

2. **Use the Liskov Substitution Principle (LSP)**
   - If using inheritance, ensure that derived classes can be substituted for their base classes without altering the correctness of the program

3. **Consider the Open/Closed Principle**
   - Classes should be open for extension but closed for modification
   - Composition often makes it easier to adhere to this principle

```cpp
// Bad design using inheritance
class Database {
public:
    virtual void connect() { /* Generic connection code */ }
    virtual void query(std::string sql) { /* Generic query code */ }
    // ...
};

class MySQLDatabase : public Database {
public:
    void connect() override { /* MySQL-specific connection code */ }
    void query(std::string sql) override { /* MySQL-specific query code */ }
    // ...
};

// Better design using composition
class DatabaseConnector {
public:
    virtual void connect() = 0;
    virtual void disconnect() = 0;
    virtual ~DatabaseConnector() {}
};

class QueryExecutor {
public:
    virtual void execute(std::string sql) = 0;
    virtual ~QueryExecutor() {}
};

class MySQLConnector : public DatabaseConnector {
public:
    void connect() override { /* MySQL connection code */ }
    void disconnect() override { /* MySQL disconnect code */ }
};

class MySQLQueryExecutor : public QueryExecutor {
public:
    void execute(std::string sql) override { /* MySQL query code */ }
};

class Database {
private:
    std::unique_ptr<DatabaseConnector> connector;
    std::unique_ptr<QueryExecutor> queryExecutor;
    
public:
    Database(std::unique_ptr<DatabaseConnector> conn, 
             std::unique_ptr<QueryExecutor> exec)
        : connector(std::move(conn)), queryExecutor(std::move(exec)) {}
    
    void connect() {
        connector->connect();
    }
    
    void disconnect() {
        connector->disconnect();
    }
    
    void query(std::string sql) {
        queryExecutor->execute(sql);
    }
};
```

## Common Pitfalls

1. **Fragile Base Class Problem**
   - Changes to the base class can unexpectedly break derived classes
   - Composition helps minimize this risk

2. **Deep Inheritance Hierarchies**
   - Deep inheritance hierarchies can be hard to understand and maintain
   - Composition allows for flatter class structures

3. **Diamond Problem in Multiple Inheritance**
   - C++ allows multiple inheritance, which can lead to the diamond problem
   - Composition avoids this issue entirely

## Conclusion

Both inheritance and composition are powerful tools in C++, but they serve different purposes:

- **Inheritance** is about specialization and classification hierarchies (is-a relationships)
- **Composition** is about building complex objects from simpler ones (has-a relationships)

In modern C++ development, composition is often preferred as it tends to create more flexible, maintainable code. However, inheritance remains valuable when used appropriately for true "is-a" relationships and when polymorphism is needed.

The best approach is often to use both techniques judiciously, applying each where it makes the most sense for your specific design problem.
