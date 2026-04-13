# C++ Notes

Personal C++ study notes, originally maintained in [Obsidian](https://obsidian.md/). Covers classes and OOP, the STL container library, smart pointers, value categories, lambdas, type casting, and general language features — with code examples throughout.

---

## Table of Contents

### Classes & OOP

A 33-part series covering C++ classes from fundamentals through advanced patterns.

| # | Topic | File |
|---|-------|------|
| 1 | Introduction to C++ Classes | [CLASSES-1 (Introduction to C++ class).md](CLASSES-1%20(Introduction%20to%20C%2B%2B%20class).md) |
| 2 | Default Constructor & Destructor | [CLASSES-2 ( Default Constructor, default destructor).md](CLASSES-2%20(%20Default%20Constructor%2C%20default%20destructor).md) |
| 3 | Copy Constructor & Copy Assignment | [CLASSES-3 (Copy Constructor, Copy Assignment).md](CLASSES-3%20(Copy%20Constructor%2C%20Copy%20Assignment).md) |
| 4 | The Rule of Three | [CLASSES-4 ( The Rule of 3).md](CLASSES-4%20(%20The%20Rule%20of%203).md) |
| 5 | Avoiding Copies (delete, pass by ref) | [CLASSES-5 (Avoiding copies...).md](CLASSES-5%20(Avoiding%20copies(Delete%2C%20copy%20ctor%20and%20pass%20by%20ref).md) |
| 6 | Operator Overloading | [CLASSES-6-OperatorOverloading.md](CLASSES-6-OperatorOverloading.md) |
| 7 | Member Initializer Lists | [CLASSES-7-MemberInitializerLists.md](CLASSES-7-MemberInitializerLists.md) |
| 8 | Structs | [CLASSES-8-Structs.md](CLASSES-8-Structs.md) |
| 10 | Rule of Five & Reducing Allocations | [CLASSES-10-RuleofFive-ReduceMemAllocations.md](CLASSES-10-RuleofFive-ReduceMemAllocations.md) |
| 11 | Friend Functions | [CLASSES-11-FriendFunctions.md](CLASSES-11-FriendFunctions.md) |
| 12 | Explicit Constructors & List Initialization | [CLASSES-12-ExplicitCtorListInitialization.md](CLASSES-12-ExplicitCtorListInitialization.md) |
| 13 | Introduction to Inheritance | [CLASSES-13 - Introduction to Inheritance.md](CLASSES-13%20-%20Introduction%20to%20Inheritance.md) |
| 14 | Access Modifiers in Inheritance | [CLASSES-14.md](CLASSES-14.md) |
| 15 | Inheritance: Calling Different Constructors | [CLASSES-15-InheritanceCallingDifferentConstructors.md](CLASSES-15-InheritanceCallingDifferentConstructors.md) |
| 16 | Virtual Functions & Dynamic Dispatch | [CLASSES-16- Virtual Functions and Dynamic Dispatch.md](CLASSES-16-%20Virtual%20Functions%20and%20Dynamic%20Dispatch.md) |
| 17 | Virtual Destructors | [CLASSES-17-Virtual Destructors.md](CLASSES-17-Virtual%20Destructors.md) |
| 18 | vtable Internals | [CLASSES-18-vtable.md](CLASSES-18-vtable.md) |
| 19 | Interfaces (Pure Virtual) | [CLASSES-19-Interfaces.md](CLASSES-19-Interfaces.md) |
| 20 | Multiple Inheritance | [CLASSES-20-MultipleInhertence.md](CLASSES-20-MultipleInhertence.md) |
| 21 | Const Correctness | [CLASSES-21-ConstCorrectness.md](CLASSES-21-ConstCorrectness.md) |
| 22 | Curly Brace Initialization | [CLASSES-22-CurlyBraces.md](CLASSES-22-CurlyBraces.md) |
| 23 | Composition vs Inheritance | [CLASSES-23-Composition (and aggregation) versus Inheritance.md](CLASSES-23-Composition%20(and%20aggregation)%20versus%20Inheritance.md) |
| 24 | Multiple Inheritance Revisited | [CLASSES-24-Multiple Inheritance Revisited.md](CLASSES-24-Multiple%20Inheritance%20Revisited.md) |
| 26 | Value Initialization | [CLASSES-26-Value Initialization.md](CLASSES-26-Value%20Initialization.md) |
| 27 | In-Class Initializers | [CLASSES-27- In-Class Initializer.md](CLASSES-27-%20In-Class%20Initializer.md) |
| 28 | Delegating Constructors | [CLASSES-28- DelegatingConstructors.md](CLASSES-28-%20DelegatingConstructors.md) |
| 29 | Class Data Layout | [CLASSES-29-Class Data Layout.md](CLASSES-29-Class%20Data%20Layout.md) |
| 30 | pImpl Idiom | [CLASSES-30-pIMPL.md](CLASSES-30-pIMPL.md) |
| 32 | Static Members | [CLASSES-32-StaticMembers.md](CLASSES-32-StaticMembers.md) |
| 33 | Nested Classes | [CLASSES-33-NestedClasses.md](CLASSES-33-NestedClasses.md) |

> **Note:** Numbers 9, 25, and 31 are not yet present in this collection.

### STL Containers

| Topic | File |
|-------|------|
| **STL Cheatsheet** (operations grid, complexity table, full examples) | [STL-Cheatsheet.md](STL-Cheatsheet.md) |
| std::vector | [STD-vector.md](STD-vector.md) |
| std::list | [STD-list.md](STD-list.md) |
| std::forward_list | [STD-forwardlist.md](STD-forwardlist.md) |
| std::deque | [STD-deque.md](STD-deque.md) |
| std::array | [STD-array.md](STD-array.md) |
| std::string | [STD-string.md](STD-string.md) |
| std::string_view | [STD-string-view.md](STD-string-view.md) |
| std::span | [STD-span.md](STD-span.md) |
| std::pair | [STD-pair.md](STD-pair.md) |
| std::stack | [STD-stack.md](STD-stack.md) |
| std::queue | [STD-queue.md](STD-queue.md) |
| std::priority_queue | [STD-priority_queue.md](STD-priority_queue.md) |
| std::map | [STD-map.md](STD-map.md) |
| std::multimap | [STD-multimap.md](STD-multimap.md) |
| std::unordered_map | [STD-unordered_map.md](STD-unordered_map.md) |
| std::unordered_multimap | [STD-unordered_multimap.md](STD-unordered_multimap.md) |
| std::set | [STD-set.md](STD-set.md) |
| std::multiset | [STD-multiset.md](STD-multiset.md) |
| std::unordered_set | [STD-unorderedset.md](STD-unorderedset.md) |
| std::unordered_multiset | [STD-unordered_multiset.md](STD-unordered_multiset.md) |

### Smart Pointers

| Topic | File |
|-------|------|
| std::unique_ptr | [UniqPtr.md](UniqPtr.md) |
| std::shared_ptr | [sharedPtr.md](sharedPtr.md) |
| std::weak_ptr | [weakPtr.md](weakPtr.md) |

### Value Categories & Move Semantics

| Topic | File |
|-------|------|
| L-values and R-values (overview) | [L-VALUE R-VALUE.md](L-VALUE%20R-VALUE.md) |
| L-values and R-values (detailed) | [l-value-r-value-detail.md](l-value-r-value-detail.md) |
| std::move | [move.md](move.md) |

### Lambdas & Callables

| Topic | File |
|-------|------|
| Lambdas — Part 1 | [Lambdas1.md](Lambdas1.md) |
| Lambdas — Part 2 | [Lambdas2.md](Lambdas2.md) |
| Lambdas — Part 3 | [Lambdas3.md](Lambdas3.md) |
| Function Pointers | [FunctionPointers.md](FunctionPointers.md) |
| Functors | [Functors.md](Functors.md) |

### Type System & Casting

| Topic | File |
|-------|------|
| static_cast vs dynamic_cast | [StaticVsDynamicCast.md](StaticVsDynamicCast.md) |
| reinterpret_cast | [ReinterpretCast.md](ReinterpretCast.md) |
| std::variant | [variant.md](variant.md) |
| Unions | [unions.md](unions.md) |

### Language Fundamentals

| Topic | File |
|-------|------|
| Loops | [loops.md](loops.md) |
| References | [references.md](references.md) |
| Static keyword | [static.md](static.md) |
| Mutable keyword | [mutable.md](mutable.md) |
| The `this` pointer | [this.md](this.md) |
| `using` declarations | [using.md](using.md) |
| Array decay to pointer | [ArrayDecaytoPointer.md](ArrayDecaytoPointer.md) |

### Design & Idioms

| Topic | File |
|-------|------|
| API Design | [API-Design.md](API-Design.md) |
| RAII | [RAII.md](RAII.md) |

---

## Suggested Reading Order

If you're working through these notes linearly, a reasonable order is:

1. **Language Fundamentals** — loops, references, static, mutable, this, using
2. **Classes 1–8** — basic class mechanics, constructors, Rule of Three, structs
3. **Value Categories & Move** — lvalues/rvalues, std::move
4. **Classes 10–12** — Rule of Five, friend functions, explicit constructors
5. **Classes 13–24** — inheritance, virtual functions, vtable, multiple inheritance
6. **Classes 26–33** — initialization, data layout, pImpl, static members
7. **Smart Pointers** — unique_ptr, shared_ptr, weak_ptr
8. **Lambdas & Callables** — function pointers → functors → lambdas
9. **STL Containers** — start with the cheatsheet, then dive into individual containers
10. **Type System** — casts, variant, unions
11. **Design** — RAII, API design, composition vs inheritance

---

## About

These are Obsidian markdown notes with `[[wikilink]]` cross-references. They render fine on GitHub but link navigation works best when opened in Obsidian as a vault.
