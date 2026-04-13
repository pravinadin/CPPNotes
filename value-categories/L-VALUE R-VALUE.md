[[CPP]]

1. **Basic Variable Assignment**:
    ```cpp
    int i = 10;
    ```
    In this example, `i` is an L value because it is a variable with a memory location. The `10` is an R value since it is a temporary value without a memory address.
    
2. **Invalid Assignment**:
    ```cpp
    10 = i; // Error: L value required as left operand of the assignment
    ```
    This code attempts to assign the value of `i` to the literal `10`, which results in a compilation error because `10` is an R value and cannot appear on the left-hand side of an assignment.
    
3. **Expression Evaluation**:
    
    ```cpp
    int a = 1, b = 2; int c = a + b; // Here, a, b, and c are L values; (a + b) is an R value
    ```
    In this snippet, `a`, `b`, and `c` can all store values in memory (L values), while the expression `a + b` evaluates to a temporary value (R value) that can be assigned to `c`.
    
4. **Function Returning a Constant**:
    
    ```cpp
    int get42() { return 42; }
    ```
    Trying to execute the line `42 = 100;` results in an error because `42` is an R value.
    
5. **L Value Reference**:
    
    ```cpp
    int &ref = i; // ref is an L value reference to i
    ```
    Here, `ref` is an L value reference that refers to the existing variable `i`. This means any changes to `ref` will affect `i`.
    
6. **Invalid L Value Reference to R Value**:
    
    ```cpp
    int &ref2 = 10; // Error: cannot bind non-const L value reference to an R value
    ```
    This line fails because `10` is an R value and cannot be bound to a non-const L value reference.
    
7. **Const L Value Reference**:
    
    ```cpp
    const int &constRef = 10; // This is valid since const references can bind to R values
    ```
    In this case, `constRef` is a const L value reference that can bind to the R value `10`, allowing it to exist temporarily.
    
8. **R Value Reference**:
    
    ```cpp
    int &&rRef = 10; // rRef is an R value reference to the temporary value 10
    ```
    This example shows how to create an R value reference. The double ampersand (`&&`) indicates that `rRef` can bind to temporary R values.
    
9. **Using R Value References in Functions**:
    
    ```cpp
    void setValue(int &value) { value = 99; // Can modify L values }
    ```
    This function modifies a passed L value but would fail if called with an R value, as shown in the document.