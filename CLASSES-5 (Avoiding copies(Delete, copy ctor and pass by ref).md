[[CPP]]
https://www.youtube.com/watch?v=MGzV5_1lEM8&list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L&index=41

- **Copy Constructors & Assignment**: Demonstrates copy constructors and assignment operators using an `Array` class.
- **When Copies Happen**: Shows when copy constructors are automatically called, like when creating objects from other objects or passing objects by value to functions.
- **Performance Issues**: Highlights the performance cost of copying large objects, especially in loops.
- **Pass by Reference**: Recommends using `const &` (pass by constant reference) to avoid copies when functions don't need to change objects, improving speed.
- **Disabling Copying**: Explains how to delete or disable copy constructors to prevent accidental or inefficient copying in specific situations.
- **Best Practices**: Stresses the importance of understanding when copies occur and using pass-by-reference for optimization in C++.