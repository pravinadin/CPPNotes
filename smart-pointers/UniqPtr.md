Uniq pointer
[[CPP]]
video: https://youtu.be/DHu0tv2qTYo?si=K8ddduOJCFVx2I_g


Summary:
 * Raw Pointer Problems: The video starts by explaining the dangers of raw pointers, such as forgetting to deallocate memory, incorrect deletion (using delete vs. delete[]), and issues with shared ownership leading to dangling pointers and memory corruption.
 * Smart Pointers as Solution: Smart pointers are presented as a way to automate memory deallocation and manage ownership, thus reducing memory leaks and pointer errors.
 * Unique Pointers - Exclusive Ownership: The video focuses on std::unique_ptr, highlighting its key features:
   * No Sharing: Unique pointers ensure exclusive ownership, preventing multiple pointers from managing the same memory.
   * Automatic Deallocation (RAII): Memory is automatically deallocated when the unique_ptr goes out of scope, eliminating manual delete calls and preventing memory leaks.
   * Move Semantics: Ownership can be transferred using move semantics, but copying is not allowed.
   * Usage: The video demonstrates how to declare and initialize unique_ptr using new and the preferred make_unique function (for exception safety and simplified syntax).
Key Takeaway:
std::unique_ptr is a smart pointer that provides exclusive ownership and automatic memory management in C++, making code safer and more robust compared to using raw pointers. The video emphasizes its role in preventing memory leaks and simplifying resource management through RAII.