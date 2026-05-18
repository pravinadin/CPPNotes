# Modern C++ — Comprehensive Study Guide (Playlist Edition)

> **Source:** Mike Shah's *The C++ Programming Language* YouTube playlist — all 247 episodes  
> [`https://www.youtube.com/playlist?list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L`](https://www.youtube.com/playlist?list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L)  
> **Reference:** Standard library examples follow [cppreference.com](https://en.cppreference.com) idioms.  
> **Coverage:** Modern C++ — C++11 / C++14 / C++17 / C++20 / C++23.

## How this guide is organized

The playlist is the spine. Every section below is annotated with the episode(s) it draws from — e.g. **(Ep. 33)**, **(Eps. 39–41)**. If you watch in order, you can read the corresponding section as a written companion; if you read in order, you can spot-check any topic against the matching video.

The guide is **synthesized**, not transcribed. I have the episode list and titles plus my own C++ knowledge and the project's existing per-episode notes; I do **not** have the audio transcripts, so paraphrases of Mike's framing are reconstructions rather than quotes. Code examples follow cppreference conventions and have been written to compile cleanly under `g++ -std=c++23 -Wall -Wextra`.

**Topics deliberately scoped out** (because they are not in this playlist):

- Concurrency / threads / mutexes / atomics
- C++20 Modules and Coroutines
- `std::filesystem`
- `std::expected` (C++23)

These are real, important parts of Modern C++, but for fidelity to the source they are not covered here. Mike has a separate Software Design / Design Patterns playlist where some of these surface.

---

## Table of Contents

**Part I — Setup & Foundations** *(Eps. 1–15)*
1. [About C++ and this Series](#1-about-c-and-this-series)
2. [The C++ Compilation Pipeline](#2-the-c-compilation-pipeline)
3. [The Many Versions of C++](#3-the-many-versions-of-c)
4. [Hello, World](#4-hello-world)
5. [Primitive Data Types](#5-primitive-data-types)
6. [`const` — First Use](#6-const--first-use)
7. [Block Scope](#7-block-scope)
8. [Raw Arrays and `std::array`](#8-raw-arrays-and-stdarray)
9. [Loops: `for`, range-`for`, `while`, `do-while`, `std::fill`](#9-loops)
10. [`continue` and `break`](#10-continue-and-break)

**Part II — Functions** *(Eps. 16–22, 30, 99, 108–110)*
11. [Writing Functions; Recursion](#11-writing-functions-recursion)
12. [The Address-of Operator `&`](#12-the-address-of-operator)
13. [Pass by Value](#13-pass-by-value)
14. [References](#14-references)
15. [Pass by Reference](#15-pass-by-reference)
16. [`const` Parameters and `std::is_const`](#16-const-parameters-and-stdis_const)
17. [Default Arguments](#17-default-arguments)
18. [`inline` Functions and `inline` Variables](#18-inline-functions-and-inline-variables)
19. [Function Pointers, `typedef`, `std::function`](#19-function-pointers-typedef-stdfunction)
20. [Functors — Function Objects with State](#20-functors--function-objects-with-state)

**Part III — Pointers, Memory, and Ownership** *(Eps. 23–35, 45, 69, 82, 225)*
21. [Pointers and Dereferencing](#21-pointers-and-dereferencing)
22. [Dynamic Memory: `new` / `delete` / `delete[]`](#22-dynamic-memory)
23. [Pointer Arithmetic and Array Offsets](#23-pointer-arithmetic-and-array-offsets)
24. [`sizeof` Pitfalls](#24-sizeof-pitfalls)
25. [Array Decay; Prefer `std::vector`](#25-array-decay-prefer-stdvector)
26. [Pointer Pitfalls + AddressSanitizer + GDB](#26-pointer-pitfalls--asan--gdb)
27. [lvalues, rvalues, and References](#27-lvalues-rvalues-and-references)
28. [`std::move`](#28-stdmove)
29. [`std::unique_ptr` (and Custom Deleters)](#29-stdunique_ptr-and-custom-deleters)
30. [`std::shared_ptr`](#30-stdshared_ptr)
31. [`std::weak_ptr`](#31-stdweak_ptr)
32. [RAII — Resource Acquisition Is Initialization](#32-raii)
33. [The `static` Keyword: static / stack / heap memory](#33-the-static-keyword)
34. [Perfect Forwarding / Universal References](#34-perfect-forwarding--universal-references)

**Part IV — Build Model & Tooling** *(Eps. 36, 80, 85, 104, 105, 107)*
35. [Header (`.hpp`) vs Implementation (`.cpp`)](#35-header-hpp-vs-implementation-cpp)
36. [Macros, `__LINE__`, `std::source_location`](#36-macros-line-stdsource_location)
37. [Command-Line Arguments: `argc`, `argv`, environment](#37-command-line-arguments)
38. [The `using` Keyword](#38-the-using-keyword)
39. [Effective Compiler Flags & Style Guides](#39-effective-compiler-flags--style-guides)

**Part V — Classes and Object-Oriented Programming** *(Eps. 37–70, 90, 98, 101, 203)*
40. [Class Introduction](#40-class-introduction)
41. [Default Constructor & Default Destructor](#41-default-constructor--default-destructor)
42. [Copy Constructor and Copy Assignment (Deep vs Shallow)](#42-copy-constructor-and-copy-assignment)
43. [Rule of 3 (and the Law of the Big Two)](#43-rule-of-3)
44. [Avoiding Copies: `=delete`, Pass by Reference](#44-avoiding-copies)
45. [Operator Overloading](#45-operator-overloading)
46. [Member Initializer Lists](#46-member-initializer-lists)
47. [`struct`s in C++](#47-structs)
48. [Rule of 5](#48-rule-of-5)
49. [`friend` Functions (and Why to Avoid)](#49-friend-functions)
50. [`explicit` Constructors and List Initialization](#50-explicit-constructors-and-list-initialization)
51. [Inheritance Introduction](#51-inheritance-introduction)
52. [Inheritance Access Levels: `public`, `protected`, `private`](#52-inheritance-access-levels)
53. [Inheritance Constructor Calls](#53-inheritance-constructor-calls)
54. [Virtual Functions / Dynamic Dispatch](#54-virtual-functions--dynamic-dispatch)
55. [Virtual Destructors](#55-virtual-destructors)
56. [The vtable (Interview Question)](#56-the-vtable)
57. [Pure Virtual Functions / Interfaces](#57-pure-virtual--interfaces)
58. [Multiple Inheritance — Caution](#58-multiple-inheritance--caution)
59. [`const` Correctness for Member Functions](#59-const-correctness-for-member-functions)
60. [`{}` vs `()` and `std::initializer_list`](#60--vs--and-stdinitializer_list)
61. [Composition vs Inheritance](#61-composition-vs-inheritance)
62. [Virtual Inheritance / Diamond Revisited](#62-virtual-inheritance--diamond-revisited)
63. [Value Initialization / Zero-Initialization of Members](#63-value-initialization)
64. [In-Class Initializer](#64-in-class-initializer)
65. [Delegating Constructors](#65-delegating-constructors)
66. [Class Data Layout (Optimizing for Size)](#66-class-data-layout)
67. [PIMPL — Pointer to Implementation; API Design](#67-pimpl--api-design)
68. [The `this` Keyword](#68-the-this-keyword)
69. [Static Member Variables and Functions](#69-static-member-variables-and-functions)
70. [Nested Classes](#70-nested-classes)
71. [`mutable` Keyword + the M&M Rule](#71-mutable-keyword--mm-rule)
72. [Conversion Operators](#72-conversion-operators)

**Part VI — `constexpr` Family & Assertions** *(Eps. 86–88, 205–206)*
73. [`constexpr`](#73-constexpr)
74. [`consteval` (C++20)](#74-consteval)
75. [`constinit` (C++20)](#75-constinit)
76. [`assert` and `static_assert`](#76-assert-and-static_assert)
77. [`auto`](#77-auto)

**Part VII — Casts & Bit-Level Programming** *(Eps. 91–95, 97, 207–213)*
78. [Casting: Types, Conversions, C-style](#78-casting-overview)
79. [Casting: What Could Go Wrong + `cmp_*`](#79-casting-what-could-go-wrong)
80. [Integer & Floating Suffixes; the `'` Digit Separator](#80-integer--floating-suffixes)
81. [`static_cast` and `dynamic_cast`](#81-static_cast-and-dynamic_cast)
82. [`reinterpret_cast`](#82-reinterpret_cast)
83. [Type Punning](#83-type-punning)
84. [`std::bit_cast`](#84-stdbit_cast)
85. [Print a Double in Binary (Exercise)](#85-print-a-double-in-binary-exercise)
86. [Fixed-Width Integer Types (`<cstdint>`)](#86-fixed-width-integer-types)
87. [C-Style Bit Manipulation](#87-c-style-bit-manipulation)
88. [`std::bitset`](#88-stdbitset)
89. [`<bit>` Algorithms (C++20)](#89-bit-algorithms)

**Part VIII — Lambdas** *(Eps. 100, 102, 103)*
90. [Lambdas Part 1 — Closures](#90-lambdas-1--closures)
91. [Lambdas Part 2 — The Capture](#91-lambdas-2--the-capture)
92. [Lambdas Part 3 — Capturing `this`](#92-lambdas-3--capturing-this)

**Part IX — Templates and Generics** *(Eps. 71–79, 81, 214–225, 245)*
93. [Templates Introduction](#93-templates-introduction)
94. [Function Templates](#94-function-templates)
95. [Multiple Template Parameters; Non-Type Parameters](#95-multiple-and-non-type-template-parameters)
96. [Template Specialization (Full and Partial)](#96-template-specialization)
97. [Variadic Templates](#97-variadic-templates)
98. [Class Templates](#98-class-templates)
99. [Class Templates with Static Data Members](#99-class-templates-with-static-data-members)
100. [Class Template Argument Deduction (CTAD)](#100-ctad)
101. [Template Class Default Parameters](#101-template-class-default-parameters)
102. [`if constexpr`, Type Traits, Free Functions](#102-if-constexpr-type-traits-free-functions)
103. [SFINAE](#103-sfinae)
104. [C++20 Concepts (Eps. 216–220, 224)](#104-c20-concepts)
105. [Template Metaprogramming: `type_traits`, `enable_if` (Eps. 221–223)](#105-template-metaprogramming)
106. [Fold Expressions and Parameter Packs](#106-fold-expressions-and-parameter-packs)

**Part X — STL Containers** *(Eps. 83–84, 111–134)*
107. [STL Overview](#107-stl-overview)
108. [`std::string`, `char*`, String Literals](#108-stdstring-char-string-literals)
109. [`std::string_view`](#109-stdstring_view)
110. [`std::array`](#110-stdarray)
111. [`std::span` (C++20)](#111-stdspan)
112. [`std::vector`](#112-stdvector)
113. [`std::list`](#113-stdlist)
114. [`std::forward_list`](#114-stdforward_list)
115. [`std::deque`](#115-stddeque)
116. [Sets: `set`, `unordered_set`, `multiset`, `unordered_multiset`](#116-sets)
117. [`std::pair`, `std::ref`, `std::get`](#117-stdpair-stdref-stdget)
118. [Maps: `map`, `multimap`, `unordered_map`, `unordered_multimap`](#118-maps)
119. [Container Adapters: `stack`, `queue`, `priority_queue`](#119-container-adapters)
120. [Container High-Level Review](#120-container-review)
121. [`union`s](#121-unions)
122. [`std::variant`](#122-stdvariant)

**Part XI — STL Iterators** *(Eps. 135–140)*
123. [Iterators: Introduction](#123-iterators-introduction)
124. [Iterator Categories](#124-iterator-categories)
125. [Range-Access Functions](#125-range-access-functions)
126. [Writing a Custom Iterator](#126-writing-a-custom-iterator)
127. [Iterator Invalidation](#127-iterator-invalidation)

**Part XII — STL Algorithms** *(Eps. 141–176, 204)*
128. [Algorithms — Introduction & Generic Design](#128-algorithms-introduction)
129. [Search: `find`, `find_if`, `search`, `adjacent_find`](#129-search-algorithms)
130. [Comparison: `mismatch`, `equal`, `lexicographical_compare`](#130-comparison-algorithms)
131. [Quantifiers: `all_of`, `any_of`, `none_of`](#131-quantifiers)
132. [Counting: `count`, `count_if`](#132-counting)
133. [Copy: `copy`, `copy_if`, `copy_n`](#133-copy)
134. [Generation: `fill`, `generate` (and `_n` variants)](#134-generation)
135. [`reverse`, `reverse_copy`](#135-reverse)
136. [Erase-Remove Idiom; `std::erase` / `erase_if` (C++20)](#136-erase-remove)
137. [`sample`](#137-sample)
138. [`rotate`](#138-rotate)
139. [`shuffle`](#139-shuffle)
140. [`unique`, `unique_copy`](#140-unique)
141. [`transform`](#141-transform)
142. [Partition Family](#142-partition-family)
143. [Sorting: `sort`, `stable_sort`, `is_sorted`, `nth_element`, `partial_sort`](#143-sorting)
144. [Merge: `inplace_merge`, `merge`](#144-merge)
145. [Binary Search: `lower_bound`, `upper_bound`, `binary_search`](#145-binary-search)
146. [Set Operations: `includes`, `union`, `intersection`, `difference`](#146-set-operations)
147. [Heap Algorithms](#147-heap-algorithms)
148. [Min/Max Algorithms (`min`, `max`, `minmax`, `clamp`, `*_element`)](#148-min-max)
149. [`swap`, `iter_swap`](#149-swap)

**Part XIII — Numeric Algorithms** *(Eps. 177–186)*
150. [`midpoint`, `lerp`](#150-midpoint-lerp)
151. [`iota`](#151-iota)
152. [`adjacent_difference`, `partial_sum`](#152-adjacent_difference-partial_sum)
153. [`inner_product` (Map–Reduce Pairs)](#153-inner_product)
154. [`accumulate` (Fold)](#154-accumulate)
155. [`reduce` (Parallel Fold) and `transform_reduce`](#155-reduce-and-transform_reduce)
156. [`exclusive_scan`, `inclusive_scan`](#156-scans)

**Part XIV — Output, Streams, and Files** *(Eps. 187–202)*
157. [`std::format` (C++20)](#157-stdformat)
158. [`std::format` with STL Containers](#158-stdformat-with-stl-containers)
159. [`std::formatter` for Custom Types](#159-stdformatter-for-custom-types)
160. [`std::print` (C++23)](#160-stdprint)
161. [`std::cout`](#161-stdcout)
162. [`cerr` and `clog` — Buffered vs Unbuffered](#162-cerr-and-clog)
163. [`std::ostream` Member Functions](#163-stdostream-member-functions)
164. [`std::cin`](#164-stdcin)
165. [Creating and Appending Files](#165-creating-and-appending-files)
166. [Reading Files](#166-reading-files)
167. [Binary I/O](#167-binary-io)
168. [Serialize and Deserialize a `struct`](#168-serialize-and-deserialize-a-struct)
169. [String Streams (`<sstream>`)](#169-string-streams)
170. [Raw String Literals `R"(...)"`](#170-raw-string-literals)
171. [`std::to_string` and `std::stoi`](#171-to_string-and-stoi)

**Part XV — Ranges (C++20)** *(Eps. 226–231)*
172. [Ranges Part 1 — Problems They Solve](#172-ranges-1--problems-they-solve)
173. [Ranges Part 2 — Parts of a Range](#173-ranges-2--parts-of-a-range)
174. [Views and Adaptors; `ranges::to`](#174-views-and-adaptors)
175. [`transform`, `drop_while`](#175-transform-drop_while)
176. [`views::keys`, `values`, `elements`](#176-views-keys-values-elements)
177. [`cartesian_product`, `take`](#177-cartesian_product-take)

**Part XVI — Safety & Errors (C++ Safety series)** *(Eps. 232–244, 246–247)*
178. [The Zero-Overhead Principle](#178-zero-overhead-principle)
179. [Language-Level Safety](#179-language-level-safety)
180. [Attributes (`[[nodiscard]]`, `[[noreturn]]`, …)](#180-attributes)
181. [Prefer `explicit` and `{}`-Initialization](#181-prefer-explicit-and--init)
182. [Exceptions: Introduction](#182-exceptions-introduction)
183. [Exceptions and RAII](#183-exceptions-and-raii)
184. [Stack Unwinding](#184-stack-unwinding)
185. [Why Some People Hate Exceptions](#185-why-some-people-hate-exceptions)
186. [Exceptions in a Real-World Codebase (OGRE 3D)](#186-exceptions-in-a-real-world-codebase)
187. [`std::stacktrace` (C++23)](#187-stdstacktrace)
188. [Function-Try-Block](#188-function-try-block)
189. [Custom `std::exception`](#189-custom-stdexception)
190. [Error Codes — `std::error_code`](#190-error-codes)
191. [`std::optional` and Monadic Operations (C++23)](#191-stdoptional)

**Part XVII — Closing**
192. [Idioms, Pitfalls & Best Practices Cheat Sheet](#192-cheat-sheet)
193. [Resources & Further Reading](#193-resources)

---

# Part I — Setup & Foundations

## 1. About C++ and this Series
*(Ep. 1)*

C++ is a **general-purpose, multi-paradigm language**. You can write it procedurally, object-oriented, or in a functional style — and you can mix all three. That flexibility, combined with direct hardware access and no unnecessary layers of abstraction, is why it powers operating systems, browsers, game engines, embedded systems, trading platforms, and more: anywhere performance is non-negotiable and you don't want the language getting in your way.

It's a big language. This series starts from the beginning (variables, types, loops, functions) and works up through smart pointers, templates, the STL, C++20 ranges, and safety idioms.

What this guide expects of you:
- At least a little programming experience (in any language — Python, Java, C, anything).
- Willingness to type the examples and run them. Reading C++ is a poor substitute for compiling C++.
- A toolchain installed: GCC ≥ 12, Clang ≥ 15, or MSVC 19.30+ for full C++20/23 coverage.

## 2. The C++ Compilation Pipeline
*(Ep. 2)*

C++ goes from source to executable in four stages:

```
hello.cpp ──[Preprocessor]──▶ expanded TU
          ──[Compiler]─────▶ assembly (.s)
          ──[Assembler]────▶ object file (.o)
          ──[Linker]───────▶ executable
```

| Stage | What it does |
|-------|--------------|
| **Preprocessor** | Resolves `#include`, `#define`, `#ifdef`. Output is a single, expanded **translation unit**. |
| **Compiler** | Type checks, instantiates templates, optimizes, emits assembly. |
| **Assembler** | Translates assembly to machine code, producing a relocatable object file. |
| **Linker** | Resolves symbols across `.o` files and libraries; produces the final binary. |

Why this matters in practice:
- Errors in unmatched braces or unknown identifiers come from the **compiler**.
- "Undefined reference to …" errors come from the **linker** — usually a missing `.cpp`/library, or a mismatch between declaration and definition.
- The **One Definition Rule (ODR)**: each entity has at most one definition across the program. Declarations may repeat; definitions may not (with carve-outs for `inline` and templates).
- **Every source change requires a full recompile.** Edit → save → recompile → run is the cycle. Some editors/IDEs automate this, but the step is never optional.

```bash
# Build flags worth memorizing
g++ -std=c++23 -Wall -Wextra -Wpedantic -O2 hello.cpp -o hello
g++ -std=c++23 -g -O0 -fsanitize=address,undefined hello.cpp -o hello   # debug
```

## 3. The Many Versions of C++
*(Ep. 8)*

C++ ships a new standard every three years. Highlights you'll meet in this playlist:

| Version | Notable additions used here |
|---------|------------------------------|
| **C++98 / 03** | The original STL, templates, exceptions |
| **C++11** | `auto`, range-`for`, lambdas, smart pointers, move semantics, `nullptr`, `enum class`, `constexpr`, `std::array`, `std::thread`, `=delete`/`=default` |
| **C++14** | Generic lambdas, return-type deduction, `std::make_unique` |
| **C++17** | `if`/`switch` init, structured bindings, `std::optional`, `std::variant`, `std::any`, `std::string_view`, `if constexpr`, fold expressions, parallel algorithms, CTAD |
| **C++20** | Concepts, ranges, `std::span`, `std::format`, three-way comparison `<=>`, `consteval`/`constinit`, `std::source_location`, `<bit>` algorithms |
| **C++23** | `std::print`, `std::expected`, monadic `std::optional` operations, `std::stacktrace`, `std::generator` |

You opt into a standard with `-std=c++NN` (e.g., `-std=c++23`).

## 4. Hello, World
*(Ep. 6)*

```cpp
#include <iostream>
#include <cstdlib>   // EXIT_SUCCESS

int main() {
    std::cout << "Hello, C++!\n";
    return EXIT_SUCCESS;   // expands to 0; signals successful execution to the OS
}
```

Anatomy:
- `#include <iostream>` — pull in the iostreams library declarations.
- `int main()` — every C++ program has exactly one `main`; it returns `int` to the OS. `return 0` and `return EXIT_SUCCESS` are equivalent.
- `std::cout` — the standard output stream object, in namespace `std`.
- `<<` — the stream insertion operator (overloaded `operator<<`).
- `\n` — newline. Prefer `'\n'` over `std::endl` unless you need to flush; `std::endl` writes `'\n'` **and** flushes the buffer, which is usually unnecessary overhead.

### `using namespace std` — why the guide avoids it

You may see `using namespace std;` which lets you write `cout` instead of `std::cout`. Mike explicitly avoids it: being explicit about where names come from (`std::cout`, `std::vector`) prevents naming conflicts and makes code easier to read. This guide follows the same convention throughout.

## 5. Primitive Data Types
*(Ep. 10)*

C++ is **statically typed**: every variable's type is fixed at compile time. When you declare `int x = 42;`, the compiler knows for the lifetime of that variable that `x` holds an integer — no dynamic type changes at runtime.

| Category | Types |
|----------|-------|
| Integer | `bool`, `char`, `signed char`, `unsigned char`, `short`, `int`, `long`, `long long` (and `unsigned` variants) |
| Floating point | `float` (4 B, ~7 sig. digits), `double` (8 B, ~15 sig. digits), `long double` |
| Other | `void`, `nullptr_t`, `wchar_t`, `char8_t`/`char16_t`/`char32_t` |

> **`string` is NOT a primitive type.** You must `#include <string>` and use `std::string`. Storing more than one character in a `char` triggers a warning; `const char*` works but is a C-style pointer — prefer `std::string` or `std::string_view`.

```cpp
#include <iostream>
#include <string>

int main() {
    bool        ok  = true;       // prints as 1 (true) or 0 (false)
    char        c   = 'A';        // single character, single quotes
    int         n   = 42;
    long long   big = 4'000'000'000LL;
    float       f   = 3.14f;      // 'f' suffix makes it a float literal
    double      d   = 2.71828;
    std::string s   = "hello";    // not primitive — needs <string>

    // sizeof returns the number of bytes a type or variable occupies
    std::cout << "sizeof(int)    = " << sizeof(int)    << '\n';  // 4 (typical)
    std::cout << "sizeof(double) = " << sizeof(double) << '\n';  // 8
    std::cout << "sizeof(bool)   = " << sizeof(bool)   << '\n';  // 1
    std::cout << "ok as int: "       << ok             << '\n';  // 1
}
```

Sizes are platform-dependent (`int` is at least 16 bits but typically 32). When exact widths matter — network protocols, hardware registers — use fixed-width types from `<cstdint>` such as `int64_t`, `uint32_t` (covered in §86).

## 6. `const` — First Use
*(Ep. 11)*

`const` makes a variable **immutable** (read-only) after initialization. Without it, variables are mutable by default — you can reassign them at any time. `const` is how you opt out of that mutability.

```cpp
float pi = 3.14159f;
pi = -42.0f;   // compiles fine — mutable by default, but logically wrong

const float kPi = 3.14159f;
// kPi = -42.0f;   // ❌ error: assignment of read-only variable 'kPi'
```

`const` shows up in three big places:
1. **Read-only variables** (above).
2. **Function parameters** — promise not to modify caller data: `void log(const std::string& s);` (covered in §16).
3. **Member functions** — promise not to modify the object: `int size() const;` (covered in §59).

`const_cast` can technically strip `const`, but doing so is almost always a design mistake and undefined behavior if the underlying object was originally `const`. Avoid it.

Treat `const` as documentation the compiler enforces. Languages like Swift make values immutable by default (`let`) — C++ has the opposite default for historical reasons, which is why `const` discipline matters.

## 7. Block Scope
*(Ep. 12)*

A pair of braces `{ … }` defines a **block scope**. Variables declared inside are visible only within that block, and destroyed when the block ends.

```cpp
#include <iostream>

int main() {
    int x = 1;
    {
        int x = 99;                    // shadows outer x; OK syntactically, often confusing
        std::cout << "inner x = " << x << '\n';   // 99
    }                                   // inner x destroyed
    std::cout << "outer x = " << x << '\n';       // 1
}
```

Why it matters:
- **Lifetime is deterministic.** Stack objects are destroyed in reverse construction order at scope exit. This is what makes RAII (§32) work.
- **Shorter scope = fewer bugs.** Declare variables as close to first use as possible.
- **Avoid global variables** wherever practical. They have no scope limits — any code, in any file, can read or write them. That makes them hard to reason about, easy to collide on (two functions each expecting their own `x`), and nearly impossible to test in isolation.

> **Globals are not good.** This is a general principle in almost every language. There are rare exceptions, but they require a design decision you can justify.

`static` (at file scope) is a way to limit a global to a single translation unit, but it's still a global within that file. We'll revisit `static` in §33.

## 8. Raw Arrays and `std::array`
*(Eps. 13, 114)*

An array is a **homogeneous, contiguous** data structure: all elements are the same type, laid out one after another in memory. That contiguity is what makes them fast — CPUs love sequential memory access.

### C-style raw arrays

```cpp
int ids[100];         // 100 ints laid out contiguously; size fixed at compile time
ids[0] = 12345;       // zero-indexed
// ids[100000] = 1;   // compiles but causes undefined behavior — likely a segfault
```

Raw arrays have two problems: they lose their size when passed to a function (§25), and out-of-bounds access is silent undefined behavior.

### `std::array<T, N>` — the C++11 upgrade

`std::array<T, N>` has the same memory layout as `T[N]` — zero overhead — but it knows its size and integrates with STL algorithms. More importantly, it offers **bounds-checked access** via `.at()`.

```cpp
#include <array>
#include <iostream>

int main() {
    std::array<int, 5> a = {1, 2, 3, 4, 5};

    std::cout << a.size()  << '\n';          // 5
    std::cout << a.front() << ' ' << a.back() << '\n';  // 1 5
    for (int x : a) std::cout << x << ' ';  // range-for works

    // operator[] — no bounds check (fast, unsafe)
    // .at()      — bounds checked; throws std::out_of_range if out of bounds
    std::cout << a.at(4) << '\n';   // 5  — OK
    // a.at(100);                   // throws std::out_of_range: "n (which is 100) >= _Nm (which is 5)"
}
```

Contrast the two access patterns on bad input:

| Access style | Out-of-bounds result |
|---|---|
| `raw[100000]` | Segmentation fault (or silent corruption) |
| `std::array::operator[]` | Undefined behavior |
| `std::array::at(100000)` | `std::out_of_range` exception — descriptive message |

**Default to `std::array` over `T[N]`.** No size loss, range-`for` works, standard algorithms accept its iterators, and `.at()` gives you a safety net during development.

## 9. Loops
*(Ep. 14)*

```cpp
#include <iostream>
#include <vector>
#include <algorithm>      // std::fill

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5};

    // 1. Traditional for — when you need an index
    for (std::size_t i = 0; i < v.size(); ++i)
        std::cout << v[i] << ' ';

    // 2. Range-based for (C++11) — cleanest for "do X to each element"
    for (const auto& x : v) std::cout << x << ' ';

    // 3. while — when termination isn't a count
    int n = 5;
    while (n > 0) { std::cout << n-- << ' '; }

    // 4. do-while — body always runs at least once
    int x = 0;
    do { std::cout << "once\n"; } while (false);

    // std::fill — replace a manual loop with an algorithm
    std::fill(v.begin(), v.end(), 0);
}
```

**Guidance:**
- Range-`for` for "do X to each element."
- Traditional `for` when you need the index, or to iterate non-trivially.
- `while` for unknown-count loops.
- `do-while` is rare — useful for menus and post-condition checks.
- Reach for an STL algorithm whenever it expresses intent more clearly than a hand-written loop (see Part XII).

## 10. `continue` and `break`
*(Ep. 15)*

Both alter loop flow.

```cpp
for (int i = 0; i < 10; ++i) {
    if (i % 2 == 0) continue;     // skip rest of body; re-test the condition
    if (i == 7)     break;        // exit the loop entirely
    std::cout << i << ' ';        // prints 1 3 5
}
```

### Nested loops — `break` exits only the innermost loop

```cpp
for (int x = 0; x < 3; ++x) {
    for (int i = 0; i < 10; ++i) {
        break;            // exits the inner loop; outer loop continues
    }
    std::cout << "x = " << x << '\n';   // prints 3 times
}
```

`continue` similarly applies to the **innermost** enclosing loop.

Use sparingly. A loop with several `break`s and `continue`s is often a sign that the body should be extracted into a function, or that an STL algorithm could replace the loop entirely (see Part XII).

---

# Part II — Functions

## 11. Writing Functions; Recursion
*(Eps. 16, 17)*

A function has four parts: **return type**, **name**, **parameter list**, and **body**.

```cpp
// Full definition
int add(int a, int b) { return a + b; }

// A function returning nothing uses void
void greet() { std::cout << "Hello functions\n"; }

// Trailing return type (modern alternative syntax — same meaning)
auto multiply(int a, int b) -> int { return a * b; }
```

### Forward declarations

C++ reads top-to-bottom. If `main` calls `add` and `add` is defined below `main`, you get a compilation error. Fix it with a **forward declaration** (just the signature):

```cpp
int add(int a, int b);   // declaration — compiler now knows this exists

int main() {
    std::cout << add(2, 3) << '\n';   // OK
}

int add(int a, int b) { return a + b; }   // definition can follow
```

> Keep parameter lists short — **≤5 parameters** is a good rule of thumb. When you need more, bundle them into a `struct` (see §67).

### Recursion

```cpp
void countdown(int n) {
    if (n == 0) { std::cout << "Blast off!\n"; return; }   // base case
    std::cout << n << '\n';
    countdown(n - 1);   // recursive case
}
```

Every call creates a **stack frame** storing the return address and arguments. Stack space is limited (typically 1–8 MiB per thread) — recursing 5 million deep will overflow it with a segfault. Deep recursion must become iteration.

### Function overloading

C++ lets multiple functions share a name as long as the **parameter list** differs. Return type alone isn't enough to distinguish.

```cpp
void print(int);
void print(double);
void print(const std::string&);   // compiler picks by argument type at the call site
```

Watch out for ambiguity: `1.5` is `double`, `1.5f` is `float`. When the compiler can't pick a unique match it reports an ambiguous overload error.

> **🎯 Mental Model — A function is a contract:**
> The signature is what the *caller* needs to know; the body is what the *callee* implements. The compiler enforces the signature is honored on both sides. This is the foundation of *separate compilation* — the caller and callee don't need to be in the same file, the same library, or even written in the same year. They just need to agree on the signature.

> **🏭 Industry Note — Naming functions:**
> - **Verb-based** for actions: `calculate_tax()`, `send_packet()`, `parse_url()`.
> - **Noun-based** for queries (often `const` methods): `name()`, `size()`, `is_empty()`.
> - **`get_/set_` prefixes** divide opinion — Google says yes, others say drop them and let the name speak (`age()` over `get_age()`).
> - **Bool predicates** start with `is_`, `has_`, `can_`, `should_`: `is_valid()`, `has_children()`.
> - **Avoid abbreviations** unless they're domain standard (`url`, `id`, `tcp` OK; `usr_lst_mgr` not OK).

> **⚠️ Pitfall — C++ does NOT guarantee tail-call optimization:**
> Unlike OCaml/Scala, the C++ standard doesn't require a "tail-recursive" function to become a loop with constant stack. Compilers *may* optimize it but aren't required to. Don't rely on TCO for correctness — if recursion depth is unbounded, rewrite as a loop with an explicit stack.

> **🔬 Under the Hood — How overload resolution works:**
> Given `f(1.5, x)`, the compiler:
> 1. Builds a set of **candidate functions** (all `f`s visible by name + ADL).
> 2. Filters to **viable** (parameter count and types reachable via implicit conversions).
> 3. Ranks by **best match** (exact > promotion > standard conversion > user-defined conversion > variadic).
> 4. Picks the unique best. If tied → ambiguity error.
>
> The "promotion" step is why `1.5` (double) prefers `f(double)` over `f(float)` (which requires narrowing). Mixing `float` and `double` in overloads causes surprises for this reason.

## 12. The Address-of Operator `&`
*(Ep. 18)*

The unary `&` returns a variable's memory address.

```cpp
int x = 42;
std::cout << &x << '\n';   // e.g., 0x7ffeefbff5ac
```

Conceptually: think of memory as a giant numbered street; `&x` is the house number where `x` lives. Pointers (section 21) carry such house numbers; references (section 14) are aliases for them.

`&` has *three* meanings in C++ — keep them straight:
1. **Unary `&x`** — address of `x` (this section).
2. **In a type — `int& y`** — declares `y` as a reference (section 14).
3. **Bitwise AND — `a & b`** — bit-level operation (section 87).

## 13. Pass by Value
*(Ep. 19)*

When you pass an argument by value, the function gets a **copy**.

```cpp
#include <iostream>

void mutate(int n) {     // n is a copy
    n = 99;
}

int main() {
    int x = 42;
    mutate(x);
    std::cout << x << '\n';   // still 42
}
```

- Caller's variable is unchanged.
- Cost of a copy. Cheap for `int`/`double`; expensive for `std::vector<std::string>`.
- The function gets full freedom to mutate its parameter without affecting the caller.

> **🔬 Under the Hood — Calling conventions and registers:**
> On x86-64 Linux (System V ABI), the first 6 integer args go in registers (`rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`), the first 8 float args in `xmm0`–`xmm7`. Anything beyond that, plus large structs, spill to the stack. This means:
> - Small pass-by-value (int, double, `std::span`) is **essentially free** — it's just a register.
> - Large pass-by-value (a `std::vector<std::string>` with heap data) copies via heap allocation per call. Brutal.
> - On Windows x64, only 4 args are in registers — different ABI, same idea.

## 14. References
*(Ep. 20)*

A **reference** is an alias for an existing object. Once bound, it always refers to the same object.

```cpp
int x = 10;
int& r = x;     // r is an alias for x
r = 20;         // x is now 20
std::cout << &x << ' ' << &r << '\n';   // same address
```

Rules:
- A reference must be initialized at declaration; you can't have an "uninitialized" reference.
- It cannot be re-seated to refer to a different object.
- It is *not* a pointer at the language level (no null reference); the compiler may implement it as a pointer.

## 15. Pass by Reference
*(Ep. 21)*

```cpp
#include <iostream>

void mutate(int& n) {     // n is a reference to caller's variable
    n = 99;
}

int main() {
    int x = 42;
    mutate(x);
    std::cout << x << '\n';   // now 99
}
```

- No copy — efficient for large objects.
- The function can read **and write** the caller's variable.
- Pair with `const` (next section) when the function should only read.

## 16. `const` Parameters and `std::is_const`
*(Ep. 22)*

`const T&` is the **idiomatic "read-only big object" parameter** — efficient (no copy) and safe (function can't modify).

```cpp
void log(const std::string& msg) {
    std::cout << msg << '\n';
    // msg = "...";   // ❌ assignment of read-only reference
}
```

### Decision table

| Form | Use when |
|------|----------|
| `void f(T)` | Cheap to copy (int, double, small POD); or you need a working copy |
| `void f(const T&)` | Read-only access to a possibly-large object |
| `void f(T&)` | You will modify the caller's object |
| `void f(T*)` | Like `T&` but optional / nullable; or expressing "no object" |
| `void f(T&&)` | You'll consume / move-from the argument (section 28) |

### `std::is_const`

```cpp
#include <type_traits>
static_assert(std::is_const_v<const int>);
static_assert(!std::is_const_v<int>);
```

A compile-time predicate from `<type_traits>`, useful in template metaprogramming (Part IX).

> **✅ Decision Rule — Parameter passing cheat sheet:**
> | What you need | Use |
> |---|---|
> | Read a cheap thing (int, double, pointer, `std::span`, `std::string_view`) | `T` (by value) |
> | Read a big thing (vector, string, custom class) | `const T&` |
> | Modify the caller's variable | `T&` |
> | Optional, can be null | `T*` (often replaced by `std::optional<T>` for values) |
> | Sink — function will store/move from it | `T` (by value) + `std::move` inside, OR `T&&` |
> | Generic (template) | forwarding reference `T&&` + `std::forward<T>(arg)` |
> | Polymorphic interface | `Interface&` or `Interface*` |
>
> **Modern guideline (Herb Sutter, Sean Parent):** if a function will store/copy/move the argument, take it by value. The compiler optimizes the copy at the call site. If it only reads, take `const T&` (or `T` if cheap to copy).

> **🏭 Industry Note — `string_view` and `span` over `const T&`:**
> For functions that only read a string or contiguous sequence, **prefer `std::string_view` (C++17) or `std::span<const T>` (C++20)**:
> ```cpp
> // Old style — accepts std::string only
> void log(const std::string& msg);
>
> // Modern style — accepts std::string, C-string, char[], string literal, substring slices
> void log(std::string_view msg);
> ```
> Avoids creating a temporary `std::string` for `log("literal")` calls. Just remember: views don't own; don't store them long-term.

## 17. Default Arguments
*(Ep. 108)*

A function parameter may have a default, used when the caller omits it.

```cpp
void connect(const std::string& host, int port = 443, int timeout_ms = 5000);

connect("api.example.com");
connect("api.example.com", 80);
connect("api.example.com", 80, 1000);
```

Rules:
- Defaults must be on **trailing** parameters only — you can't put a default on an earlier parameter and require the caller to supply a later one.
- Specify the default **once**, in the declaration the caller sees (typically in the header).
- Don't pile up defaults in a public API; that's a sign you want a **`struct Options`** parameter instead (§67).

Two practical reasons to reach for default arguments:
1. **Natural optional parameters** — e.g., a 3D system where Z defaults to `0` for 2D callers.
2. **Extending legacy APIs** — adding a new parameter with a safe default keeps existing call sites working without modification.

## 18. `inline` Functions and `inline` Variables
*(Eps. 109, 110)*

`inline` has two related but distinct roles in C++.

### Role 1 — Performance hint: function inlining (Ep. 109)

When you call a function, the CPU must save a return address, copy arguments, jump to the function body, and jump back. For tiny functions like `square(x)`, that overhead can dwarf the actual work. `inline` hints to the compiler to **copy the function body to each call site** instead:

```cpp
inline int square(int x) { return x * x; }
// compiler may expand: y = square(5)  →  y = 5 * 5  →  y = 25
```

**Pros:** better CPU instruction locality; enables further optimizations (constant folding, etc.)
**Cons:** larger binary if the function is big or called many times; slightly harder to debug (no function symbol to step into).

The compiler may ignore your hint. With GCC/Clang, `[[gnu::always_inline]]` forces it.

### Role 2 — ODR: definitions in headers (Ep. 110)

The bigger modern use: an `inline` function or variable can be **defined in a header** and included by multiple `.cpp` files without a "multiple definition" linker error — the linker merges duplicates.

```cpp
// math.hpp — safe to #include from many .cpp files
inline int square(int x) { return x * x; }

// C++17: inline static member variables — no separate .cpp definition needed
struct Config {
    static inline int version = 3;   // non-const, mutable, header-only
};

// header-only constants (also valid pre-C++17 via constexpr)
inline constexpr double kPi = 3.14159265358979;
```

Without `inline`, a non-const static member needs a separate `.cpp` file to provide its definition — a common "undefined reference" trap for beginners. `inline` (C++17) eliminates that extra file.

`constexpr` static members are **implicitly inline**, so you don't need to spell it out for those.

## 19. Function Pointers, `typedef`, `std::function`
*(Ep. 30)*

Functions have addresses too. A **function pointer** stores one, letting you pick which function to call at runtime.

**Classic use case — callbacks:** a GUI framework calls your function when the user clicks a button. The framework doesn't know which function you want — it just stores your function pointer and calls it at the right moment.

```cpp
int add(int x, int y)      { return x + y; }
int multiply(int x, int y) { return x * y; }

int (*op)(int, int) = &add;   // pointer-to-function: returns int, takes (int, int)
std::cout << op(3, 7) << '\n'; // 10

op = &multiply;
std::cout << op(3, 7) << '\n'; // 21
```

The syntax is notoriously ugly. Two ways to tame it:

```cpp
// C typedef (you'll see this in older codebases)
typedef int (*IntOp)(int, int);
IntOp pfn = &add;

// Modern C++ using-alias (preferred)
using IntOp = int(*)(int, int);
IntOp pfn = &add;
```

For type-erased callables (lambdas with captures, member functions, functors), use `std::function` from `<functional>`:

```cpp
#include <functional>

std::function<int(int,int)> g = add;            // wraps a free function
g = [](int a, int b){ return a + b; };          // or a lambda
std::cout << g(4, 5) << '\n';                   // 9
```

`std::function` carries a small allocation for non-trivial captures and an indirect call cost. In performance-critical paths, prefer a template parameter to keep the call inlinable.

## 20. Functors — Function Objects with State
*(Ep. 99)*

A **functor** is a class (or struct) with `operator()` overloaded — an object you can call like a function. Unlike a plain function, it can carry **state** between calls.

> A functor = a function with state.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

struct Threshold {
    int limit;                                         // state
    bool operator()(int x) const { return x > limit; }
};

int main() {
    std::vector<int> v = {1, 5, 3, 9, 2, 8};
    Threshold above4{4};                               // create with state
    int n = std::count_if(v.begin(), v.end(), above4);
    std::cout << n << '\n';      // 3  (elements 5, 9, 8 are > 4)
}
```

You can overload `operator()` multiple times with different signatures — the right overload is chosen by argument types, same as any overloaded function.

STL algorithms accept any **callable** (function pointer, functor, lambda). Functors were the idiomatic way to pass stateful behavior before C++11 lambdas. Understanding them is important because **lambdas are syntactic sugar over compiler-generated functors** — the compiler creates a nameless struct with `operator()` and captures as members. Part VIII (lambdas) builds directly on this.

### Functor for custom sorting

```cpp
struct Goblin { int health; int strength; };

struct ByHealth {
    bool operator()(const Goblin& a, const Goblin& b) const {
        return a.health < b.health;
    }
};

std::vector<Goblin> goblins = {{5,3}, {3,8}, {100,1}};
std::sort(goblins.begin(), goblins.end(), ByHealth{});
// sorted: {3,8}, {5,3}, {100,1}
```

> **🏭 Industry Note — Why functors beat function pointers for STL:**
> ```cpp
> bool by_health(const Goblin& a, const Goblin& b) { return a.health < b.health; }
>
> std::sort(g.begin(), g.end(), by_health);    // function pointer — indirect call, slower
> std::sort(g.begin(), g.end(), ByHealth{});   // functor — inlined, faster
> std::sort(g.begin(), g.end(),                // lambda — also inlined
>           [](const Goblin& a, const Goblin& b){ return a.health < b.health; });
> ```
> Benchmarks consistently show 2–10× speedup for sorting with functors/lambdas over function pointers because the compiler can **inline** the comparison. This is why `qsort` (C) is slower than `std::sort` (C++) on the same data.

> **🎯 Mental Model — Three callable styles, one concept:**
> ```cpp
> int f(int x) { return x * 2; }                   // function
> struct F { int operator()(int x) { return x*2; } }; // functor
> auto f = [](int x) { return x * 2; };            // lambda
> ```
> All three are *callable* — you invoke them with `f(5)`. STL algorithms accept any of them. Lambdas are functors generated by the compiler; the only "real" thing is the functor.

---


# Part III — Pointers, Memory, and Ownership

## 21. Pointers and Dereferencing
*(Eps. 23, 24)*

A pointer is a variable that stores an address. The unary `*` (the **dereference operator**) reads or writes the object at that address.

```cpp
int x = 42;
int* p = &x;          // p holds the address of x

std::cout << *p;       // 42  — read through the pointer
*p = 100;              // write through the pointer
std::cout << x;        // 100
```

Mental model from the videos: addresses are house numbers; the pointer is a piece of paper with the number on it; dereferencing is going inside the house.

A pointer's *type* matters for arithmetic and dereferencing:
- `int* p` advances by `sizeof(int)` per `++p`.
- `char* q` advances by `1`.

### Pointer-to-`const` vs `const` pointer

```cpp
const int* p1 = &x;        // pointer to const int  — *p1 = 1; ❌, p1 = &y; ✅
int* const p2 = &x;        // const pointer to int  — *p2 = 1; ✅, p2 = &y; ❌
const int* const p3 = &x;  // both
```

Read right-to-left: "p3 is a const pointer to const int."

### `nullptr` (C++11)

```cpp
int* p = nullptr;        // not pointing anywhere
if (p) { /* ... */ }     // pointers convert to bool: nullptr → false
```

Always prefer `nullptr` over `NULL` or `0`; it has type `std::nullptr_t` and disambiguates overloads.

> **🎯 Mental Model — Three things a pointer can be:**
> 1. **Valid** — points to a live object you can read/write.
> 2. **Null** — explicitly "points to nothing." Safe to compare, dereferencing is a crash.
> 3. **Dangling** — points to memory that *was* an object but is now invalid (freed/out-of-scope). **Indistinguishable from valid at runtime** — this is the dragon.
>
> Modern C++'s smart pointers, references, and views exist almost entirely to keep #3 from happening. Raw pointers in modern code should be **non-owning, never null** (use a reference instead) — or use `std::optional<T>`/`std::span` for the nullable/sized cases.

> **🏭 Industry Note — Where raw pointers still belong:**
> - **Non-owning function parameters** that can be null: `void render(Logger* maybe_log)`. (References can't be null.)
> - **C interop:** any API that takes `void*` or a typed pointer.
> - **Containers of trivially-copyable handles** where the container manages lifetime (e.g., the OpenGL handle is an `unsigned int`, not a real pointer, but the same pattern applies).
> - **Inside smart pointer implementations.** Someone has to call `delete`.
>
> Where they don't belong: anywhere ownership is implied. **A raw pointer should never own** in modern C++. If you see `delete p` outside a class destructor, it's almost certainly a bug waiting to happen.

> **⚠️ Pitfall — `NULL` vs `nullptr`:**
> ```cpp
> void f(int);
> void f(char*);
>
> f(NULL);     // CALLS f(int) — NULL is a macro that expands to 0 (int!) on most platforms
> f(nullptr);  // CALLS f(char*) — nullptr is properly typed
> ```
> A `NULL`-using codebase from 1998 will have subtle bugs around overloaded functions taking int vs pointer. Always migrate to `nullptr`.

## 22. Dynamic Memory: `new` / `delete` / `delete[]`
*(Ep. 25)*

`new` allocates on the **heap** and returns a pointer; `delete` deallocates.

```cpp
int* one = new int(42);      // single object
delete one;
one = nullptr;

int* arr = new int[100]{};   // 100 ints, value-initialized to 0
delete[] arr;                 // MUST be delete[] for arrays
```

**Match `new` ↔ `delete` and `new[]` ↔ `delete[]`** strictly. Mismatching is undefined behavior.

**Memory leak** — every `new` that is not matched with a `delete` causes a leak: that memory is allocated, never freed, and accumulates for the lifetime of the process. In long-running programs or loops, this is catastrophic.

```cpp
// Leak example — every loop iteration allocates and abandons
for (int i = 0; i < 1000; ++i) {
    int* p = new int(i);   // forgot delete p; → 1000 leaks
}
```

**Key runtime benefit of heap** — unlike stack arrays, heap arrays can be sized at runtime:

```cpp
int n;
std::cin >> n;
int* buf = new int[n]{};   // size determined at runtime — impossible on stack
delete[] buf;
```

Stack vs heap, in one table:

| | Stack | Heap |
|---|-------|------|
| Allocation | Implicit at scope entry | Explicit (`new`) |
| Deallocation | Automatic at scope exit | Explicit (`delete`) |
| Speed | Very fast (move SP) | Slower (allocator bookkeeping) |
| Size | Limited (~1–8 MiB/thread) | Large (gigabytes) |
| Lifetime | Tied to scope | Until you `delete` |

Modern guidance: **almost never write raw `new`/`delete` in application code.** Use `std::vector`, `std::unique_ptr`, `std::make_shared`, etc. Raw `new` survives in low-level code that builds these abstractions.

> **🏭 Industry Note — Real-world memory leak detection:**
> - **Local dev:** AddressSanitizer (`-fsanitize=address`) catches ~95% of leaks with stack traces. Runtime overhead ~2×.
> - **CI:** every test target runs with ASan + UBSan; a leak fails the build.
> - **Production:** **heaptrack** (Linux), **MallocStackLogger** (macOS), or **HeapAlloc tracing** (Windows) for periodic profiling.
> - **Long-running services** (Chrome, MySQL): teams ship with `tcmalloc` or `jemalloc` and use built-in profiling endpoints.
>
> Most leaks in modern C++ code are *not* missing `delete` calls — they're cycles in `shared_ptr` (§31), accidental retention in caches/maps, or memory tied to thread-local state that never gets freed.

> **🔬 Under the Hood — Stack vs heap allocation cost:**
> - **Stack alloc:** ~1 ns. Just decrement the stack pointer; no bookkeeping.
> - **Heap alloc (small):** ~20-50 ns with modern allocators. Looks in thread-local cache, falls back to global pools.
> - **Heap alloc (large, > 128 KiB)**: 1+ μs. May call `mmap` (Linux) which is a system call.
> - **Heap alloc + free pair:** dominates in tight loops; can be the entire bottleneck.
>
> This is why "avoid allocations in the hot path" is the #1 rule of game engines, HFT systems, and embedded code. `std::vector::reserve()` pre-allocates; pooled allocators recycle; `std::pmr` (C++17) lets you use a custom allocator without templating your container type.

> **⚠️ Pitfall — `new[]` and `delete[]` must match:**
> ```cpp
> int* arr = new int[10];
> delete arr;        // UB! Should be delete[] arr;
>
> int* one = new int;
> delete[] one;      // UB! Should be delete one;
> ```
> Mismatching is **undefined behavior** — usually a crash, sometimes silent heap corruption that surfaces minutes later in unrelated code. The fix is to never use `new[]` directly — use `std::vector<int>` or `std::make_unique<int[]>(10)` instead.

## 23. Pointer Arithmetic and Array Offsets
*(Ep. 26)*

Adding to a pointer advances by the size of the pointed-to type:

```cpp
int a[5] = {10, 20, 30, 40, 50};
int* p = a;                // p points to a[0]

std::cout << *(p + 0);     // 10
std::cout << *(p + 2);     // 30 — advanced by 2*sizeof(int) bytes
std::cout << p[2];          // 30 — same thing
```

The bracket form `p[i]` is *defined* as `*(p + i)`. That's why `arr[i]` works the same on raw arrays and pointers — and why `0[arr]` compiles (don't write that).

```cpp
int a[3] = {1, 2, 3};
std::cout << 1[a];         // 2 — yes, really. Don't ever do this.
```

## 24. `sizeof` Pitfalls
*(Ep. 27)*

`sizeof` reports the size of a *type*, not the contents. It's a compile-time operator.

```cpp
int    a[10];
char   buf[256];
std::vector<int> v(1000);

sizeof(a);      // 40 (10 ints × 4 bytes)
sizeof(buf);    // 256
sizeof(v);      // sizeof(std::vector<int>) — NOT 4000!
                // It's just the size of the vector control block.
```

**Classic traps:**

```cpp
// Trap 1 — array passed to function
void bad(int arr[]) {
    std::cout << sizeof(arr);     // sizeof(int*) = 8, NOT the array byte count
}

// Trap 2 — dynamic allocation
int* p = new int[100];
std::cout << sizeof(p);          // 8 (pointer size), NOT 400

// Trap 3 — STL container
std::vector<int> v(1000);
std::cout << sizeof(v);          // ~24 bytes (the vector control block), NOT 4000
                                 // Use v.size() for element count
```

Safe idioms:

```cpp
int a[5];
// Stack-allocated array: ratio trick works only in the declaring scope
std::cout << sizeof(a) / sizeof(a[0]);   // 5

// C++17 std::size() handles both raw arrays and containers correctly
std::cout << std::size(a);               // 5
std::cout << std::size(v);               // 1000 (calls v.size() internally)
```

## 25. Array Decay; Prefer `std::vector`
*(Ep. 28)*

When a raw array is passed to a function, it **decays** to a pointer to its first element. The size is gone.

```cpp
void f(int arr[10]) {            // misleading — the [10] is ignored
    // arr has type int*, not int(*)[10]
}
```

Three modern alternatives, in order of preference:

```cpp
// 1) std::vector — owns its memory, dynamic size, decay-free
void take(const std::vector<int>& v);

// 2) std::span (C++20) — non-owning view; takes vectors, arrays, raw buffers
#include <span>
void take(std::span<const int> s);

// 3) Template — accept any contiguous-ish range
template <typename Range>
void take(const Range& r);
```

`std::span<const int>` is the right choice when you want "a function that reads any contiguous int sequence." Section 111 covers `std::span` in depth.

## 26. Pointer Pitfalls + AddressSanitizer + GDB
*(Ep. 29)*

The classic raw-pointer crimes:

| Pitfall | Symptom |
|---------|---------|
| **Memory leak** | Forgot to `delete`; allocations grow forever |
| **Double free** | `delete` twice; corrupts the allocator |
| **Dangling pointer** | Use after `delete`; reads/writes some other object |
| **Use-after-free** | Same as above |
| **Null deref** | `*nullptr` → SIGSEGV |
| **Buffer overrun** | Write past `arr[N-1]`; corrupts neighbor memory |
| **Uninitialized read** | Read a pointer before assigning; garbage address → crash |

### Tools that catch these

**AddressSanitizer (ASan)** — compile with `-fsanitize=address` and run normally. Detects use-after-free, heap-buffer-overflow, stack-buffer-overflow, double-free, and leaks at runtime with stack traces.

```bash
g++ -std=c++23 -g -O1 -fsanitize=address,undefined buggy.cpp -o buggy
./buggy
```

**GDB** — interactive debugger. Indispensable.

```bash
g++ -g -O0 prog.cpp -o prog
gdb ./prog
(gdb) break main
(gdb) run
(gdb) print *p
(gdb) backtrace
```

**Valgrind** — memory error detector and profiler. Slower than ASan but catches more categories (e.g., still-reachable leaks) and doesn't require recompilation.

```bash
valgrind --leak-check=full ./prog
```

In production code: enable warnings (`-Wall -Wextra`), run sanitizers in CI, and use smart pointers (§29–31). The fix isn't to be careful; the fix is to remove the opportunity to be wrong.

## 27. lvalues, rvalues, and References
*(Ep. 31)*

Every expression has a **type** *and* a **value category**. The fundamentals:

- **lvalue** — has identity (a name, an address); persists.
- **rvalue** — temporary; doesn't have a stable address.

```cpp
int x = 10;             // x is an lvalue
int y = x + 1;          // x+1 is an rvalue (temporary)
int& lref = x;          // lvalue reference — only binds to lvalues
int&& rref = 10;        // rvalue reference — only binds to rvalues
const int& cref = 10;   // const lvalue ref — special: also binds to rvalues
```

Reference-binding rules:

| | Binds to lvalue | Binds to rvalue |
|---|------------|------------|
| `T&`        | ✅ | ❌ |
| `const T&`  | ✅ | ✅ |
| `T&&`       | ❌ | ✅ |

The point of distinguishing them: rvalues are temporaries you can **steal from** without anyone noticing. That's how move semantics (next section) works.

## 28. `std::move`
*(Ep. 32)*

`std::move` is a `static_cast` that converts an lvalue to an rvalue reference, signaling "this object's contents may be stolen." It does not, by itself, move anything.

```cpp
#include <utility>
#include <string>
#include <iostream>

int main() {
    std::string s1 = "expensive contents we don't want to copy";
    std::string s2 = std::move(s1);            // s2 steals s1's buffer

    std::cout << "s2: " << s2 << '\n';         // expensive contents...
    std::cout << "s1: " << s1 << '\n';         // valid but unspecified — usually empty
}
```

What "valid but unspecified" means:
- You can call any operation that has no preconditions (e.g. `s1.clear()`, `s1 = "new"`, `s1.size()`).
- You should not assume specific contents.
- You can safely destroy `s1` (its destructor still runs cleanly).

### When `std::move` actually pays off

- **Returning large objects** — most of the time the compiler does it automatically (RVO/NRVO; section 19 of original guide), so don't `return std::move(x);` — that *prevents* NRVO.
- **Inserting into containers** — `vec.push_back(std::move(local))` instead of `push_back(local)` to avoid a copy.
- **Move constructors / assignment operators** — covered in Rule of 5 (section 48).

## 29. `std::unique_ptr` (and Custom Deleters)
*(Eps. 33, 82)*

`std::unique_ptr<T>` is a smart pointer with **exclusive ownership**. When it goes out of scope, the object is destroyed. It is move-only (cannot be copied).

```cpp
#include <memory>
#include <iostream>

struct Connection {
    Connection()  { std::cout << "open\n"; }
    ~Connection() { std::cout << "close\n"; }
    void send()   { std::cout << "send\n"; }
};

int main() {
    auto c = std::make_unique<Connection>();   // preferred over new
    c->send();

    auto c2 = std::move(c);                     // ownership transferred; c is now nullptr
    // c->send();   // would crash — c is empty
    c2->send();
}                                                // c2 destroyed here → Connection destroyed
```

Properties:
- Zero overhead vs raw pointer (typically `sizeof(T*)`).
- `make_unique<T>(args...)` is exception-safe; prefer it over `new`. (Note: `make_unique` does not support custom deleters — use `unique_ptr{new T(...), deleter}` form for those.)
- **Move-only** — the copy constructor and copy assignment operator are `= delete`. Attempting to copy fails at compile time, forcing you to be explicit about ownership transfer with `std::move`.
- Unique ownership prevents double-free and dangling: only one pointer ever owns the resource.

> **🎯 Mental Model — `unique_ptr` is a Rust `Box<T>`:**
> If you've used Rust, `std::unique_ptr<T>` is essentially `Box<T>`. One owner, move semantics enforced at compile time, automatically dropped at scope exit. The difference: Rust enforces it globally via the borrow checker; C++ enforces it locally — you can still take a raw `T*` from `unique_ptr::get()` and outlive the owner if you're careless.

> **🏭 Industry Note — Ownership patterns:**
> - **Factory functions return `unique_ptr<T>`:** clear "I made this, you own it now."
> - **Functions accept `T*` (or `T&`) when they don't own:** "I'm just looking; not my problem when it dies."
> - **Functions accept `unique_ptr<T>` (by value) when they take ownership:** the caller's variable becomes null after the call.
> - **Functions accept `unique_ptr<T>&` rarely** — usually a smell. If you need to swap inside, fine; otherwise pass `T*` or `T&`.

> **✅ Decision Rule — Smart pointer pick chart:**
> ```
> Does the resource have exactly one owner at any time?
>   ├── Yes → std::unique_ptr<T>
>   └── No, multiple owners share lifetime
>       ├── Are there cycles? → std::shared_ptr<T> + std::weak_ptr<T> for back-edges
>       └── No cycles → std::shared_ptr<T>
> Are you observing without owning?
>   ├── Tied to a shared_ptr → std::weak_ptr<T>
>   └── Lifetime guaranteed by some other means → raw T* or T&
> ```
> **Default to `unique_ptr` until you have a concrete reason for `shared_ptr`.** Shared ownership is expensive (atomic ref counts) and complicates reasoning about lifetimes.

### Custom Deleter
*(Ep. 82)*

For C-API handles, a custom deleter ties cleanup to scope.

```cpp
#include <cstdio>
#include <memory>

auto file_closer = [](FILE* f) { if (f) std::fclose(f); };
std::unique_ptr<FILE, decltype(file_closer)> file{
    std::fopen("data.bin", "rb"),
    file_closer
};

if (file) {
    // use file.get() to access the FILE*
}                                                // fclose called automatically
```

This is the universal pattern for wrapping `pthread_t`, `int` socket fds, OpenSSL handles, OpenGL resources — anything with paired acquire/release.

## 30. `std::shared_ptr`
*(Ep. 34)*

Shared ownership via **reference counting**. Many `shared_ptr`s can point to the same object; the object is destroyed when the last one goes away.

```cpp
#include <memory>

auto p1 = std::make_shared<int>(42);            // ref count = 1
{
    auto p2 = p1;                                // ref count = 2
    *p2 = 100;
}                                                // p2 destroyed; ref count = 1
// p1 destroyed → int deleted
```

What's actually allocated:
- A **control block** (atomic strong/weak counts).
- The managed object.

`std::make_shared<T>(args...)` puts both in a single allocation and is preferred. Constructing from a raw `new` is two allocations and harder for the compiler to optimize.

Cost vs `unique_ptr`:
- `sizeof(shared_ptr) ≈ 2 * sizeof(void*)`.
- Atomic increments/decrements on copy/destroy — not free, especially under contention.
- Use `unique_ptr` by default; reach for `shared_ptr` only when ownership is genuinely shared (graphs, caches).

> **🔬 Under the Hood — The control block and `make_shared` optimization:**
> ```cpp
> auto p = std::shared_ptr<T>(new T(...));   // TWO allocations: control block + T
> auto q = std::make_shared<T>(...);         // ONE allocation: control block AND T together
> ```
> `make_shared` packs both into a single heap block — faster allocation, better cache behavior, one fewer indirection. Always prefer it... **except** when:
> - You need a custom deleter (`make_shared` doesn't support them).
> - You have a `std::weak_ptr` that may outlive the last `shared_ptr` AND `T` is large — the `T` storage can't be freed until the last `weak_ptr` dies (because both share one allocation). For large `T` with long-lived weak refs, two allocations is the lesser evil.

> **🏭 Industry Note — `shared_ptr` is contagious and often a smell:**
> Teams often start with `shared_ptr` because "I'll figure out ownership later." It compiles, ships, and then:
> - Ref counts add atomic ops on every copy (cache-line ping-pong under contention).
> - Lifetimes become opaque ("when does this die? whenever the last one drops it... somewhere").
> - Cycles leak silently.
> - You discover three months later that 80% of objects have ref count 1 forever (could have been `unique_ptr`).
>
> **Practical rule:** in code review, every new `shared_ptr` should justify why `unique_ptr` won't work.

## 31. `std::weak_ptr`
*(Ep. 35)*

A `weak_ptr` is a non-owning observer of a `shared_ptr`-managed object. It does not keep the object alive.

```cpp
#include <memory>
#include <iostream>

int main() {
    std::shared_ptr<int> sp = std::make_shared<int>(42);
    std::weak_ptr<int>    wp = sp;

    if (auto locked = wp.lock()) {        // try to promote to shared_ptr
        std::cout << *locked << '\n';      // 42
    }

    sp.reset();                            // last shared_ptr gone; object destroyed

    if (auto locked = wp.lock()) {
        std::cout << "alive\n";
    } else {
        std::cout << "expired\n";          // expired
    }
}
```

The classic use case is **breaking cycles** in shared-ownership graphs:

```cpp
struct Node {
    std::shared_ptr<Node> next;
    std::weak_ptr<Node>   prev;     // would leak if this were shared_ptr
};
```

Without `weak_ptr`, two nodes pointing at each other with `shared_ptr` keep each other alive forever.

## 32. RAII
*(Ep. 45)*

**Resource Acquisition Is Initialization** is the single most important idiom in C++. The pattern:

> Bind acquisition of a resource to construction of an object; bind release to destruction.

Because C++ guarantees deterministic destruction at scope exit (even during exception unwinding), resources never leak.

```cpp
#include <fstream>

void process(const std::string& path) {
    std::ifstream f(path);             // file opened by ctor
    if (!f) throw std::runtime_error("open failed");

    std::string line;
    while (std::getline(f, line)) {
        // ... may throw here ...
    }
}                                       // f.close() called by ~ifstream — always
```

Every standard-library resource type uses this idiom: `unique_ptr`, `shared_ptr`, `vector`, `string`, `lock_guard`, `ifstream`, `ofstream`, …

For a custom RAII wrapper around a C handle (POSIX file descriptor, SDL window, etc.):

```cpp
#include <unistd.h>
#include <utility>

class Fd {
    int fd_ = -1;
public:
    explicit Fd(int fd) noexcept : fd_(fd) {}
    ~Fd()                    noexcept { if (fd_ >= 0) ::close(fd_); }

    Fd(const Fd&)            = delete;
    Fd& operator=(const Fd&) = delete;

    Fd(Fd&& o) noexcept : fd_(o.fd_) { o.fd_ = -1; }
    Fd& operator=(Fd&& o) noexcept {
        if (this != &o) {
            if (fd_ >= 0) ::close(fd_);
            fd_ = std::exchange(o.fd_, -1);
        }
        return *this;
    }

    int get() const noexcept { return fd_; }
};
```

This pattern is at the heart of every robust C++ system you've used.

> **🎯 Mental Model — RAII is exception-safe resource management:**
> Other languages handle resources with `try/finally` blocks (Java), `using` statements (C#), or `with` blocks (Python). All of them require the *user* to remember to wrap acquisition. C++ RAII pushes this discipline into the *type* — once you have a `std::lock_guard`, you literally cannot forget to unlock; the destructor runs at scope exit, even during exception propagation.
>
> This is C++'s **superpower** over most other languages: deterministic destruction. Python's `__del__` doesn't run when you expect; Java finalizers are deprecated for being unreliable; Go has `defer` which works but is per-function. C++ destructors run *exactly when the object goes out of scope*, no GC needed.

> **🏭 Industry Note — RAII wrappers as defensive engineering:**
> Every C library you wrap should get a thin RAII type:
> ```cpp
> // FILE* → RAII
> using FilePtr = std::unique_ptr<FILE, decltype(&std::fclose)>;
> FilePtr f{std::fopen("x", "r"), &std::fclose};
>
> // SQLite handle → RAII
> class SqliteDb {
>     sqlite3* db_ = nullptr;
> public:
>     explicit SqliteDb(const char* path) { sqlite3_open(path, &db_); }
>     ~SqliteDb()                          { if (db_) sqlite3_close(db_); }
>     // delete copy, default move
> };
>
> // POSIX thread → RAII (std::jthread in C++20 does this for you)
> class Thread {
>     pthread_t t_;
> public:
>     ~Thread() { pthread_join(t_, nullptr); }
> };
> ```
> The first thing senior engineers do in a new codebase is grep for naked `new`, `pthread_create`, `fopen` without matching RAII wrappers — those are bug factories.

## 33. The `static` Keyword
*(Ep. 69)*

`static` is overloaded with three meanings depending on context. Each affects either **storage duration** or **linkage**.

### Memory regions, briefly:

| Region | Storage duration | Initialized when |
|--------|------------------|------------------|
| Stack | Automatic (scope) | When scope is entered |
| Heap | Dynamic | When `new` runs |
| Static / global | Static (whole program) | Before `main` (for globals) or first call (function-local statics) |

### `static` in three places:

```cpp
// 1. At namespace scope — internal linkage (only visible in this TU).
static int s_global = 0;

// 2. Inside a function — local variable with static storage duration.
//    Initialized on first call; survives across calls.
int next_id() {
    static int counter = 0;       // initialized once; thread-safe since C++11
    return ++counter;
}

// 3. Inside a class — covered in section 69.
class Logger {
    static int s_count;            // one shared instance for all objects
};
```

Function-local statics are a clean way to implement **lazy singletons** and amortized caches without manual init.

## 34. Perfect Forwarding / Universal References
*(Ep. 225)*

A function template can accept *any* argument and forward it to another function while preserving its value category (lvalue vs rvalue).

```cpp
#include <utility>
#include <iostream>

void process(int& x)  { std::cout << "lvalue\n"; }
void process(int&& x) { std::cout << "rvalue\n"; }

template <typename T>
void wrapper(T&& arg) {                   // T&& with deduced T = forwarding reference
    process(std::forward<T>(arg));         // preserves lvalue/rvalue-ness
}

int main() {
    int x = 1;
    wrapper(x);     // calls process(int&)
    wrapper(42);    // calls process(int&&)
}
```

Three requirements for perfect forwarding to work:
1. The function must be a **template function**.
2. The parameter must use **`T&&`** with the deduced template parameter.
3. You must call `std::forward<T>(arg)` — not `std::move`, not bare `arg`.

Key terminology:
- **Forwarding reference** (a.k.a. universal reference): `T&&` where `T` is a deduced template parameter. It binds to both lvalues and rvalues.
- **`std::forward<T>`** — the conditional cast that preserves value category.
- **Reference collapsing** — when `&` and `&&` combine, the result follows: `& &` → `&`, `& &&` → `&`, `&& &` → `&`, `&& &&` → `&&`. This is what makes forwarding work.

> **Common mistake:** `void f(int&& x)` is an rvalue reference, NOT a forwarding reference. The `T&&` syntax is only a forwarding reference when `T` is a deduced template parameter. This trips up many C++ programmers.

You'll see this pattern everywhere in modern C++: `make_unique`, `make_shared`, `emplace_back`, `std::function`, factory functions, signal/slot frameworks.

```cpp
template <typename T, typename... Args>
std::unique_ptr<T> my_make_unique(Args&&... args) {
    return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
}
```

> **🎯 Mental Model — Why "perfect forwarding" exists:**
> Without it, a generic factory like `make_unique` would need to write 2ⁿ overloads (each parameter is either lvalue or rvalue). For 5 parameters → 32 overloads. Perfect forwarding collapses that to a single template that preserves the value category of each argument as it passes through.

> **🏭 Industry Note — Common forwarding patterns in modern libraries:**
> - `std::vector::emplace_back(args...)` — constructs T in place, no temporary copy.
> - `std::make_unique<T>(args...)` — forwards constructor args.
> - `std::thread(fn, args...)` — forwards function arguments to the new thread.
> - `std::function<R(Args...)>` — forwarding-based type erasure.
>
> You'll write your own forwarding wrappers often — any time you build a factory, a thread pool task queue, a generic wrapper around an existing API.

---

# Part IV — Build Model & Tooling

## 35. Header (`.hpp`) vs Implementation (`.cpp`)
*(Ep. 36)*

C++ separates **declaration** (in headers) from **definition** (in source files). Why:

1. **Separate compilation** — each `.cpp` compiles to a `.o` independently; linker stitches them. Editing one `.cpp` recompiles only that file.
2. **Information hiding** — clients see only the API surface in the header.
3. **Smaller compile times at scale.**

```cpp
// ── math.hpp ─────────────────────────────
#pragma once                       // (or classic include guards)

namespace mm {
    int add(int a, int b);          // declaration only

    inline int square(int x) {       // inline → may be defined in header
        return x * x;
    }
}

// ── math.cpp ─────────────────────────────
#include "math.hpp"

namespace mm {
    int add(int a, int b) { return a + b; }
}

// ── main.cpp ─────────────────────────────
#include "math.hpp"
#include <iostream>

int main() { std::cout << mm::add(2, 3) << '\n'; }
```

**Rules:**
- `#include "..."` for project headers; `#include <...>` for system / library headers.
- Templates, `inline` functions, `inline` variables, and `constexpr` constants go in headers (their definitions need to be visible at the point of instantiation/use).
- Non-`inline`, non-template definitions go in `.cpp` (or you'll get "multiple definition" errors).
- **Never `#include` a `.cpp`** — that's how you get linker mayhem.

Classic include guards still work everywhere:
```cpp
#ifndef MM_MATH_HPP
#define MM_MATH_HPP
// ...
#endif
```

> **🏭 Industry Note — Header organization at scale:**
> - **Public vs private headers:** put public API in `include/myproject/foo.hpp`, private internals in `src/internal/foo_impl.hpp`. Build system installs only `include/`.
> - **Include-what-you-use** (IWYU): a tool that finds unnecessary `#include` directives and missing forward-declarable ones. Run periodically; cuts compile times.
> - **Include order convention** (Google style):
>   1. The matching header for this `.cpp` (forces it to be self-contained).
>   2. C system headers (`<stdio.h>`).
>   3. C++ system headers (`<vector>`).
>   4. Other libraries (`<boost/...>`).
>   5. Your project's headers.
>   Separate each group with a blank line. clang-format enforces this automatically.
> - **Avoid umbrella headers** like `<bits/stdc++.h>` (GCC-specific anyway) — they multiply compile time.

> **🎯 Mental Model — Headers are NOT files, they're text snippets:**
> `#include "foo.hpp"` literally pastes `foo.hpp`'s contents at that point. The compiler sees one giant preprocessed file ("translation unit") per `.cpp`. Anything you put in a header is duplicated into every `.cpp` that includes it — which is why headers should be lean, contain only declarations + `inline`/`template` definitions, and use include guards.

> **⚠️ Pitfall — Header self-containment:**
> A header that uses `std::string` but doesn't `#include <string>` works *as long as the caller happens to include `<string>` first*. The first file to break this pattern fails mysteriously. Rule: **every header must `#include` what it uses**, even if it seems redundant.

## 36. Macros, `__LINE__`, `std::source_location`
*(Ep. 107)*

The preprocessor runs *before* compilation. Directives start with `#`.

```cpp
#define PI 3.14159           // textual replacement — avoid; prefer constexpr

#ifdef DEBUG
    #define LOG(x) std::cerr << x << '\n'
#else
    #define LOG(x) ((void)0)
#endif
```

### Built-in predefined macros

```cpp
std::cout << __FILE__ << ':' << __LINE__ << " in " << __func__ << '\n';
```

### `std::source_location` (C++20)

A modern, type-safe replacement that captures location info as a function-default argument:

```cpp
#include <source_location>
#include <iostream>
#include <string_view>

void log(std::string_view msg,
         std::source_location loc = std::source_location::current())
{
    std::cout << loc.file_name() << ':' << loc.line()
              << " (" << loc.function_name() << "): " << msg << '\n';
}

int main() {
    log("starting up");        // file/line/function captured automatically
}
```

Why prefer it over `__LINE__`:
- No macros — works correctly with namespaces, templates, and overload resolution.
- Composable with default arguments.
- Standard, portable, type-checked.

## 37. Command-Line Arguments
*(Ep. 104)*

`main` may take two parameters:

```cpp
int main(int argc, char* argv[]) { /* ... */ }
```

- `argc` — number of arguments **including** the program name.
- `argv` — array of C-strings; `argv[0]` is the program path.

```cpp
#include <iostream>
#include <span>
#include <string_view>

int main(int argc, char* argv[]) {
    std::span<char*> args(argv, argc);

    std::cout << "program: " << args[0] << '\n';
    for (std::size_t i = 1; i < args.size(); ++i) {
        std::string_view a = args[i];
        std::cout << "arg " << i << ": " << a << '\n';
    }
}
```

For environment variables, use `std::getenv("HOME")` from `<cstdlib>` (some systems also expose a third `envp` parameter to `main`, but it's nonstandard).

For non-trivial CLIs, reach for a parser library: **CLI11**, **cxxopts**, **argparse**.

## 38. The `using` Keyword
*(Ep. 80)*

`using` has multiple jobs:

### 1. Bring names into scope

```cpp
#include <iostream>

using std::cout;            // bring just one name in
using namespace std;        // bring everything (avoid in headers / global scope)

int main() { cout << "hi\n"; }
```

**Don't `using namespace std;` in a header file.** It pollutes every translation unit that includes it.

### 2. Type aliases (preferred over `typedef`)

```cpp
using Bytes  = std::vector<std::byte>;
using Pred   = std::function<bool(int)>;

// Templates can be aliased — typedef can't do this:
template <typename T>
using Vec = std::vector<T>;

Vec<int> v = {1, 2, 3};
```

### 3. Inheriting constructors

```cpp
class Derived : public Base {
public:
    using Base::Base;          // inherit all of Base's constructors
};
```

### 4. Bringing inherited overloads into scope

```cpp
class Base { public: void f(int); };
class Derived : public Base {
public:
    using Base::f;              // expose Base::f alongside our own f
    void f(double);
};
```

## 39. Effective Compiler Flags & Style Guides
*(Ep. 85)*

A modest set of warnings catches a surprising amount of bad code.

```bash
g++ -std=c++23 \
    -Wall -Wextra -Wpedantic \
    -Wshadow -Wconversion -Wold-style-cast \
    -Wnon-virtual-dtor -Woverloaded-virtual \
    -Weffc++ \                          # Scott Meyers' Effective C++ checks (Ep. 80)
    -Werror \                            # treat warnings as errors in CI
    -O2 -g \
    file.cpp -o file
```

`-Weffc++` flags issues like classes managing pointers without explicit copy ctor / assignment, missing initialization in member init lists, etc. It's noisy but educational.

### Style guides (Ep. 85)

- **C++ Core Guidelines** — [github.com/isocpp/CppCoreGuidelines](https://github.com/isocpp/CppCoreGuidelines). Authoritative; massive.
- **Google C++ Style** — pragmatic; some restrictions (no exceptions in some legacy code) reflect Google's specific situation.
- **LLVM Coding Standards** — what LLVM/Clang itself uses.

Pick one, stick to it, automate it with **clang-format** and **clang-tidy**.

> **🏭 Industry Note — Build systems in 2026:**
> | Build System | Used by | Best for |
> |---|---|---|
> | **CMake** | Most OSS, ROS, Qt, Google | Cross-platform; tooling everywhere; verbose syntax |
> | **Bazel** | Google, Uber, Dropbox, LinkedIn | Hermetic, reproducible, massive monorepos; steep learning curve |
> | **Meson** | GNOME, systemd | Pythonic, fast; Ninja backend |
> | **Buck2** | Meta | Like Bazel but newer/faster |
> | **Make** | Old projects, embedded | Simple, fragile |
> | **MSBuild / VS solutions** | Windows-only shops | Tightly integrated with Visual Studio |
> | **xcodebuild** | Apple platforms | Required for iOS/macOS apps |
>
> **CMake is the safe default** for greenfield C++ in 2026. Use **CMake 3.20+** and write "modern CMake" (target-based, no `include_directories`/`add_definitions` globals). The book *Professional CMake* by Craig Scott is the standard reference.

> **🏭 Industry Note — CI essentials for C++ projects:**
> A modern C++ CI pipeline runs at minimum:
> 1. **Build matrix:** GCC and Clang, Debug and Release, latest two standards.
> 2. **Sanitizers:** ASan + UBSan in one job; TSan in another (if multithreaded).
> 3. **Static analysis:** clang-tidy with a curated set of checks.
> 4. **Code coverage:** llvm-cov / gcov, posted to Codecov.
> 5. **Formatting check:** `clang-format --dry-run --Werror`.
> 6. **Tests:** GoogleTest / Catch2 / doctest. Aim for fast unit tests + slower integration tests in separate stages.
> 7. **(Optional) fuzzing:** libFuzzer or AFL++ for parsers, network code.
>
> GitHub Actions, GitLab CI, and Jenkins all support this; the Microsoft `cpp-build-action` is a turnkey starter.

---


# Part V — Classes and Object-Oriented Programming

This part is the longest in the playlist (Eps. 37–70 plus refinements at 90, 98, 101, 203). I've tried to keep each section tight and matched to its episode.

## 40. Class Introduction
*(Ep. 37)*

A class is a user-defined type that bundles **data** (members) and **operations** (member functions). C++ has both `class` and `struct`; the only language-level difference is the default access (`private` vs `public`).

```cpp
class Sensor {
    std::string name_;             // data members (private by default)
    double      reading_ = 0.0;
public:
    Sensor(std::string n) : name_(std::move(n)) {}
    void   set(double v)        { reading_ = v; }
    double get() const          { return reading_; }
    const std::string& name() const { return name_; }
};
```

Convention: trailing-underscore on private data members keeps them visually distinct. Members default to `private`; `public:` exposes the API surface.

> **🎯 Mental Model — A class is an invariant guard:**
> The whole point of `private` is that **the class controls when its data changes**, and therefore can guarantee invariants. If `Sensor::reading_` is private, no external code can set it to `NaN` or `-1`; the `set(double v)` method can validate first. Without `private`, you have a struct, and you have to trust every caller to maintain invariants — at scale this becomes impossible.
>
> This is why "make all fields public for convenience" is a junior mistake: you've thrown away the only language feature that lets you enforce a class's invariants.

> **🏭 Industry Note — Naming conventions for class members:**
> | Style | Example | Used by |
> |---|---|---|
> | Trailing underscore | `name_`, `count_` | Google, this guide |
> | Leading `m_` | `m_name`, `m_count` | Unreal, much game dev |
> | Leading underscore | `_name` | Rare; reserved by spec for impl in some contexts |
> | No prefix | `name`, `count` | Bjarne's style; clean but collides with parameters |
>
> Whatever you pick, **be consistent across the codebase**. clang-format and clang-tidy can enforce.

> **⚖️ Tradeoff — `struct` vs `class`:**
> The only language-level difference: `struct` defaults to public, `class` to private. Conventionally:
> - **`struct`** for "passive data" — points, headers, tuples, records. All public, few/no methods.
> - **`class`** for "active objects with invariants" — anything that hides state.
>
> Both are interchangeable; pick by intent at the declaration site to communicate the role.

## 41. Default Constructor & Default Destructor
*(Ep. 38)*

If you don't write any constructors, the compiler synthesizes a **default constructor** (no args). It default-initializes each member.

```cpp
class Point {
public:
    int x;       // primitive — left UNINITIALIZED by the synthesized default ctor
    int y;
};

Point p;          // p.x and p.y are indeterminate
```

If *any* constructor is user-defined, the compiler stops generating the default. You can ask for it back with `=default`:

```cpp
class Point {
public:
    Point(int x, int y) : x_(x), y_(y) {}
    Point() = default;             // explicitly request the default ctor

private:
    int x_{};                       // default-member-initializer (section 64)
    int y_{};
};
```

The **destructor** runs at object end-of-life. The synthesized destructor calls each member's destructor in reverse declaration order. You write a destructor only when you need custom cleanup.

## 42. Copy Constructor and Copy Assignment (Deep vs Shallow)
*(Ep. 39)*

```cpp
struct Box {
    Box(const Box& other);              // copy constructor
    Box& operator=(const Box& other);   // copy assignment
};
```

The compiler's default copy is a **member-wise copy** — fine for scalar fields, dangerous when you own a raw pointer:

```cpp
class Buf {
    int*        data_;
    std::size_t n_;
public:
    Buf(std::size_t n) : data_(new int[n]), n_(n) {}
    ~Buf() { delete[] data_; }
    // Default copy ctor copies data_ as a pointer — both objects point to the same buffer!
    // When the second one is destroyed → double free.
};
```

Two ways to copy a pointer-owning object:

- **Shallow copy** — copy the pointer value. Cheap, but creates aliasing and double-free hazards.
- **Deep copy** — allocate a new buffer and copy the contents. Correct, but expensive.

```cpp
Buf(const Buf& other)
    : data_(new int[other.n_]), n_(other.n_)
{
    std::copy(other.data_, other.data_ + n_, data_);
}

Buf& operator=(const Buf& other) {
    if (this != &other) {                          // self-assignment guard
        int* tmp = new int[other.n_];               // allocate first (exception safe)
        std::copy(other.data_, other.data_ + other.n_, tmp);
        delete[] data_;
        data_ = tmp;
        n_    = other.n_;
    }
    return *this;
}
```

Better: use **copy-and-swap** (next section), or sidestep the problem entirely by using `std::vector` instead of `int*` (Rule of 0).

## 43. Rule of 3 (and the Law of the Big Two)
*(Ep. 40)*

> If a class needs a custom **destructor**, it almost certainly needs a custom **copy constructor** and **copy assignment operator** too — and vice versa.

That's the Rule of 3. It exists because raw resource ownership comes with three matching responsibilities: cleanup, copy, and assign.

The **Law of the Big Two** says: if you implement copy, you essentially get the destructor's logic for free as part of `operator=`'s cleanup, so usually the only special members worth distinguishing are copy and copy-assign.

The cleanest implementation is **copy-and-swap**:

```cpp
class Buf {
    int*        data_ = nullptr;
    std::size_t n_    = 0;
public:
    Buf(std::size_t n) : data_(new int[n]), n_(n) {}
    ~Buf() { delete[] data_; }

    Buf(const Buf& o)
        : data_(new int[o.n_]), n_(o.n_)
    {
        std::copy(o.data_, o.data_ + n_, data_);
    }

    Buf& operator=(Buf o) {           // pass by value — copy made by caller
        swap(o);                       // swap our state with the copy
        return *this;
    }                                  // o (with our old state) destroyed here

    void swap(Buf& o) noexcept {
        std::swap(data_, o.data_);
        std::swap(n_,    o.n_);
    }
};
```

Beautiful: `operator=` is exception-safe (allocation happens during the parameter copy, before any destruction), self-assignment safe, and short.

> **🏭 Industry Note — Rule of Zero in practice:**
> The most senior advice you'll get from a modern C++ codebase reviewer:
> > "Don't write any of the Rule of 5 functions. Use member types that handle it for you."
>
> Concretely: replace raw pointers with `std::unique_ptr`, raw arrays with `std::vector`/`std::array`, raw C handles with RAII wrappers. The compiler then synthesizes correct copy/move/destroy for free. **Probably 95% of classes you write should not need any user-defined Rule of 5 functions.**
>
> The Rule of 5 only applies to *resource-owning* types — and those should be small, focused, and tested heavily. The Rule of 0 applies to *everything else*.

## 44. Avoiding Copies: `=delete`, Pass by Reference
*(Ep. 41)*

For types that own a non-copyable resource (a thread, a unique handle, a mutex), forbid copying with `=delete`.

```cpp
class Mutex {
public:
    Mutex();
    ~Mutex();

    Mutex(const Mutex&)            = delete;
    Mutex& operator=(const Mutex&) = delete;
};
```

Other techniques to avoid unnecessary copies:
- Pass by `const T&` instead of `T`.
- Return by value (RVO will usually elide the copy).
- Use `std::move` to *transfer* ownership of large objects.

## 45. Operator Overloading
*(Ep. 42)*

Define how operators behave for your types.

```cpp
#include <iostream>
#include <ostream>

class Vec2 {
public:
    double x{}, y{};

    Vec2  operator+ (const Vec2& r) const { return {x + r.x, y + r.y}; }
    Vec2& operator+=(const Vec2& r)       { x += r.x; y += r.y; return *this; }

    bool operator==(const Vec2&) const = default;     // C++20 — generates !=, ==, etc.
};

// Stream insertion as non-member (often a friend if it needs private state)
std::ostream& operator<<(std::ostream& os, const Vec2& v) {
    return os << '(' << v.x << ", " << v.y << ')';
}
```

Best practices:
- Implement compound first (`+=`), then derive binary (`+`) from it.
- Symmetric binary ops (`==`, `+`) are best as non-member functions.
- `++x` returns `T&`; `x++` returns `T` and takes a dummy `int`.
- `operator<<` returns `std::ostream&`.
- Don't overload `&&`, `||`, `,`, or `&` — short-circuiting and address semantics break.

## 46. Member Initializer Lists
*(Ep. 43)*

The list between `:` and `{` in a constructor initializes members **directly** instead of default-constructing then assigning.

```cpp
class Person {
    std::string name_;
    int         age_;
public:
    // Initializer list — preferred
    Person(std::string n, int a)
        : name_(std::move(n)), age_(a)
    {}

    // Body assignment — wasteful (default-constructs, then reassigns)
    Person(std::string n, int a) {
        name_ = std::move(n);     // string default-constructed first, then = called
        age_  = a;
    }
};
```

You **must** use the initializer list when:
- A member is `const` or a reference (no default initialization, can't be reassigned).
- A member's type lacks a default constructor.
- You need to call a base class constructor with arguments.

Order of initialization is **declaration order** in the class — not the order you write them in the list. Compilers warn (`-Wreorder`) when the two disagree.

## 47. `struct`s in C++
*(Ep. 44)*

`struct` and `class` are nearly identical. Differences:

| | `struct` | `class` |
|---|---------|---------|
| Default member access | `public` | `private` |
| Default base-class access | `public` | `private` |

Convention: use `struct` for **plain data** (POD-style aggregates with public members and no nontrivial invariants); use `class` for everything that hides state.

```cpp
struct Point { int x, y; };                        // public-by-default — fine

struct Packet {                                     // also fine — pure data
    std::uint32_t seq;
    std::uint16_t length;
    std::array<std::byte, 1500> payload;
};
```

If you find yourself making struct members private, flip it to `class`.

## 48. Rule of 5
*(Ep. 46)*

C++11 added move operations. The Rule of 3 became the **Rule of 5**: if you write any of these, write all five.

1. Destructor
2. Copy constructor
3. Copy assignment
4. Move constructor
5. Move assignment

```cpp
class Buf {
    int*        data_ = nullptr;
    std::size_t n_    = 0;
public:
    Buf(std::size_t n) : data_(new int[n]), n_(n) {}
    ~Buf() { delete[] data_; }

    Buf(const Buf& o)
        : data_(new int[o.n_]), n_(o.n_)
    { std::copy(o.data_, o.data_ + n_, data_); }

    Buf(Buf&& o) noexcept
        : data_(std::exchange(o.data_, nullptr)),
          n_   (std::exchange(o.n_,    0))
    {}

    Buf& operator=(const Buf& o) {
        if (this != &o) { Buf tmp(o); swap(tmp); }
        return *this;
    }
    Buf& operator=(Buf&& o) noexcept {
        if (this != &o) {
            delete[] data_;
            data_ = std::exchange(o.data_, nullptr);
            n_    = std::exchange(o.n_,    0);
        }
        return *this;
    }

    void swap(Buf& o) noexcept { std::swap(data_, o.data_); std::swap(n_, o.n_); }
};
```

**Mark moves `noexcept`**. STL containers (e.g. `std::vector` reallocation) check `is_nothrow_move_constructible_v<T>` — without it, they'll copy instead of move when reallocating, which is much more expensive.

### Rule of 0 (preferred)

Better than the Rule of 5: don't own raw resources at all. Hold a `std::vector`, `std::unique_ptr`, etc., and let the compiler synthesize correct copy/move/destroy for free.

```cpp
class BufZero {
    std::unique_ptr<int[]> data_;
    std::size_t            n_;
public:
    BufZero(std::size_t n)
        : data_(std::make_unique<int[]>(n)), n_(n)
    {}
    // Default-generated dtor + move ops do the right thing.
    // Copies are deleted because unique_ptr is move-only.
};
```

**Aim for Rule of 0; fall back to Rule of 5 only when you must own a raw resource.**

## 49. `friend` Functions (and Why to Avoid)
*(Ep. 47)*

A `friend` declaration grants a non-member access to the class's private parts.

```cpp
class Account {
    double balance_;
public:
    Account(double b) : balance_(b) {}

    friend std::ostream& operator<<(std::ostream& os, const Account& a) {
        return os << '$' << a.balance_;     // can read private balance_
    }
};
```

`friend` is most defensible for stream-insertion operators and a few math operators where the syntax really needs to be non-member.

**Why be wary:**
- Friendship is **not transitive** and **not inherited**, but it does break encapsulation by widening the trust boundary.
- Once you have many friends, your invariants are no longer enforced by the class alone.
- Often, a small public accessor is cleaner than a friend.

The video's advice (paraphrased): use sparingly, prefer accessors and free non-friend functions.

## 50. `explicit` Constructors and List Initialization
*(Ep. 48)*

A single-argument constructor without `explicit` is an **implicit conversion** — the compiler will use it to convert silently.

```cpp
class Distance {
public:
    Distance(double meters);   // implicit
};

void travel(Distance d);

travel(100);                    // compiles — converts 100 → Distance(100)
```

That's usually a bug. Mark single-argument (and even multi-arg with defaults) constructors `explicit`:

```cpp
class Distance {
public:
    explicit Distance(double meters);
};

travel(100);                  // ❌ won't compile
travel(Distance{100});        // ✅
```

### Brace `{}` initialization

`{}` (a.k.a. uniform / list initialization) is stricter than `()` — it disallows narrowing conversions:

```cpp
int    a = 3.7;        // OK — silently truncates to 3
int    b(3.7);         // OK — silently truncates
int    c{3.7};         // ❌ narrowing — error or warning
```

Use `{}` by default. It catches type mistakes the older syntax silently absorbs.

## 51. Inheritance Introduction
*(Ep. 49)*

Inheritance models an **is-a** relationship. A `Dog` *is an* `Animal`.

```cpp
class Animal {
public:
    void eat() { std::cout << "om nom\n"; }
};

class Dog : public Animal {        // Dog "is-an" Animal
public:
    void bark() { std::cout << "woof\n"; }
};

Dog d;
d.eat();    // inherited
d.bark();   // own
```

When a Dog is constructed, **the Animal sub-object is constructed first**, then the Dog-specific parts. Destruction is reverse: Dog parts first, then Animal.

Inheritance is powerful but easy to misuse. The first instinct of OOP-trained programmers is to reach for inheritance; the modern instinct is to reach for **composition** (section 61) and use inheritance only when you genuinely need polymorphism.

## 52. Inheritance Access Levels: `public`, `protected`, `private`
*(Ep. 50)*

The kind of inheritance affects how base members are seen by derived users.

```cpp
class B {
public:    int pub;
protected: int prot;
private:   int priv;
};

class D1 : public    B {};   // pub→public,    prot→protected, priv→inaccessible
class D2 : protected B {};   // pub→protected, prot→protected, priv→inaccessible
class D3 : private   B {};   // pub→private,   prot→private,   priv→inaccessible
```

| Inheritance | `public` of B becomes | `protected` of B becomes |
|-------------|------------------------|---------------------------|
| `public`    | `public`               | `protected`              |
| `protected` | `protected`            | `protected`              |
| `private`   | `private`              | `private`                |

`private` of B is never accessible to the derived class regardless.

- **Public inheritance** = is-a (the default for OOP polymorphism).
- **Private inheritance** = is-implemented-in-terms-of (composition usually expresses this better).
- **Protected inheritance** = rare; you almost never want it.

## 53. Inheritance Constructor Calls
*(Ep. 51)*

A derived constructor can call a specific base constructor through the member initializer list:

```cpp
class Animal {
public:
    Animal()                { std::cout << "Animal default\n"; }
    Animal(std::string n)   { std::cout << "Animal " << n << '\n'; }
};

class Dog : public Animal {
public:
    Dog()                       : Animal()       {}
    Dog(std::string n)          : Animal(n)      {}
    Dog(int unrelated)          /* default Animal() */ {}
};
```

If you don't specify, the base **default constructor** runs. If the base has no default constructor, you must call one explicitly.

You can also **inherit the base's constructors** via a using-declaration (section 38):

```cpp
class Dog : public Animal {
public:
    using Animal::Animal;        // inherit all of Animal's constructors
};

Dog d{"Rex"};                     // works — uses Animal(std::string)
```

## 54. Virtual Functions / Dynamic Dispatch
*(Ep. 52)*

A `virtual` member function may be **overridden** by a derived class. When called through a base pointer/reference, the *most-derived override* is dispatched at runtime.

```cpp
struct Shape {
    virtual double area() const { return 0.0; }
    virtual ~Shape() = default;                 // see section 55
};

struct Circle : Shape {
    double r;
    explicit Circle(double rr) : r(rr) {}
    double area() const override { return 3.14159 * r * r; }
};

void print_area(const Shape& s) {
    std::cout << s.area() << '\n';
}

Circle c{2.0};
print_area(c);        // 12.566 — dispatches to Circle::area at runtime
```

The `override` keyword (since C++11) tells the compiler "I intend to override; check that I'm matching a virtual signature." It catches typos and signature drift.

```cpp
struct Circle : Shape {
    double area() override { /*...*/ }   // ❌ missing const → won't override
};
```

> **🏭 Industry Note — Use `override` and `final` religiously:**
> ```cpp
> struct Derived : Base {
>     void f() override;          // crash early if signature drifts
>     void g() final;             // no class can override g() further
> };
>
> class LeafNode final {          // no class can derive from LeafNode
>     // devirtualization opportunity: compiler can inline virtual calls on LeafNode*
> };
> ```
> Most clang-tidy presets and Google style require `override` on every overriding function. `final` is rarer but enables compiler optimization (devirtualization) and prevents accidental subclassing.

> **🎯 Mental Model — When to reach for inheritance vs alternatives:**
> | Need | Modern C++ idiom |
> |---|---|
> | "Pick behavior at runtime among a fixed set" | `std::variant<A, B, C>` + `std::visit` |
> | "Pick behavior at runtime, set is open" | virtual functions |
> | "Compile-time customization point" | template + concept (C++20) or CRTP |
> | "Reuse implementation between unrelated types" | composition (member of a helper class) |
> | "Adapt one interface to another" | composition + delegation |
>
> **Inheritance is the wrong default.** It's the right answer when you genuinely need open-ended runtime polymorphism with an *is-a* relationship — UI widgets, game entities, file format parsers. For everything else, prefer composition or sum types.

## 55. Virtual Destructors
*(Ep. 53)*

If you'll ever delete a derived object through a base pointer, the base's destructor **must** be `virtual`.

```cpp
struct Base                { /* dtor non-virtual */ };
struct Derived : Base      { std::vector<int> big; };

Base* p = new Derived;
delete p;                  // calls only Base's dtor — Derived's vector LEAKS
```

Fix:
```cpp
struct Base {
    virtual ~Base() = default;
};
```

**Rule:** any class with virtual functions should also have a virtual destructor. (Most compilers warn with `-Wnon-virtual-dtor`.)

> **🔬 Under the Hood — Why virtual destructors are needed:**
> When you `delete base_ptr`, the compiler generates a call to `~Base()` based on the static type of the pointer. With a virtual destructor, it instead does a vtable lookup to find the *actual* type's destructor (`~Derived()`), which then calls `~Base()` itself as part of cleanup. Without virtual, you call only `~Base()`, and any resources owned by `Derived` (vector, file handle, etc.) leak silently.

> **🏭 Industry Note — Design patterns for safe polymorphism:**
> 1. **Public base destructor must be virtual.** Or make the base destructor **protected and non-virtual** to forbid `delete base_ptr` (Herb Sutter's Guideline).
> 2. **Make polymorphic bases non-copyable** (`= delete` copy/move). Otherwise you get **object slicing**: `Base b = derived;` silently drops the `Derived` parts.
> 3. **Use smart pointers (`unique_ptr<Base>`)** for owned polymorphic objects so the destructor question goes away.

## 56. The vtable
*(Ep. 54)*

The most popular interview question in C++.

When a class has any virtual functions, the compiler generates a per-class **vtable** — a static array of function pointers, one slot per virtual method. Each object of the class contains a hidden **vptr** that points at the class's vtable.

A virtual call compiles to roughly:

```
mov  rax, [object]        ; load vptr from the object
mov  rcx, [rax + offset]  ; look up the method's slot
call rcx                  ; indirect call
```

Implications:
- **Memory** — one pointer per object (the vptr). 8 bytes on 64-bit.
- **Time** — one extra load and an indirect call per virtual invocation.
- **Optimization** — virtual calls are harder for the compiler to inline. Devirtualization happens only when the dynamic type is known at the call site.

For tight inner loops in network packet processing, signal processing, or graphics inner loops, those costs add up. That's why high-performance C++ leans on templates / CRTP (covered in Part IX) or `std::variant` + `std::visit` to get dispatch without vtables.

```cpp
struct Base {
    virtual void f();
    virtual void g();
    virtual ~Base();
};

// Conceptual layout of an object:
// +------+        +------------+
// | vptr |───────▶| &Base::f   |
// +------+        | &Base::g   |
// | data |        | &Base::~Base|
// +------+        +------------+
```

## 57. Pure Virtual Functions / Interfaces
*(Ep. 55)*

A pure virtual function is declared with `= 0`. A class containing one cannot be instantiated — it's **abstract**, and works as an interface.

```cpp
struct ILogger {
    virtual ~ILogger() = default;
    virtual void info (std::string_view) = 0;
    virtual void error(std::string_view) = 0;
};

struct ConsoleLogger : ILogger {
    void info (std::string_view s) override { std::cout << "[I] " << s << '\n'; }
    void error(std::string_view s) override { std::cerr << "[E] " << s << '\n'; }
};

void run(ILogger& log) {                  // depend on the interface
    log.info("hello");
}
```

This is **dependency inversion** — the cornerstone of testable design. Inject a logger; mock it in tests.

Pure virtual methods may even have a definition (default behavior derived classes can call):

```cpp
struct Base {
    virtual void f() = 0;
};

void Base::f() { std::cout << "Base default\n"; }    // optional default

struct D : Base {
    void f() override { Base::f(); std::cout << "D extra\n"; }
};
```

## 58. Multiple Inheritance — Caution
*(Ep. 56)*

C++ allows inheriting from more than one base class. Useful when interfaces are involved; perilous when implementation is.

```cpp
struct Drawable    { virtual void draw()  const = 0; };
struct Serializable{ virtual void save(std::ostream&) const = 0; };

struct Widget : Drawable, Serializable {
    void draw()                  const override { /*...*/ }
    void save(std::ostream& os)  const override { /*...*/ }
};
```

Reasonable: multiple **interface** inheritance.
Risky: multiple **implementation** inheritance — fields are inherited, leading to ambiguity and the **diamond problem** (covered in section 62).

Real-world advice:
- Prefer composition.
- If you need multi-inheritance, keep all but one base purely abstract (interfaces).

## 59. `const` Correctness for Member Functions
*(Ep. 58)*

A member function declared `const` promises not to modify the object's logical state.

```cpp
class Account {
    double balance_;
public:
    double balance() const { return balance_; }       // doesn't modify *this
    void   deposit(double amt) { balance_ += amt; }    // modifies *this
};
```

The `const` on a member function changes the implicit `this` from `T*` to `const T*`. You can call `const` members on `const` objects; you cannot call non-`const` members on `const` objects.

```cpp
const Account a{100.0};
a.balance();        // ✅
a.deposit(10);       // ❌ — not callable on const object
```

**Why this matters for everything else:** because `const T&` parameters are everywhere, every member function that *can* be `const` *should* be. Forgetting a `const` propagates as friction up the call chain.

## 60. `{}` vs `()` and `std::initializer_list`
*(Ep. 59)*

Brace `{}` initialization differs from parenthesis `()` initialization in subtle but important ways.

### Narrowing

```cpp
int  a(3.7);    // 3 (silent truncation)
int  b{3.7};    // ❌ narrowing — error
```

### `std::initializer_list` overload preference

If a class has a constructor taking `std::initializer_list<T>`, brace init prefers it.

```cpp
std::vector<int> v1(10, 5);     // 10 elements, each = 5
std::vector<int> v2{10, 5};     // 2 elements: 10 and 5  (initializer_list ctor wins)
```

This is a famous trap with `std::vector`. The fix is to use `()` when you mean "10 of value 5", and `{}` when you mean "list of these elements."

### `std::initializer_list` for your own type

```cpp
#include <initializer_list>

class Mat {
    std::vector<double> data_;
public:
    Mat(std::initializer_list<double> il) : data_(il) {}
};

Mat m{1.0, 2.0, 3.0, 4.0};
```

Useful for math types, container-like classes, configuration-like value types.

## 61. Composition vs Inheritance
*(Ep. 60)*

Inheritance models **is-a**. Composition models **has-a**. The vast majority of "I want to reuse this" cases are has-a.

```cpp
// Inheritance — Car IS-A Engine??  No.
class Car : public Engine { /* ... */ };

// Composition — Car HAS-A Engine.  Yes.
class Car {
    Engine engine_;
    Wheels wheels_;
public:
    void start() { engine_.ignite(); }
};
```

Reasons composition usually wins:
- **Looser coupling** — you can change the type of `engine_` without rewriting subclasses.
- **No fragile base class** — subclass behavior doesn't accidentally depend on base internals.
- **Easier testing** — you can inject a different engine (a mock) in tests.
- **No multiple-inheritance complications.**

The classic advice from Bjarne and the GoF book: **prefer composition over inheritance.** Reach for inheritance only when you genuinely want runtime polymorphism *and* an is-a relationship.

## 62. Virtual Inheritance / Diamond Revisited
*(Ep. 61)*

The **diamond problem**:

```
   A
  / \
 B   C
  \ /
   D
```

If both `B` and `C` inherit from `A`, by default `D` ends up with **two** `A` sub-objects. Calling `D::a_member` is ambiguous.

```cpp
struct A { int n; };
struct B : A {};
struct C : A {};
struct D : B, C {};

D d;
// d.n;           // ❌ ambiguous — which A's n?
d.B::n = 1;
d.C::n = 2;
```

**Virtual inheritance** ensures only one `A` exists in `D`:

```cpp
struct A { int n; };
struct B : virtual A {};
struct C : virtual A {};
struct D : B, C {};

D d;
d.n = 5;          // unambiguous — single A
```

But virtual inheritance:
- Adds indirection (vbtables / offset tables).
- Changes initialization rules: the **most-derived** class is responsible for initializing the virtual base.
- Adds complexity to the class layout.

In real code, virtual inheritance is rare. It surfaces in some interface frameworks and in iostreams (the `std::iostream` itself uses virtual inheritance from `istream` and `ostream`).

## 63. Value Initialization / Zero-Initialization of Members
*(Ep. 63)*

In C++, **uninitialized scalars are indeterminate**. Reading them is UB.

```cpp
class Bad {
    int x;          // not initialized — indeterminate
};
class Good {
    int x{};        // value-initialized to 0
};
class Better {
    int x = 0;      // explicit default-member-initializer
};
```

Forms of initialization to know:

| Syntax | What it does |
|--------|--------------|
| `T x;` | Default-initialization. For class types, calls default ctor; for scalars, indeterminate. |
| `T x{};` | Value-initialization. Scalars zero-initialized; classes default-constructed. |
| `T x = 0;` / `T x{0};` | Direct- or copy-initialization with a value. |
| `T x(args...);` / `T x{args...};` | Direct-initialization with constructor args. |

**Habit:** initialize *every* variable. `int x{};` rather than `int x;`.

## 64. In-Class Initializer
*(Ep. 64)*

You can give a member a default value at its declaration. Constructors can override it via the member initializer list.

```cpp
class Config {
    int  retries_  = 3;
    bool verbose_  = false;
    std::string host_ = "localhost";
public:
    Config() = default;
    Config(std::string h) : host_(std::move(h)) {}        // overrides default for host_
};
```

Benefits:
- DRY — define defaults once, not in every constructor.
- The default is visible right next to the member.
- If you add a new constructor later, it inherits the defaults automatically.

Combine with `=default` constructors and you frequently write zero constructor bodies.

## 65. Delegating Constructors
*(Ep. 65)*

A constructor can call another constructor of the same class via the initializer list. C++11 feature; eliminates duplication when you have several overloads.

```cpp
class Server {
    std::string host_;
    int         port_;
    int         timeout_ms_;
public:
    Server(std::string host, int port, int timeout)
        : host_(std::move(host)), port_(port), timeout_ms_(timeout)
    {}

    Server(std::string host, int port)
        : Server(std::move(host), port, 5000)             // delegate
    {}

    Server(std::string host)
        : Server(std::move(host), 443, 5000)              // delegate
    {}
};
```

Note: when delegating, you cannot also have a member initializer list — the delegated constructor handles initialization.

## 66. Class Data Layout (Optimizing for Size)
*(Ep. 66)*

A class object's memory layout depends on its members **and** alignment. You can shave bytes by reordering members.

```cpp
struct Bad {
    char  a;       // 1 byte
    // 7 bytes padding
    double b;      // 8 bytes
    char  c;       // 1 byte
    // 7 bytes padding
};                  // sizeof(Bad) == 24
```

Reorder by size, descending:

```cpp
struct Better {
    double b;      // 8 bytes
    char   a;      // 1 byte
    char   c;      // 1 byte
    // 6 bytes padding (only one round of trailing padding now)
};                  // sizeof(Better) == 16
```

Tools and tricks:
- `sizeof` and `offsetof` to inspect layout.
- `alignof(T)` and `alignas(N)` to query and force alignment.
- Compiler-specific: `__attribute__((packed))` (GCC/Clang) and `#pragma pack(1)` (MSVC) eliminate padding — necessary for binary protocols, dangerous for general use (alignment violations).

For systems and networking code: **always pin down on-the-wire layouts** with explicit `static_assert(sizeof(Pkt) == N)` and per-field serialization, rather than trusting struct layout to be wire-compatible across compilers.

## 67. PIMPL — Pointer to Implementation; API Design
*(Eps. 67, 90)*

PIMPL hides a class's data members behind an opaque pointer.

### Header (visible to users)

```cpp
// widget.hpp
#include <memory>

class Widget {
public:
    Widget();
    ~Widget();
    Widget(Widget&&) noexcept;
    Widget& operator=(Widget&&) noexcept;

    void draw();
    void resize(int w, int h);

private:
    struct Impl;                      // forward-declared
    std::unique_ptr<Impl> p_;
};
```

### Source (private)

```cpp
// widget.cpp
#include "widget.hpp"
#include <iostream>

struct Widget::Impl {
    int width  = 0;
    int height = 0;
    std::string title = "untitled";
    void render() const { std::cout << title << ' ' << width << 'x' << height << '\n'; }
};

Widget::Widget() : p_(std::make_unique<Impl>()) {}
Widget::~Widget()                                    = default;
Widget::Widget(Widget&&) noexcept                    = default;
Widget& Widget::operator=(Widget&&) noexcept         = default;

void Widget::draw()                  { p_->render(); }
void Widget::resize(int w, int h)    { p_->width = w; p_->height = h; }
```

Why bother:
- **Compile times** — changing private fields of `Impl` doesn't recompile any user of `widget.hpp`.
- **Stable ABI** — the size of `Widget` (one pointer) doesn't change when you add private members, which matters for shared libraries.
- **Clean public surface** — users see only the API, not implementation noise.

Cost: every member access is one pointer indirection.

> **🏭 Industry Note — PIMPL in real shipping libraries:**
> - **Qt** uses PIMPL pervasively (the `Q_D(Class)` macro). It's how Qt evolves without breaking ABI for shipped applications.
> - **Standard library implementations** (libstdc++, libc++) hide implementation details from headers to enable ABI stability across compiler upgrades.
> - **Header-only libraries** (Boost, fmt, range-v3) reject PIMPL because it requires a separate `.cpp` — they trade ABI stability for "just include and go."
>
> Use PIMPL when: you ship a library and need ABI stability, OR when private members include heavy headers you don't want to pull in everywhere. Don't use PIMPL when: the class is rarely used or always part of the same compilation unit.

### `struct Options` Pattern (Ep. 90)

When a function has too many parameters, group them into an Options struct:

```cpp
struct ConnectOptions {
    int  port        = 443;
    int  timeout_ms  = 5000;
    bool tls         = true;
    std::string user_agent = "myapp/1.0";
};

void connect(const std::string& host, ConnectOptions opts = {});

connect("example.com");
connect("example.com", {.port = 80, .tls = false});  // C++20 designated initializers
```

Benefits over many positional parameters:
- Self-documenting at the call site.
- Easy to extend without breaking callers.
- Defaults are obvious.

## 68. The `this` Keyword
*(Ep. 68)*

Inside a non-static member function, `this` is a pointer to the current object.

```cpp
class Counter {
    int n_;
public:
    Counter(int n) : n_(n) {}

    void show() const {
        std::cout << this << " : " << this->n_ << '\n';
    }

    Counter& operator+=(int x) {
        n_ += x;
        return *this;             // return reference to current object
    }
};
```

Common uses:
- Disambiguate when a parameter shadows a member: `this->n = n;`
- Return `*this` from member operators that should support chaining.
- Pass `this` to a callback expecting a pointer.
- Capture in lambdas (section 92): `[this]` or `[*this]`.

Outside member functions, `this` doesn't exist.

## 69. Static Member Variables and Functions
*(Ep. 70)*

A `static` data member belongs to the **class**, not any instance. There's only one of it.

```cpp
class Logger {
    inline static int s_count = 0;        // C++17 — no separate definition needed

public:
    Logger()  { ++s_count; }
    ~Logger() { --s_count; }

    static int count() { return s_count; }
};
```

Pre-C++17, you had to define `s_count` in exactly one `.cpp`:

```cpp
// in header:
class Logger { static int s_count; };
// in source:
int Logger::s_count = 0;
```

Static **member functions** have no `this`. They're called like `ClassName::func(...)` or `instance.func(...)`.

```cpp
class Math {
public:
    static double square(double x) { return x * x; }
};

Math::square(3.0);
```

Use cases: factory functions, utility helpers grouped under a class namespace, counters of instances, registries.

## 70. Nested Classes
*(Ep. 98)*

A class can be defined inside another class. The inner class is just a class scoped to its outer class — there's no implicit relationship between instances.

```cpp
class LinkedList {
public:
    class Iterator {
        Node* p_;
    public:
        Iterator(Node* p) : p_(p) {}
        int& operator*()  { return p_->value; }
        Iterator& operator++() { p_ = p_->next; return *this; }
        bool operator!=(const Iterator& o) const { return p_ != o.p_; }
    };

private:
    struct Node { int value; Node* next; };
    Node* head_ = nullptr;
public:
    Iterator begin() { return Iterator{head_}; }
    Iterator end()   { return Iterator{nullptr}; }
};
```

Use nested classes when the inner type is a tightly-coupled implementation detail (an iterator, a builder, a node type). They get access to the outer class's private members but they are not "owned" by an outer instance.

## 71. `mutable` Keyword + the M&M Rule
*(Ep. 101)*

`mutable` lets a member be modified even from a `const` member function. The classic legitimate use is **caches and synchronization primitives** — things that affect performance but not logical state.

```cpp
class Lookup {
    std::map<int, std::string>     data_;
    mutable std::map<int, std::string> cache_;   // cache may be updated even from const fn
public:
    const std::string& find(int k) const {
        if (auto it = cache_.find(k); it != cache_.end()) return it->second;
        cache_[k] = expensive_compute(k);          // OK because cache_ is mutable
        return cache_[k];
    }
};
```

### The M&M Rule (Scott Meyers)

> Member functions should be either **`mutable` and not `const`**, or **`const` and not `mutable`**, or **neither.** Avoid combining them carelessly.

In simpler terms: don't sprinkle `mutable` everywhere to escape `const` — that defeats the whole point of `const`. Reserve it for genuinely "logical const, physical non-const" cases (caches, mutexes, atomics for stats).

## 72. Conversion Operators
*(Ep. 203)*

A class can define how it converts to other types.

```cpp
class Fraction {
    int num_, den_;
public:
    Fraction(int n, int d) : num_(n), den_(d) {}

    explicit operator double() const {
        return static_cast<double>(num_) / den_;
    }

    explicit operator bool() const {
        return num_ != 0;
    }
};

Fraction f{3, 4};
double d = static_cast<double>(f);   // 0.75
if (f) { /* num_ != 0 */ }
```

**Mark conversion operators `explicit`** — same reason as `explicit` constructors. Implicit conversions in both directions (constructor and conversion operator) lead to baffling overload-resolution surprises.

`explicit operator bool()` is the standard pattern for "is this object in a usable state?" — used by `std::ifstream`, `std::optional`, `std::unique_ptr`, etc.

---


# Part VI — `constexpr` Family & Assertions

## 73. `constexpr`
*(Ep. 86)*

`constexpr` says "this **may** be evaluated at compile time." The compiler decides based on the context.

- **Variables** — must be initialized with a constant expression; usable in compile-time contexts. Implicitly `const`.
- **Functions** — *can* be evaluated at compile time when inputs are constants, *and* can also run at runtime when inputs are runtime values.

> **🎯 Mental Model — The Compile-Time Family:**
> - **`const`** — "I promise not to change this value." Evaluated at runtime *or* compile time.
> - **`constexpr`** — "This value/function **can** be evaluated at compile time." Opportunistic — compiler decides per call site.
> - **`consteval`** (§74) — "This function **must** be evaluated at compile time." Strict; calling with non-constant arguments is an error.
> - **`constinit`** (§75) — "This variable **must be initialized** at compile time, but can mutate at runtime." Avoids the static initialization order fiasco.
>
> Read as four points along an axis from least to most strict about *when* evaluation happens.

```cpp
constexpr int kBufferSize = 4096;          // baked into the binary

constexpr int square(int x) { return x * x; }

int  arr[square(8)];                        // OK — square(8) is a constant expression
int  n = 5;
int  r = square(n);                         // also OK — runtime evaluation
```

A `constexpr` variable is implicitly `const`. A `constexpr` function may have arguments only known at runtime; it'll just run normally then.

```cpp
constexpr int factorial(int n) {
    return n <= 1 ? 1 : n * factorial(n - 1);
}

static_assert(factorial(5) == 120);          // verified at compile time
```

Modern C++ lets you do increasingly elaborate things in `constexpr` functions: `if`, `for`, `while`, `try/catch` (C++20), even allocations (C++20, with strict rules). The trend is toward "anything you can do at runtime, you can do at compile time."

> **🏭 Industry Note — Compile-time computation in practice:**
> - **Embedded systems** use `constexpr` lookup tables (sin/cos, CRC tables, character classification) baked into ROM — zero runtime cost.
> - **Game engines** use `constexpr` for math (matrix transforms, shader constants), serialization tags, and asset IDs.
> - **Networking** uses `constexpr` for protocol parsers and packet schemas (e.g., compile-time field offsets).
> - **fmt and `std::format`** (C++20) verify format strings at compile time — no `printf` UB if a runtime string mismatches the args.
>
> The win: bugs found at compile time. The cost: longer compile times (`constexpr` execution is slow vs. runtime). Profile before going wild — a 100-element `constexpr` sort can balloon compile time by seconds.

> **⚠️ Pitfall — `constexpr` doesn't *force* compile-time:**
> ```cpp
> constexpr int square(int x) { return x * x; }
> int n = 5;
> int r = square(n);        // runtime — n is not a constant expression
> int s = square(5);        // *may* be compile-time; compiler decides
> ```
> If you need a guarantee, store the result in a `constexpr` variable or use `consteval` (§74):
> ```cpp
> constexpr int s = square(5);   // FORCED to evaluate at compile time
> ```

## 74. `consteval` (C++20)
*(Ep. 87)*

`consteval` is `constexpr`'s strict cousin: the function **must** be evaluated at compile time. Calling it with non-constant arguments is an error.

```cpp
consteval int square(int x) { return x * x; }

constexpr int a = square(5);                // OK — compile time
int n = 5;
// int b = square(n);                        // ❌ — not a constant expression
```

When to use it:
- You want to *force* compile-time evaluation (e.g., a compile-time-only string formatting helper).
- The function would be incorrect or unsafe to run at runtime.

`consteval` functions are common in modern compile-time libraries like `<format>` argument validation.

## 75. `constinit` (C++20)
*(Ep. 88)*

`constinit` says "this variable must be **initialized** at compile time" — but, unlike `constexpr`, the variable itself isn't `const` and can be modified at runtime.

```cpp
constinit int g_state = 0;          // initialized at compile time, mutable at runtime

void f() { ++g_state; }              // OK
```

The motivation is the **"static initialization order fiasco"**: regular global initialization order between translation units is unspecified, leading to subtle bugs. `constinit` guarantees no dynamic initialization happens, which means no order dependency.

```cpp
// Safe across TUs:
constinit Logger g_logger{/* compile-time init */};
```

## 76. `assert` and `static_assert`
*(Ep. 205)*

### `assert` (runtime)

From `<cassert>`. Aborts the program if the condition is false; compiled out when `NDEBUG` is defined.

```cpp
#include <cassert>

double safe_sqrt(double x) {
    assert(x >= 0.0);                   // checked in debug builds; vanishes with -DNDEBUG
    return std::sqrt(x);
}
```

Use `assert` for **invariants you believe must hold** — programmer errors, not user errors. For "this user gave bad input," use exceptions or `std::expected`.

### `static_assert` (compile time)

A compile-time check. Fails the build if its condition is false.

```cpp
static_assert(sizeof(void*) == 8, "this code assumes a 64-bit target");
static_assert(std::is_trivially_copyable_v<Pkt>, "Pkt must be POD-ish for memcpy");
```

Indispensable for:
- Verifying type-trait expectations in templates.
- Confirming binary layout assumptions.
- Sanity-checking compile-time constants.

> **🏭 Industry Note — Assertions strategy in production:**
> - **Programmer errors** → `assert` (or your project's `DCHECK`). Active in debug, removed in release.
> - **Runtime conditions you must check** (network input, user data, file format) → exceptions, `std::expected`, or return codes. Never `assert` on data you don't control.
> - **Compile-time invariants** → `static_assert`. Free; should be everywhere they apply.
> - **Critical safety checks in release** → `CHECK` (Google/Abseil-style — always-on assert that aborts).
>
> The Abseil/Chromium pattern uses three macros: `DCHECK` (debug only), `CHECK` (always on, aborts), and `LOG(FATAL)` (always on, log first then abort). Most projects benefit from a similar split.

> **⚠️ Pitfall — `assert` with side effects:**
> ```cpp
> assert(do_critical_setup() == 0);   // side effect VANISHES in release builds!
> ```
> `NDEBUG` removes the entire expression, including any side effects. Always separate side effects from assertions:
> ```cpp
> int result = do_critical_setup();
> assert(result == 0);
> ```

## 77. `auto`
*(Ep. 206)*

`auto` lets the compiler deduce the type from the initializer.

```cpp
auto i  = 42;                  // int
auto d  = 3.14;                // double
auto s  = std::string{"hi"};   // std::string
auto v  = std::vector{1, 2};   // std::vector<int>
```

### Important rules

1. **`auto` strips top-level `const` and references.** Use `const auto&` to keep them.

```cpp
const std::string s = "hello";

auto         a = s;     // std::string — copy!
const auto&  b = s;     // const std::string& — reference
auto&        c = s;     // ❌ tries to bind non-const ref to const — fails
```

2. **`auto` is great** when the type is verbose or implementation-detail (iterators, lambda return types, template-derived types).

```cpp
for (auto it = v.begin(); it != v.end(); ++it) { /* ... */ }
auto fn = [](int x) { return x * 2; };
```

3. **Don't overuse `auto`**. If a human reading the code couldn't quickly tell the type, write the type explicitly.

4. **`auto` deduction == template type deduction** rules (with one exception around braced initializers). What works for `template<typename T>` works for `auto`.

> **🏭 Industry Note — The AAA style (Almost Always Auto):**
> Herb Sutter advocates `auto x = T{value};` for *all* declarations:
> ```cpp
> auto count = std::size_t{0};       // explicit type via initializer
> auto name  = std::string{"alice"};
> auto vec   = std::vector<int>{1, 2, 3};
> ```
> Benefits: prevents accidental narrowing (`int x = vec.size();` loses the upper 32 bits of `size_t` on 64-bit!), uniform syntax everywhere. Critics: noisier for simple cases, less greppable. Google style explicitly limits `auto` to iterators and lambdas; Meta is more permissive.
>
> Find your team's middle ground. The most important rule: **don't use `auto` when the type is the most important thing on the line** (`auto config = parse(file);` — what *is* config?).

> **⚠️ Pitfall — `auto` deduces `initializer_list`, surprisingly:**
> ```cpp
> auto x = {1, 2, 3};   // x is std::initializer_list<int>, NOT std::vector!
> auto y{1};            // y is int (C++17 fixed this; pre-C++17 it was initializer_list<int>)
> ```
> Just don't use brace-init with bare `auto` for single values. Use `auto x = 1;` or `auto x = std::vector{1,2,3};`.

> **🔬 Under the Hood — `auto` and reference/const:**
> ```cpp
> int i = 0;
> const int& cref = i;
> auto a = cref;          // a is int — auto STRIPS const and &
> const auto& b = cref;   // b is const int& — must write it explicitly
> decltype(cref) c = i;   // c is const int& — decltype preserves exactly
> ```
> `auto` follows template deduction (strips top-level const/ref); `decltype` preserves exactly. Use `decltype(auto)` (C++14) when you want template-rules in *most* places but exact preservation in *return type deduction*.

---

# Part VII — Casts & Bit-Level Programming

## 78. Casting Overview
*(Ep. 91)*

C++ has four named casts. They communicate intent better than C-style `(T)x`.

| Cast | Purpose |
|------|---------|
| `static_cast<T>(x)` | Compile-time-checked conversions: numeric, upcast, sane downcast, enum ↔ underlying. |
| `dynamic_cast<T>(x)` | Runtime-checked downcast in polymorphic hierarchies. |
| `const_cast<T>(x)` | Add or remove `const` / `volatile`. |
| `reinterpret_cast<T>(x)` | Bit-level reinterpretation. Last resort. |

C-style `(T)x` tries each in turn — surprisingly aggressive and easy to miss in code review. Avoid it.

```cpp
double d = 3.14;
int    i = static_cast<int>(d);             // 3 — clear intent
```

> **🏭 Industry Note — Ban C-Style Casts in your codebase:**
> Google, LLVM, Mozilla, and most safety-conscious shops enforce `-Wold-style-cast` (often as `-Werror`) to completely forbid `(int)x`. The reason isn't just style:
>
> A C-style cast tries each named cast in sequence — `static_cast` first, then `reinterpret_cast` if static fails. **If a refactor changes `x`'s type from `int` to `int*`, what was a safe numeric truncation silently degrades into a memory reinterpretation** — same syntax, completely different (and often catastrophic) behavior, **no compiler warning**.
>
> Named casts make intent verifiable: `static_cast<int>(p)` won't compile if `p` is a pointer. The C-style version just shrugs and gives you back garbage.

> **🎯 Mental Model — Each cast has a different "trust level":**
> | Cast | What you're claiming |
> |---|---|
> | `static_cast<T>(x)` | "The conversion is sensible by language rules — I might lose precision, but I won't reinterpret memory." |
> | `dynamic_cast<T*>(p)` | "I think this is actually a Derived. Tell me at runtime." |
> | `const_cast<T*>(p)` | "I know better than the type system about the const-ness here." (rarely true) |
> | `reinterpret_cast<T*>(p)` | "Just give me these bytes typed differently. I take all responsibility." |
> | `(T)x` (C-style) | "Pick whatever cast makes it compile." (Don't.) |
>
> The benefit of named casts: code review and grep. `grep -r reinterpret_cast` immediately finds all the dangerous spots in a codebase. `grep -r '(int)'` finds nothing useful.

> **🏭 Industry Note — Code review red flags:**
> - `reinterpret_cast` outside of low-level code → almost always wrong. Use `std::bit_cast` (§84) for type punning.
> - `const_cast` to remove const → 99% of the time a design flaw. The 1% legitimate case: working around a third-party C API that takes non-const pointers but doesn't actually mutate.
> - C-style cast in new code → reject. clang-tidy's `cppcoreguidelines-pro-type-cstyle-cast` catches these.
> - `dynamic_cast` everywhere → consider `std::variant` (§122) instead. Often a sign of misused inheritance.

## 79. Casting — What Could Go Wrong
*(Ep. 92)*

Common cast disasters:

- **Narrowing** — `static_cast<int>(3.99)` silently gives `3`. Often intended; sometimes a bug.
- **Signed/unsigned mix** — `int{-1} < unsigned{0}` is `false` because `-1` becomes a huge unsigned value.
- **Lossy upcast/downcast** — `static_cast<Derived*>(base_ptr)` when the actual object isn't a `Derived`: undefined behavior. Use `dynamic_cast` if unsure.
- **Bit-level reinterpretation between unrelated types** — UB unless you're going through `std::byte*`, `char*`, `unsigned char*`, or using `std::bit_cast`.

C++20 added safe integer comparisons in `<utility>`:

```cpp
#include <utility>

int      a = -1;
unsigned b =  1;
std::cmp_less(a, b);          // true — semantically correct
std::cmp_greater(a, b);       // false
std::cmp_equal(a, b);         // false
```

These avoid the implicit-conversion landmine. Always reach for `std::cmp_*` when comparing across signedness.

## 80. Integer & Floating Suffixes; the `'` Digit Separator
*(Ep. 93)*

Numeric literals carry suffixes that specify their type.

```cpp
auto a = 42;        // int
auto b = 42L;       // long
auto c = 42LL;      // long long
auto d = 42U;       // unsigned int
auto e = 42UL;      // unsigned long
auto f = 42ULL;     // unsigned long long

auto g = 3.14;      // double
auto h = 3.14f;     // float
auto i = 3.14L;     // long double
```

Integer prefixes:
- `0x` — hex (`0xDEADBEEF`)
- `0b` — binary (`0b1010_1010`) since C++14
- `0`  — octal (legacy, easy to confuse with decimal — avoid)

### Digit separator `'` (C++14)

Improves readability of long literals. Anywhere within an integer or float literal:

```cpp
constexpr int kOneMillion = 1'000'000;
constexpr double kSpeedOfLight = 299'792'458.0;
constexpr unsigned mask = 0b1111'0000'1010'1010;
```

The compiler treats `'` as if it weren't there.

## 81. `static_cast` and `dynamic_cast`
*(Eps. 94, 95)*

### `static_cast`

Compile-time-checked. No runtime overhead. Use for:

```cpp
double d = 3.14;
int    i = static_cast<int>(d);                  // numeric

void* vp = malloc(100);
char* cp = static_cast<char*>(vp);                // void* → typed

struct Base {};
struct Derived : Base {};
Derived d2;
Base*    bp = static_cast<Base*>(&d2);            // upcast (always safe)
Derived* dp = static_cast<Derived*>(bp);          // downcast (UB if bp is not really Derived)
```

### `dynamic_cast`

Runtime-checked downcast. Requires a **polymorphic** base (at least one virtual function). Returns `nullptr` (for pointers) or throws `std::bad_cast` (for references) on failure.

```cpp
struct Animal { virtual ~Animal() = default; };
struct Dog : Animal { void bark() {} };
struct Cat : Animal { void meow() {} };

void poke(Animal* a) {
    if (auto* d = dynamic_cast<Dog*>(a)) { d->bark(); return; }
    if (auto* c = dynamic_cast<Cat*>(a)) { c->meow(); return; }
}
```

### Interview-question summary (Ep. 95)

| Property | `static_cast` | `dynamic_cast` |
|----------|----------------|----------------|
| Compile-time check | Yes | Yes (signature) |
| Runtime check | No | Yes (RTTI lookup) |
| Speed | Free | Slow-ish (RTTI traversal) |
| Failure mode | UB if wrong | `nullptr` / `bad_cast` |
| Requires virtual base | No | Yes |
| Best for | Numeric, upcast, certain downcast | Uncertain downcast, runtime type queries |

If your hierarchy has lots of `dynamic_cast`s, that's a smell — usually you want a `std::variant` + `std::visit`, or a virtual function on the base.

## 82. `reinterpret_cast`
*(Ep. 97)*

Bit-level reinterpretation. The most dangerous cast. Use cases:

- Type-punning over `char*` / `std::byte*` / `unsigned char*` — these are the only types you can alias arbitrary objects through (the "strict aliasing" rule).
- Some FFI scenarios crossing into C APIs that take `void*`.

```cpp
std::uint32_t value = 0x01020304;
auto* bytes = reinterpret_cast<std::uint8_t*>(&value);
// bytes[0..3] are the four bytes of value (in machine endianness)
```

Misuses that look harmless but are UB:
- Reading an `int` through a `float*`.
- Reading the active member of a union via the wrong type (use `std::variant` or `std::bit_cast`).

For a safer, well-defined alternative, use `std::bit_cast` (section 84).

## 83. Type Punning
*(Ep. 211)*

"Type punning" = looking at the bits of one type as another. The traditional approaches and their problems:

```cpp
float    f = 3.14f;
std::uint32_t i;

// 1) Union punning (UB in C++ for reading the inactive member!)
union U { float f; std::uint32_t i; } u;
u.f = f;
i   = u.i;       // UB in C++ (Allowed in C; not in C++)

// 2) reinterpret_cast (UB unless you go through char*/byte*)
i = *reinterpret_cast<std::uint32_t*>(&f);    // UB on most platforms

// 3) memcpy — well-defined!
std::memcpy(&i, &f, sizeof(i));                // OK

// 4) std::bit_cast (C++20) — well-defined and constexpr
i = std::bit_cast<std::uint32_t>(f);           // OK
```

**Use `memcpy` (or `std::bit_cast`) to type-pun.** Compilers recognize the pattern and produce identical (often zero-instruction) code as the unsafe versions, but without the UB.

> **🏭 Industry Note — Type punning is where systems code lives:**
> Real-world cases where you'll do this:
> - **Network packet parsing** — `memcpy(&header, buf, sizeof(header))`. Or use `std::bit_cast` for a single field.
> - **Float bit manipulation** — quake's famous fast inverse square root used `union` punning; modern code uses `std::bit_cast<uint32_t>(f)`.
> - **Serialization** — game save files, custom RPC formats, log file readers.
> - **Hardware register I/O** — but here `volatile` matters too, since the compiler can't reorder reads.
>
> Always pair with `static_assert(std::is_trivially_copyable_v<T>)` to ensure the type is safe to bit-copy.

## 84. `std::bit_cast` (C++20)
*(Ep. 213)*

`std::bit_cast<To>(from)` is the well-defined, constexpr-friendly way to copy the bit pattern of one trivially-copyable object into another.

```cpp
#include <bit>
#include <cstdint>

float         f = 1.5f;
std::uint32_t bits = std::bit_cast<std::uint32_t>(f);  // 0x3FC00000

float back = std::bit_cast<float>(bits);                 // 1.5f
```

Requirements:
- `sizeof(To) == sizeof(From)`.
- Both are trivially copyable.

It's literally a `memcpy` between the two but expressed as a value-returning function — which means it can be `constexpr` (`memcpy` cannot).

## 85. Print a Double in Binary (Exercise)
*(Ep. 212)*

A nice exercise that combines bit-level reinterpretation, `std::bitset`, and `std::cout`:

```cpp
#include <bit>
#include <bitset>
#include <cstdint>
#include <iostream>

void print_double_bits(double d) {
    auto bits = std::bit_cast<std::uint64_t>(d);
    std::bitset<64> b{bits};
    std::cout << b << '\n';
    // Optional: split sign / exponent / mantissa
    std::cout << "sign:    " << ((bits >> 63) & 1)   << '\n';
    std::cout << "exp:     " << ((bits >> 52) & 0x7FFu) << '\n';
    std::cout << "mant:    " << (bits & ((1ULL << 52) - 1)) << '\n';
}

int main() { print_double_bits(1.0); }
```

For `1.0`: sign 0, exponent 1023 (bias-1023 representation of 0), mantissa 0. Try it for `0.1` and you'll see why floating-point is full of surprises.

## 86. Fixed-Width Integer Types
*(Ep. 207)*

`int` is *at least* 16 bits but typically 32; `long` is *at least* 32 but might be 64 on Linux x86-64 and 32 on Windows. For wire-format, registers, MMIO, and protocol code, you need exact widths.

`<cstdint>` provides:

| Exact-width | At-least width | Fastest of-at-least |
|-------------|----------------|---------------------|
| `int8_t`, `int16_t`, `int32_t`, `int64_t` | `int_least8_t` … | `int_fast8_t` … |
| `uint8_t`, `uint16_t`, `uint32_t`, `uint64_t` | `uint_least8_t` … | `uint_fast8_t` … |
| Plus `intptr_t`, `uintptr_t`, `intmax_t`, `uintmax_t` | | |

```cpp
#include <cstdint>

struct __attribute__((packed)) IPv4Header {
    std::uint8_t  version_ihl;
    std::uint8_t  dscp_ecn;
    std::uint16_t total_length;
    std::uint16_t identification;
    std::uint16_t flags_fragment;
    std::uint8_t  ttl;
    std::uint8_t  protocol;
    std::uint16_t checksum;
    std::uint32_t src_addr;
    std::uint32_t dst_addr;
};
static_assert(sizeof(IPv4Header) == 20);
```

Always pair with explicit byte-order conversions (`htons`, `htonl`, `ntohs`, `ntohl`, or `std::byteswap` in C++23) when serializing to the network.

> **🏭 Industry Note — Endianness in 2026:**
> Nearly every CPU you'll write code for in 2026 is little-endian (x86, x86-64, ARM in LE mode, RISC-V). The big-endian holdouts are mostly legacy mainframes and a few network protocols. **Network byte order is big-endian** by convention (TCP/IP, DNS, BGP), so anywhere data crosses the wire you must convert.
>
> ```cpp
> // Pre-C++23 idiom — POSIX functions
> uint32_t net = htonl(host_value);
> uint32_t host = ntohl(net_value);
>
> // C++23 idiom — language-level
> uint32_t net = std::byteswap(host_value);   // assuming you're on LE → BE conversion
> ```
>
> Get this wrong and you get **silent corruption** of arbitrary fields — usually noticed only when tests run on a different machine.

> **🎯 Mental Model — `int` is a bag of bits with a contract:**
> Fixed-width types make the contract explicit. `int32_t` means "I am exactly 32 bits, two's complement, native byte order." When you cross machine/network/file boundaries, all three properties matter — `int` gives you no guarantees, `int32_t` is portable, and `std::endian` / `htonl` make the byte order explicit too.

## 87. C-Style Bit Manipulation
*(Ep. 208)*

The bitwise operators carried over from C:

| Op | Meaning |
|----|---------|
| `&` | AND |
| `\|` | OR |
| `^` | XOR |
| `~` | NOT |
| `<<` | left shift |
| `>>` | right shift |

Common idioms:

```cpp
std::uint16_t flags = 0;
constexpr std::uint16_t SYN = 1u << 1;
constexpr std::uint16_t ACK = 1u << 4;

flags |= SYN;             // set bit
flags &= ~SYN;            // clear bit
flags ^= ACK;             // toggle bit
bool ack_set = flags & ACK;

// Extract a field — bits [3..6]
std::uint16_t field = (flags >> 3) & 0x0F;
```

### Watch out for precedence

```cpp
if (a & b == 0) { /* WRONG: parses as a & (b==0) */ }
if ((a & b) == 0) { /* RIGHT */ }
```

When in doubt, parenthesize. `==` binds tighter than `&` / `|` / `^`.

### Shifts and signed integers

`<<` and `>>` on signed types where the value is negative or where the shift amount equals or exceeds the bit-width is undefined behavior. Cast to unsigned for safe shifting.

## 88. `std::bitset`
*(Ep. 209)*

A fixed-size compile-time-known bit array with a friendly API.

```cpp
#include <bitset>
#include <iostream>

int main() {
    std::bitset<8> b{"10110010"};
    std::cout << b << '\n';                    // 10110010
    std::cout << b.count() << '\n';             // 4 (number of 1-bits)
    std::cout << b.size()  << '\n';             // 8
    std::cout << b.to_ulong() << '\n';          // 178

    b.set(0);                                   // set bit 0
    b.reset(7);                                 // clear bit 7
    b.flip();                                   // toggle all
    std::cout << b.test(3) << '\n';             // bool
    std::cout << b.any() << ' ' << b.all() << ' ' << b.none() << '\n';
}
```

Use `std::bitset` for fixed-size flag sets. For dynamic-sized bit collections, use `std::vector<bool>` (with caveats — it's a special non-container) or `boost::dynamic_bitset`.

## 89. `<bit>` Algorithms (C++20)
*(Ep. 210)*

C++20 added a header of bit-manipulation primitives that map to single CPU instructions on most platforms.

```cpp
#include <bit>
#include <cstdint>

std::uint32_t x = 0b00010110;

std::popcount(x);      // 3 — number of set bits (POPCNT)
std::countl_zero(x);    // 27 — leading zeros (LZCNT/CLZ)
std::countr_zero(x);    // 1  — trailing zeros (TZCNT/CTZ)
std::countl_one(x);     // 0
std::countr_one(x);     // 0
std::has_single_bit(x); // false (not a power of 2)
std::bit_width(x);      // 5  — number of bits needed
std::bit_floor(x);      // 16 — largest power-of-2 ≤ x
std::bit_ceil(x);       // 32 — smallest power-of-2 ≥ x
std::rotl(x, 2);        // rotate left
std::rotr(x, 2);        // rotate right
```

C++23 adds `std::byteswap(x)` — endianness conversion in one call.

```cpp
std::uint32_t host_order = 0x12345678;
auto network_order = std::byteswap(host_order);   // 0x78563412 on little-endian
```

For systems and networking code, these are the right tools — single-instruction performance with portable, well-defined semantics.

---


# Part VIII — Lambdas

## 90. Lambdas Part 1 — Closures
*(Ep. 100)*

A lambda expression creates an unnamed function object — a **closure**.

```cpp
auto greet = []() { std::cout << "hello\n"; };
greet();                                  // "hello"

auto add = [](int a, int b) { return a + b; };
std::cout << add(2, 3) << '\n';           // 5
```

Anatomy of a lambda:

```
[capture](parameters) [specifiers] -> return_type { body }
   |          |             |             |          |
   |          |             |             |          └─ what to do
   |          |             |             └─ optional, usually deduced
   |          |             └─ const / mutable / noexcept / constexpr
   |          └─ () can be omitted if no parameters and no specifiers
   └─ what to capture from enclosing scope
```

The compiler synthesizes a class with `operator()`. The two are equivalent:

```cpp
auto f = [](int x) { return x * 2; };

// Compiler-generated equivalent (roughly):
struct __lambda {
    int operator()(int x) const { return x * 2; }
};
__lambda f;
```

That's why lambdas can be passed wherever a callable is expected (STL algorithms, `std::function`, function pointer for capture-less lambdas).

> **🎯 Mental Model — A lambda is a struct + a constructor + an `operator()`:**
> ```cpp
> int n = 10;
> auto add_n = [n](int x) { return x + n; };
>
> // Compiler synthesizes roughly:
> struct __lambda_at_line_3 {
>     int n;                                     // captured by value
>     __lambda_at_line_3(int n_) : n(n_) {}
>     int operator()(int x) const { return x + n; }
> };
> auto add_n = __lambda_at_line_3{n};
> ```
> Everything about lambdas (captures, return type, why they can't be assigned to each other) falls out of this de-sugaring. When in doubt, mentally expand.

> **🏭 Industry Note — Lambdas killed `std::bind`:**
> Pre-C++11, `std::bind` was the way to partially apply functions:
> ```cpp
> auto add5 = std::bind(add, 5, std::placeholders::_1);   // old
> auto add5 = [](int x) { return add(5, x); };            // C++11+
> ```
> Lambdas are clearer, faster (no type erasure overhead), and more flexible. `std::bind` survives only in legacy code; clang-tidy's `modernize-avoid-bind` flags it. Don't reach for `bind` in 2026.

## 91. Lambdas Part 2 — The Capture
*(Ep. 102)*

The capture list determines which variables from the enclosing scope are accessible inside the lambda, and how.

```cpp
int x = 10, y = 20;

[]               // capture nothing
[x]              // capture x by value (copy)
[&x]             // capture x by reference (alias)
[x, &y]          // mixed
[=]              // capture all used by value
[&]              // capture all used by reference
[=, &y]          // all by value EXCEPT y by reference
[&, x]           // all by reference EXCEPT x by value
[i = 0]          // init-capture (C++14) — create i fresh inside lambda
[ptr = std::move(p)]  // move-into-lambda (C++14)
```

By-value captures are `const` inside the lambda by default. Add `mutable` to allow modification of the captured copy:

```cpp
auto counter = [n = 0]() mutable { return ++n; };
counter();   // 1
counter();   // 2
counter();   // 3
```

### Pointer capture trap

Capturing a raw pointer by value copies the *pointer*, not the *pointee*. The lambda can still access (or corrupt) the original data through it.

```cpp
int x = 42;
int* p = &x;
auto f = [p] { return *p; };   // p is a copy of the pointer — still points at x
x = 99;
f();   // 99 — lambda sees the new value through the pointer
```

If `x` dies before the lambda is called, the lambda has a dangling pointer. This is the same hazard as `[&]` but less obvious.

### Lifetime trap

By-reference captures dangle if the captured variable goes out of scope before the lambda is called.

```cpp
auto bad() {
    int x = 42;
    return [&] { return x; };          // x dies when bad() returns; ref dangles
}

auto good() {
    int x = 42;
    return [x] { return x; };          // x captured by value; safe
}
```

Default to value captures unless you specifically want reference semantics, and even then prefer naming the capture explicitly.

## 92. Lambdas Part 3 — Capturing `this`
*(Ep. 103)*

Inside a member function, `this` lets a lambda touch the enclosing object's members.

```cpp
class Worker {
    std::string name_;
    int         retries_ = 0;
public:
    Worker(std::string n) : name_(std::move(n)) {}

    auto make_logger() {
        return [this](std::string_view msg) {
            std::cout << '[' << name_ << "] " << msg << '\n';
        };
    }

    auto make_retrier() {
        return [this] { ++retries_; return retries_; };
    }
};
```

`[this]` captures the **pointer** — so the closure must not outlive the object.

If you want a copy of the object (safe even if the original dies):

```cpp
return [*this](std::string_view msg) {       // C++17 — capture *this by VALUE
    std::cout << '[' << name_ << "] " << msg << '\n';
};
```

In code that schedules lambdas onto threads or futures, `[*this]` (or capturing a `shared_ptr` to self via `enable_shared_from_this`) prevents use-after-free.

> **⚠️ Pitfall — Lambdas in Async / Threading:**
> **Never use `[&]` (catch-all by reference) if the lambda is passed to a thread, future, callback queue, or stored in a long-lived object.** The references will dangle the moment the enclosing scope exits — silent memory corruption that often surfaces minutes later in unrelated code.
>
> ```cpp
> // ❌ DANGEROUS — refs to local 'msg' dangle when this function returns
> void enqueue_log(const std::string& msg) {
>     pool.submit([&]{ write_log(msg); });
> }
>
> // ✅ Safe — capture by value (cheap for primitives, fine for small strings)
> void enqueue_log(std::string msg) {
>     pool.submit([msg = std::move(msg)]{ write_log(msg); });
> }
>
> // ✅ Safe — capture a shared_ptr by value, extending lifetime
> void enqueue_log(std::shared_ptr<std::string> msg) {
>     pool.submit([msg]{ write_log(*msg); });
> }
> ```
>
> **Industry standard:** for any callback that runs asynchronously, prefer explicit named captures, init-captures (`[msg = std::move(msg)]`), or capture a `std::shared_ptr` by value so the lambda owns a reference count to the resource.

> **🏭 Industry Note — `enable_shared_from_this` for member callbacks:**
> ```cpp
> // Asio-style: lambda runs later, on a different thread
> class Connection : public std::enable_shared_from_this<Connection> {
>     tcp::socket sock_;
> public:
>     void start_read() {
>         auto self = shared_from_this();           // keeps *this alive for the callback
>         sock_.async_read([self](auto err, auto bytes) {
>             self->handle(err, bytes);
>         });
>     }
> };
> ```
> The `enable_shared_from_this` + `shared_from_this()` pattern is **the** standard idiom for "this lambda outlives this scope" — used pervasively in Boost.Asio, gRPC, and modern coroutine code.

> **⚠️ Pitfall — Mutable lambdas and the `const`-by-default capture:**
> ```cpp
> int n = 0;
> auto increment = [n]() { return ++n; };   // ❌ ++n on a const captured copy → compile error
> auto incr_ok  = [n]() mutable { return ++n; };  // works; modifies the lambda's own copy
> ```
> By-value captures are `const` by default — adding `mutable` makes them assignable. Note: this still doesn't change the caller's `n`. For that, capture by reference.

> **🔬 Under the Hood — Lambdas with no captures are free function pointers:**
> ```cpp
> auto plain = [](int x) { return x + 1; };
> int (*fp)(int) = plain;                  // OK — implicitly convertible
>
> int n = 1;
> auto with_capture = [n](int x) { return x + n; };
> // int (*fp2)(int) = with_capture;       // ❌ stateful lambdas aren't convertible
> ```
> This matters for C interop: a capture-less lambda can be passed to a C callback that takes a function pointer. With captures, you need `std::function` (heap allocation) or a "user data" pointer pattern.

---

# Part IX — Templates and Generics

## 93. Templates Introduction
*(Ep. 71)*

A template is a recipe: parameterize a function or class over a type (or value), and the compiler generates a concrete version per instantiation.

```cpp
template <typename T>
T max_of(T a, T b) { return (a > b) ? a : b; }

max_of(1, 2);              // T = int
max_of(1.5, 2.5);          // T = double
max_of<std::string>("a", "b");  // explicit T
```

Each distinct `T` produces a separate function in the binary. That's why templates need to be visible (defined) where they're used — they're not compiled to object code until they're instantiated. **Templates live in headers.**

> **🎯 Mental Model — Templates are code generators, not generic types:**
> Unlike Java/C# generics (which use type erasure), C++ templates produce a fresh, fully-typed copy of code for each instantiation. `std::vector<int>` and `std::vector<std::string>` are entirely separate types with separately compiled code. Pros: zero runtime cost, full optimization. Cons: code bloat, slow compiles, brutal error messages.

> **🏭 Industry Note — Template compile-time costs are real:**
> - Heavy templates (Boost.Spirit, Eigen, expression templates) can double or triple compile times.
> - **`extern template`** lets you tell the compiler "don't instantiate here; trust me, it's done elsewhere," cutting duplicate work across TUs.
> - **Explicit instantiation** in a single `.cpp` plus `extern template` in the header is the standard technique for heavy generic libraries (e.g., libstdc++ does this for `std::basic_string<char>`).
> - **PCH** (precompiled headers) for common template-heavy includes can cut iterative builds by 30%+.

> **⚠️ Pitfall — Template error messages:**
> ```cpp
> std::sort(v.begin(), v.end(), [](auto a, auto b){ return a; });   // returns int, not bool
> ```
> The resulting error from libstdc++ can run hundreds of lines through STL internals. Modern tools that help:
> - **C++20 Concepts** (§104) — produce clean errors at the call site.
> - **`-fconcepts-diagnostics-depth=2`** (GCC) to cap recursive template error depth.
> - **clangd / clang-format / clang-tidy** — many errors get readable explanations.
> - **CppInsights.io** — shows the de-sugared instantiated code.

## 94. Function Templates
*(Eps. 72, 76)*

```cpp
template <typename T>
T square(T x) { return x * x; }

square(5);          // int → 25
square(2.5);        // double → 6.25
```

C++20 introduced **abbreviated function templates** using `auto` parameters:

```cpp
auto square2(auto x) { return x * x; }      // equivalent to template <typename T> T square2(T x)
```

### Mixed types and return type deduction (Ep. 76)

When combining two different types, `T` alone isn't enough — you need two type parameters, and the return type must adapt:

```cpp
// Naive: only works when A and B are the same type
template <typename T>
T multiply(T a, T b) { return a * b; }

// Better: two types, auto return deduced from the expression
template <typename A, typename B>
auto multiply(A a, B b) { return a * b; }

multiply(7.0f, 5);    // float * int → float (compiler deduces)
```

For C++11/14, use a **trailing return type** with `decltype` to express the same thing explicitly:

```cpp
template <typename A, typename B>
auto multiply(A a, B b) -> decltype(a * b) { return a * b; }
```

### Pass large template arguments by `const T&`

Template parameters are types — don't forget the same efficiency rules apply. For large objects (matrices, containers, strings) passed to template functions, always use `const T&` to avoid copies:

```cpp
template <typename T>
auto dot(const T& a, const T& b) { return a * b; }   // no copy of potentially large T
```

Primitives (int, double) are unaffected — the compiler may optimize the reference away. For small types, pass by value; for anything that could be large, pass by `const T&`.

Multiple parameters:

```cpp
template <typename A, typename B>
auto plus(A a, B b) { return a + b; }       // return type deduced

plus(1, 2.5);                                // int + double → double
```

## 95. Multiple and Non-Type Template Parameters
*(Ep. 73)*

Templates can have **value** parameters (constants known at compile time) in addition to types.

```cpp
template <typename T, std::size_t N>
struct fixed_array {
    T data[N];
    constexpr std::size_t size() const { return N; }
};

fixed_array<int, 16> a;        // T=int, N=16 — distinct type from fixed_array<int, 8>
```

`std::array` works exactly this way.

Non-type template parameters can be:
- Integral types and enumerations.
- Pointers to objects/functions.
- C++20: floating-point types and class types (with conditions).

## 96. Template Specialization
*(Ep. 74)*

Sometimes the generic implementation isn't right for a specific type.

### Full specialization

```cpp
template <typename T>
struct Printer {
    static void print(const T& v) { std::cout << v << '\n'; }
};

template <>                                       // full specialization for bool
struct Printer<bool> {
    static void print(bool v) { std::cout << (v ? "true" : "false") << '\n'; }
};

Printer<int>::print(42);        // 42
Printer<bool>::print(true);     // true (not 1)
```

### Partial specialization (class templates only)

```cpp
template <typename T> struct is_pointer            { static constexpr bool value = false; };
template <typename T> struct is_pointer<T*>        { static constexpr bool value = true;  };
template <typename T> struct is_pointer<const T*>  { static constexpr bool value = true;  };

static_assert( is_pointer<int*>::value);
static_assert(!is_pointer<int>::value);
```

That's the pattern that powers `<type_traits>`. Function templates can't be partially specialized — overload them instead.

### Specialization for floating-point equality

A practical use: the generic template uses `==`, which is wrong for floats. A specialization substitutes epsilon comparison:

```cpp
template <typename T>
bool almost_equal(T a, T b) { return a == b; }    // OK for integers

template <>
bool almost_equal<float>(float a, float b) {
    return std::abs(a - b) < 1e-6f;
}

template <>
bool almost_equal<double>(double a, double b) {
    return std::abs(a - b) < 1e-9;
}
```

The compiler uses your specialization when one exists; the generic template handles the rest.

## 97. Variadic Templates
*(Ep. 75)*

Variadic templates accept any number of types or values.

```cpp
#include <iostream>

void print() { std::cout << '\n'; }                // base case

template <typename T, typename... Rest>
void print(const T& first, const Rest&... rest) {  // pack expansion
    std::cout << first << ' ';
    print(rest...);
}

print(1, 2.5, "hello", 'c');     // 1 2.5 hello c
```

The `...` is the **parameter pack** notation:
- In template params: `typename... Ts` — a pack of types.
- In function params: `Ts... args` — a pack of values.
- In expressions: `args...` — pack expansion (apply pattern to each element).

C++17 added **fold expressions** that often replace recursion (section 106).

## 98. Class Templates
*(Ep. 77)*

```cpp
template <typename T>
class Stack {
    std::vector<T> v_;
public:
    void push(const T& x) { v_.push_back(x); }
    void push(T&& x)      { v_.push_back(std::move(x)); }
    void pop()            { v_.pop_back(); }
    T&   top()            { return v_.back(); }
    bool empty() const    { return v_.empty(); }
};

Stack<int> s;
s.push(1); s.push(2);
```

Out-of-class member definitions need the template prefix repeated:

```cpp
template <typename T>
void Stack<T>::push(const T& x) { v_.push_back(x); }
```

## 99. Class Templates with Static Data Members
*(Ep. 78)*

A class template's static data is **per instantiation** — `Foo<int>::counter` and `Foo<double>::counter` are separate variables.

```cpp
template <typename T>
class Counted {
    inline static int s_count = 0;        // C++17: define inline in header
public:
    Counted()  { ++s_count; }
    ~Counted() { --s_count; }
    static int count() { return s_count; }
};

Counted<int>     a, b;          // Counted<int>::count() == 2
Counted<double>  x;             // Counted<double>::count() == 1
                                // Independent counters per type
```

## 100. CTAD — Class Template Argument Deduction
*(Ep. 79)*

C++17 lets the compiler deduce a class template's arguments from the constructor call.

```cpp
std::vector v{1, 2, 3};         // std::vector<int>
std::pair   p{1, 2.5};          // std::pair<int, double>
std::array  a{1.0, 2.0};        // std::array<double, 2>
```

For your own types, you can write **deduction guides** when the rules need a hint:

```cpp
template <typename T>
struct Wrapper {
    T value;
};

// Deduction guide
template <typename T> Wrapper(T) -> Wrapper<T>;

Wrapper w{42};                  // Wrapper<int>
```

## 101. Template Class Default Parameters
*(Ep. 81)*

Like function parameters, template parameters can have defaults.

```cpp
template <typename T = int, std::size_t N = 4>
struct SmallVec {
    T data[N];
};

SmallVec<>                  v1;         // T=int, N=4
SmallVec<double>            v2;         // T=double, N=4
SmallVec<double, 8>         v3;         // T=double, N=8
```

The standard library uses this for allocators (`std::vector<T, Allocator = std::allocator<T>>`), comparators (`std::set<T, Compare = std::less<T>>`), and hash functions.

## 102. `if constexpr`, Type Traits, Free Functions
*(Ep. 214)*

`if constexpr` is a compile-time `if`: only the chosen branch is compiled.

```cpp
#include <type_traits>

template <typename T>
auto stringify(const T& x) {
    if constexpr (std::is_arithmetic_v<T>) {
        return std::to_string(x);
    } else if constexpr (std::is_same_v<T, std::string>) {
        return x;
    } else {
        return std::string{x};                 // hope this works for char*
    }
}
```

The branch not taken doesn't even need to be valid for the given `T` — perfect for handling heterogeneous types.

### Useful traits in `<type_traits>`

| Trait | Meaning |
|-------|---------|
| `is_integral_v<T>` | T is integer-like |
| `is_floating_point_v<T>` | T is float/double/long double |
| `is_arithmetic_v<T>` | integral or float |
| `is_same_v<T, U>` | exact match |
| `is_base_of_v<B, D>` | B is a base of D |
| `is_pointer_v<T>` | T is a pointer |
| `is_reference_v<T>` | T is a reference |
| `is_const_v<T>` | T is const |
| `remove_reference_t<T>` | strip & and && |
| `remove_cv_t<T>` | strip const/volatile |
| `decay_t<T>` | what auto-deduction would give |

### Prefer free functions

A common video-Mike refrain: **prefer free non-friend non-member functions over member functions** when possible. They:
- Don't increase the public class surface area.
- Compose better with overloading and ADL.
- Apply uniformly to types you don't own.

## 103. SFINAE
*(Ep. 215)*

**Substitution Failure Is Not An Error** — if substituting template arguments produces an invalid type *somewhere in the function signature*, the candidate is silently dropped from overload resolution rather than producing a hard error.

Pre-C++20 example using `std::enable_if`:

```cpp
#include <type_traits>

template <typename T,
          std::enable_if_t<std::is_integral_v<T>, int> = 0>
T half(T x) { return x / 2; }

template <typename T,
          std::enable_if_t<std::is_floating_point_v<T>, int> = 0>
T half(T x) { return x * 0.5; }

half(10);       // calls integral version
half(3.14);     // calls floating-point version
half("hi");     // ❌ neither candidate viable — clear error
```

The error messages SFINAE produces are notoriously ugly. Concepts (next section) replace most SFINAE in modern code.

## 104. C++20 Concepts
*(Eps. 216–220, 224)*

Concepts are named, composable predicates over types. They replace SFINAE with self-documenting constraints and produce vastly better error messages.

### Using a standard concept (Ep. 216)

```cpp
#include <concepts>

template <std::integral T>
T square(T x) { return x * x; }

square(5);          // OK
// square(3.14);    // ❌ — concept not satisfied; clean error message
```

### Defining your own concept (Ep. 217)

```cpp
template <typename T>
concept Numeric = std::integral<T> || std::floating_point<T>;

template <Numeric T>
T cube(T x) { return x * x * x; }
```

### Concept for optimization — pass big types by ref (Ep. 218)

```cpp
template <typename T>
concept Big = sizeof(T) > 16;

template <typename T>
auto process(const T& x) requires Big<T>;

template <typename T>
auto process(T x) requires (!Big<T>);
```

The compiler picks the more-constrained overload. The right calling convention for the size happens automatically.

### `requires` expressions — check for member existence (Ep. 219)

```cpp
template <typename T>
concept HasValueType = requires {
    typename T::value_type;
};

template <typename T>
concept Sizeable = requires(T x) {
    { x.size() } -> std::convertible_to<std::size_t>;
};

template <Sizeable T>
void log_size(const T& c) { std::cout << c.size() << '\n'; }
```

A `requires` expression is a compile-time check: every "requirement" in the body must be valid.

### Concepts with `if constexpr` (Ep. 224)

You can mix concepts and `if constexpr` to dispatch within a single template:

```cpp
template <typename T>
auto stringify(const T& x) {
    if constexpr (std::integral<T>) {
        return std::to_string(x);
    } else if constexpr (std::ranges::range<T>) {
        std::string s = "[";
        for (auto&& e : x) s += std::to_string(e) + ',';
        s += ']';
        return s;
    } else {
        return std::string{x};
    }
}
```

### Standard concepts you'll meet

`std::same_as`, `std::derived_from`, `std::convertible_to`, `std::integral`, `std::signed_integral`, `std::floating_point`, `std::equality_comparable`, `std::totally_ordered`, `std::movable`, `std::copyable`, `std::regular`, `std::predicate`, plus iterator and range concepts (`std::input_iterator`, `std::random_access_iterator`, `std::ranges::range`, …).

> **🎯 Mental Model — Concepts = compile-time interfaces:**
> A concept is what a *Java interface* would be if it could express "T has a member function called `size()` that returns something convertible to `size_t`" without requiring T to inherit from anything. Compile-time duck typing with great error messages.

> **🏭 Industry Note — Concepts adoption (2026):**
> - **Standard library:** ranges, atomics, formatters use concepts extensively.
> - **fmt, range-v3, GSL:** all adopted.
> - **Boost:** in transition.
> - **Game engines:** mostly C++17, so SFINAE still dominates.
> - **Existing template-heavy codebases:** rewriting SFINAE → concepts is gradual; both coexist for years.
>
> **For new code, use concepts.** They're better in every way that matters.

> **⚖️ Tradeoff — Concepts vs `if constexpr` vs SFINAE:**
> - **Concepts**: best error messages, clean syntax, requires C++20.
> - **`if constexpr`**: stays inside a single function body — great for compile-time branching but doesn't disable overloads.
> - **SFINAE / `enable_if`**: works back to C++11, ugly, terrible errors, but universal compatibility.

## 105. Template Metaprogramming: type_traits, enable_if
*(Eps. 221–223)*

Template metaprogramming (TMP) is "compute on types at compile time." Pre-concepts, the toolset was `<type_traits>` + `enable_if` + recursion.

### Type traits as compile-time values (Ep. 221)

```cpp
#include <type_traits>

static_assert( std::is_integral_v<int>);
static_assert(!std::is_integral_v<double>);
static_assert( std::is_same_v<int, std::int32_t>);    // platform-dependent
```

### `enable_if` (Ep. 222)

The pre-concepts way to constrain templates:

```cpp
template <typename T>
typename std::enable_if<std::is_integral_v<T>, T>::type
abs_value(T x) { return x < 0 ? -x : x; }
```

In C++17+ this is usually written with `_t` and `_v` shortcuts:

```cpp
template <typename T>
std::enable_if_t<std::is_integral_v<T>, T>
abs_value(T x) { return x < 0 ? -x : x; }
```

### `if constexpr` to replace SFINAE (Ep. 223)

For function bodies, `if constexpr` is almost always cleaner than `enable_if`:

```cpp
template <typename T>
T abs_value(T x) {
    if constexpr (std::is_signed_v<T>)
        return x < 0 ? -x : x;
    else
        return x;          // unsigned — already nonnegative
}
```

For overload selection (where you want different signatures), use concepts in C++20+.

## 106. Fold Expressions and Parameter Packs
*(Ep. 245)*

C++17 fold expressions collapse a parameter pack with a binary operator.

```cpp
template <typename... Ts>
auto sum(Ts... xs) { return (xs + ...); }            // unary right fold

template <typename... Ts>
auto sum_init(Ts... xs) { return (0 + ... + xs); }   // binary left fold with init

template <typename... Ts>
void print_all(Ts&&... xs) {
    ((std::cout << std::forward<Ts>(xs) << ' '), ...);   // comma fold
    std::cout << '\n';
}

sum(1, 2, 3, 4);              // 10
sum_init();                    // 0  — works on empty pack
print_all("hi", 42, 3.14);    // hi 42 3.14
```

| Form | Expansion |
|------|-----------|
| `(... op pack)` | unary left fold: `((p1 op p2) op p3) op p4` |
| `(pack op ...)` | unary right fold: `p1 op (p2 op (p3 op p4))` |
| `(init op ... op pack)` | binary left fold |
| `(pack op ... op init)` | binary right fold |

Fold expressions are the readable replacement for the recursive variadic-template patterns of C++11/14.

---


# Part X — STL Containers

## 107. STL Overview
*(Ep. 111)*

The Standard Template Library has three orthogonal pieces:

- **Containers** — generic data structures (`vector`, `list`, `map`, …).
- **Iterators** — generic pointers; the glue between containers and algorithms.
- **Algorithms** — generic operations (`find`, `sort`, `transform`, …) that take iterator pairs.

The whole point: an algorithm is written **once** against iterators, and works with **every** container that exposes those iterators. That orthogonality is the design genius of the STL.

| Category | Examples |
|----------|----------|
| Sequence | `array`, `vector`, `deque`, `list`, `forward_list`, `string` |
| Associative (sorted, tree-based) | `set`, `map`, `multiset`, `multimap` |
| Unordered (hash-based) | `unordered_set`, `unordered_map`, `unordered_multiset`, `unordered_multimap` |
| Container adapters | `stack`, `queue`, `priority_queue` |
| Special | `bitset`, `pair`, `tuple`, `optional`, `variant`, `any`, `span` |

## 108. `std::string`, `char*`, String Literals
*(Ep. 112)*

Three things people call "strings" in C++:

| Type | What it is | Owns memory |
|------|-----------|-------------|
| `const char*` | C-style; null-terminated; pointer to bytes | No |
| `char[]` (literal) | A null-terminated array of `char` | The literal storage |
| `std::string` | Owning, growable, null-terminated string class | Yes |

```cpp
const char*  c    = "hello";              // C string
std::string  s    = "hello";              // std::string (constructs from C string)
auto         lit  = "hello";              // const char* by default
auto         sstr = "hello"s;             // std::string literal — needs `using namespace std::string_literals;`

s += " world";                             // grows
std::cout << s.size() << '\n';
```

`std::string` is small-buffer-optimized in most implementations: short strings live inline, no heap allocation. Concatenation, slicing, comparison, find-replace are all O(n) and ergonomic. Like `vector`, it pre-allocates capacity beyond current size to amortize reallocations.

**`find()` returns `npos`, not a `bool`:**

```cpp
std::string s = "hello world";
auto pos = s.find("world");

// WRONG — compiles silently, always true (npos is size_t max value, non-zero)
if (pos) { std::cout << "found\n"; }

// CORRECT
if (pos != std::string::npos) { std::cout << "found at " << pos << '\n'; }
```

`std::string::npos` is `std::size_t(-1)` — the largest `size_t` value. Always compare against it explicitly.

## 109. `std::string_view` (C++17)
*(Ep. 113)*

A non-owning, read-only view of a contiguous character sequence. Cheap to copy (it's a pointer + size).

```cpp
#include <string_view>

void log(std::string_view msg) {           // accepts std::string, char*, "literal", char[]
    std::cout << msg << '\n';
}

log("literal");
log(std::string{"owned"});
log("test"sv);                              // std::string_view literal
```

Why use it:
- Read-only string parameters cost nothing.
- Substringing is O(1) — no allocation, just a pointer and a size.

The big trap: `string_view` does not own its data. It must not outlive the source.

```cpp
std::string_view bad() {
    std::string s = "danger";
    return s;                              // returns string_view to local string — UB
}

std::string make_msg();
std::string_view t = make_msg();           // dangling — temporary destroyed at ;
```

Rule of thumb: use `string_view` for **parameters**, not for **storage** or **return values**.

## 110. `std::array`
*(Ep. 114)*

Fixed-size array with the STL interface. Same memory layout and overhead as `T[N]`.

```cpp
#include <array>

std::array<int, 5> a = {1, 2, 3, 4, 5};

a.size();                                   // 5 (compile-time constant)
a.front(); a.back();
a.fill(0);
std::sort(a.begin(), a.end());
```

CTAD (Ep. 79) lets you skip the size:

```cpp
std::array b = {1, 2, 3};                   // std::array<int, 3>
```

Use `std::array` instead of `T[N]` everywhere.

## 111. `std::span` (C++20)
*(Ep. 115)*

A non-owning view over a contiguous sequence of elements. The "view sibling" of `std::vector`/`std::array`/raw arrays — what `string_view` is to strings.

```cpp
#include <span>

void sum(std::span<const int> data) {
    int total = 0;
    for (int x : data) total += x;
    std::cout << total << '\n';
}

int                 a[5] = {1,2,3,4,5};
std::array<int, 3>  b    = {10, 20, 30};
std::vector<int>    c    = {7, 7, 7, 7};

sum(a);                  // OK
sum(b);                  // OK
sum(c);                  // OK
sum({c.data(), 2});      // first two elements only
```

Use `std::span<const T>` whenever you want to write a function that takes "any contiguous sequence of T" without templates. Same dangling-lifetime caveat as `string_view`: don't store; don't outlive.

## 112. `std::vector`
*(Ep. 116)*

The default container. A dynamic, contiguous array.

```cpp
#include <vector>

std::vector<int> v;
v.reserve(1000);                            // pre-allocate to avoid reallocations
v.push_back(1);
v.push_back(2);
v.emplace_back(3);                           // construct in place

v.size();          v.capacity();
v.front();         v.back();
v[0];              v.at(0);                 // at() throws on out-of-range

v.insert(v.begin() + 1, 99);
v.erase(v.begin());
v.clear();
```

### Capacity vs size

`size()` is the count of elements; `capacity()` is the allocated room. When `size == capacity` and you push, the vector reallocates (typically doubling), copying or moving every element. **`reserve(n)`** up front when you know `n`.

### Iterator invalidation — common trap

Any insertion or erasure can invalidate iterators. Erasing inside a range-based `for` is undefined behavior.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};

// WRONG — erase invalidates the iterator; range-for internal iterator is now dangling
for (auto& x : v) {
    if (x % 2 == 0) v.erase(&x);   // UB
}

// CORRECT — erase returns the next valid iterator
for (auto it = v.begin(); it != v.end(); ) {
    if (*it % 2 == 0) it = v.erase(it);
    else ++it;
}
// Or use the erase-remove idiom (§136)
```

Any `push_back`/`emplace_back` that triggers a reallocation also invalidates all iterators, pointers, and references into the vector.

### When to use vector

- **Default for "I need a list of things".**
- Best cache locality of any standard container — contiguous memory.
- `O(1)` random access; `O(1) amortized` push_back; `O(n)` insert in the middle.
- Use `unique_ptr` storage if the element type is incomplete or you need stable addresses (vector reallocates).

> **🔬 Under the Hood — Vector growth strategy:**
> When `size == capacity` and you push, the implementation allocates a new buffer, moves/copies elements, and frees the old. Typical growth factor: 1.5× (MSVC) or 2× (libstdc++, libc++). Why a factor and not +1?
> - Linear growth → O(n²) total work for n pushes.
> - Exponential growth → O(n) amortized work (Bjarne's classic analysis).
> - 1.5× lets old buffers be reusable; 2× is simpler but wastes more memory.
>
> **Always `reserve()` when you know the final size**: skips all reallocations, halves memory peak.

> **🏭 Industry Note — When vector is the wrong default:**
> Vector is the default, but there are clear cases for alternatives:
> - **Iterator/pointer stability matters?** → `std::list` or `std::deque`.
> - **Always small (≤16 elements)?** → `boost::container::small_vector`, `absl::InlinedVector` — no heap allocation for small sizes.
> - **Insertion in middle is common?** → `std::list` (O(1) with iterator).
> - **Need set semantics?** → `std::flat_set` (C++23), `boost::flat_set`, or `absl::btree_set`. Often faster than `std::set` because contiguous.
> - **High-throughput message queue?** → ring buffer (custom), `boost::lockfree::queue`.

> **⚠️ Pitfall — `vector<bool>` is special and bad:**
> `std::vector<bool>` is NOT a normal container — it packs bits to save space, returning a proxy reference. This breaks generic code:
> ```cpp
> std::vector<bool> v = {true, false};
> auto& b = v[0];        // b is a proxy reference, NOT bool& — confusing!
> for (auto x : v) ...   // x is proxy, can't take address
> ```
> Use `std::vector<char>`, `std::bitset<N>`, `boost::dynamic_bitset`, or `std::deque<bool>` instead.

## 113. `std::list`
*(Ep. 118)*

Doubly-linked list. Use case is narrow:

- Constant-time insert/erase **anywhere** given an iterator.
- Iterators not invalidated by inserts/erases elsewhere in the list.

Costs:
- Each node = a separate heap allocation. Bad cache locality.
- No random access (`v[3]` doesn't exist).
- Each node carries two extra pointers (prev/next).

```cpp
std::list<int> l = {1, 2, 3};
auto it = std::next(l.begin());
l.insert(it, 99);             // {1, 99, 2, 3}, O(1)
l.erase(it);                  // {1, 99, 3}
l.splice(l.end(), other);     // O(1) move all of `other` to end of l
```

`std::list::splice` is the unique selling point — moving subsequences between lists in `O(1)`. If you don't need that and aren't in a "I do millions of mid-list inserts on huge sequences" workflow, **use `std::vector`** even when textbooks tell you "use a list."

## 114. `std::forward_list`
*(Ep. 119)*

Singly-linked list. Smaller per-node overhead than `std::list` (one pointer instead of two), but loses bidirectional iteration.

```cpp
#include <forward_list>

std::forward_list<int> f = {1, 2, 3};
f.push_front(0);                            // O(1)
f.insert_after(f.begin(), 99);              // insert_after, not insert
```

Niche: extremely memory-constrained scenarios where every byte matters and you only need forward traversal. Otherwise, almost never used in modern code.

## 115. `std::deque`
*(Ep. 120)*

**D**ouble-**e**nded **que**ue. Random access in O(1) like `vector`, plus O(1) `push_front`. Implementation: chunked storage (an array of arrays).

```cpp
#include <deque>

std::deque<int> dq;
dq.push_front(1);             // unlike vector
dq.push_back(2);
dq[0];                         // random access OK
```

Trade-offs vs `vector`:
- O(1) push_front — the headline feature.
- Slightly worse cache locality (chunked, not fully contiguous).
- Insertion in the middle is O(n) like vector.
- Iterators *can* be invalidated by inserts at either end (unlike `list`).

The default underlying container for `std::stack` and `std::queue` is `std::deque`.

## 116. Sets
*(Eps. 121, 122, 123, 124)*

A set is a collection of **unique** keys. Two flavors:

| | **Sorted (tree)** | **Unordered (hash)** |
|---|---|---|
| Unique keys | `std::set` | `std::unordered_set` |
| Duplicates allowed | `std::multiset` | `std::unordered_multiset` |
| Order | Sorted by `<` (or custom Compare) | None — bucket order |
| Lookup | O(log n) | O(1) average, O(n) worst |
| Memory | Lower | Higher (buckets + load factor) |
| Iterator stability | Stable on insert/erase | Stable on erase; **not** on rehash |
| Custom key | Compare | Hash + equality |

```cpp
#include <set>
#include <unordered_set>

std::set<int> s = {3, 1, 4, 1, 5};          // {1, 3, 4, 5} — duplicates dropped, sorted
s.insert(9);
s.contains(4);                               // C++20 — true
s.find(2) == s.end();                        // true (not found)
auto [lo, hi] = s.equal_range(4);            // for multiset variants

std::unordered_set<std::string> us = {"a","b","c"};
us.insert("d");
us.erase("b");
```

### Custom comparators (Ep. 123)

```cpp
struct Order { int id; double price; };
struct ByPrice {
    bool operator()(const Order& a, const Order& b) const {
        return a.price < b.price;             // strict weak ordering
    }
};

std::multiset<Order, ByPrice> book;           // sorted by price; duplicates allowed
book.insert({1, 100.0});
book.insert({2, 100.0});                      // OK in multiset
```

### Custom hash (Ep. 124)

```cpp
struct Pair { int a, b; };

struct PairHash {
    std::size_t operator()(const Pair& p) const noexcept {
        return std::hash<int>{}(p.a) ^ (std::hash<int>{}(p.b) << 1);
    }
};
struct PairEq {
    bool operator()(const Pair& x, const Pair& y) const noexcept {
        return x.a == y.a && x.b == y.b;
    }
};

std::unordered_set<Pair, PairHash, PairEq> us;
```

For better hash quality, look at `boost::hash_combine` or implement combining via `std::hash` on a tuple.

## 117. `std::pair`, `std::ref`, `std::get`
*(Ep. 125)*

`std::pair<T1, T2>` is a two-tuple.

```cpp
#include <utility>

std::pair<std::string, int> p{"alice", 30};
std::cout << p.first << ' ' << p.second << '\n';

auto p2 = std::make_pair("bob", 42);          // CTAD makes make_pair largely obsolete
std::pair p3{"charlie", 99};                   // C++17 CTAD

// Structured bindings (C++17)
auto [name, age] = p;
```

`std::tuple<T...>` generalizes pair to any arity.

### `std::get`

Index-based or type-based access:

```cpp
auto t = std::make_tuple(1, "hi", 3.14);
std::get<0>(t);            // 1
std::get<std::string>(p2); // throws if not exactly one std::string in the tuple/pair
```

### `std::ref` / `std::cref`

Wrap a reference so it can be stored or passed where copies are expected (e.g. `std::make_pair`, `std::thread`, `std::bind`):

```cpp
int n = 0;
auto pair = std::make_pair(std::ref(n), 42);   // pair holds a reference_wrapper, not a copy
pair.first.get() = 7;
std::cout << n << '\n';                         // 7
```

## 118. Maps
*(Eps. 126, 128, 129, 130)*

Same dichotomy as sets, but keys map to values.

| | **Sorted (tree)** | **Unordered (hash)** |
|---|---|---|
| Unique keys | `std::map` | `std::unordered_map` |
| Duplicate keys | `std::multimap` | `std::unordered_multimap` |

```cpp
#include <map>
#include <unordered_map>

std::map<std::string, int> ages = {{"alice", 30}, {"bob", 42}};
ages["charlie"] = 25;                            // [] inserts default-constructed value if missing
ages.at("alice") += 1;                           // throws on missing — preferred lookup

if (auto it = ages.find("dora"); it != ages.end()) {
    std::cout << it->second;
} else {
    std::cout << "missing\n";
}

if (ages.contains("eve")) { /* C++20 */ }

// C++17 try_emplace + insert_or_assign — explicit semantics
ages.try_emplace("frank", 50);                    // does NOT overwrite
ages.insert_or_assign("alice", 31);               // overwrites
```

### Multimap with `equal_range` (Ep. 128)

```cpp
std::multimap<std::string, int> grades;
grades.insert({"alice", 90});
grades.insert({"alice", 85});
grades.insert({"bob",   75});

auto [first, last] = grades.equal_range("alice");
for (auto it = first; it != last; ++it)
    std::cout << it->second << '\n';              // 90, 85
```

### Performance
- `std::map` — O(log n), red-black tree, ordered iteration, predictable.
- `std::unordered_map` — O(1) average, hashtable, no order. Beware: **terrible** worst-case if your hash collides badly.

For network/protocol code with adversarial input, prefer `std::map` (or `absl::flat_hash_map` etc.) since `unordered_map` is vulnerable to hash-collision DoS.

> **🏭 Industry Note — `std::unordered_map` is rarely the fastest:**
> The STL's `unordered_map` uses **chained hashing** (linked list per bucket) — pointer chasing, poor cache behavior. The industry-favored alternatives:
> | Container | When |
> |---|---|
> | `absl::flat_hash_map` (Abseil) | General purpose; ~2× faster than `std::unordered_map` |
> | `tsl::robin_map` (tessil) | Lower memory; great for lookups |
> | `boost::unordered_flat_map` (Boost 1.81+) | Flat layout, drop-in replacement |
> | `folly::F14ValueMap` | Meta's tuned hash map |
> | `phmap::flat_hash_map` (parallel_hashmap) | Lock-free sharded variant |
>
> If your hash map is in the hot path, profile against one of these. The STL one is "correct but slow" — kept for API stability.

> **⚠️ Pitfall — Iterator invalidation in maps:**
> | Operation | `std::map` (tree) | `std::unordered_map` (hash) |
> |---|---|---|
> | `insert` | nothing invalidated | All iterators if rehash; pointers stable |
> | `erase(it)` | only `it` | only `it` |
> | `find(k)` returning end() | safe, no invalidation | safe |
>
> Storing `map::iterator` long-term in tree-based maps is safe; in hash maps it's a bomb waiting for the next insert that triggers rehash.

## 119. Container Adapters
*(Eps. 131, 132, 133)*

Adapters wrap an underlying container with a restricted API.

### `std::stack` (Ep. 131) — LIFO

```cpp
#include <stack>

std::stack<int> s;
s.push(1); s.push(2); s.push(3);
s.top();                          // 3
s.pop();
```

### `std::queue` (Ep. 132) — FIFO

```cpp
#include <queue>

std::queue<int> q;
q.push(1); q.push(2);
q.front();                        // 1
q.back();                         // 2
q.pop();
```

### `std::priority_queue` (Ep. 133) — heap-based

By default, a max-heap (largest on top).

```cpp
std::priority_queue<int> pq;
pq.push(3); pq.push(1); pq.push(4);
pq.top();                          // 4

// Min-heap with std::greater
std::priority_queue<int, std::vector<int>, std::greater<>> minpq;
minpq.push(3); minpq.push(1); minpq.push(4);
minpq.top();                       // 1
```

`priority_queue` is implemented on top of a vector + heap algorithms; `make_heap`/`push_heap`/`pop_heap` (section 147) give you the same operations on any random-access range.

## 120. Container High-Level Review
*(Ep. 134)*

When in doubt, decide in this order:

1. **Default to `std::vector`.** It's almost always right.
2. Need fast key lookup? **`std::unordered_map`** (or `std::map` if you also need ordered iteration, range queries, or are exposed to adversarial inputs).
3. Need only the ends? **`std::deque`** for both ends, or stick with `vector` if only the back matters.
4. Need uniqueness? **`std::unordered_set`** (or `std::set`).
5. LIFO/FIFO? **`std::stack`** / **`std::queue`**.
6. Highest-priority element? **`std::priority_queue`**.
7. Stable iterators across mid-sequence inserts? **`std::list`** — but justify it.
8. Fixed compile-time size? **`std::array`**.

Cache locality matters more than asymptotic complexity for small/medium sizes. A `vector` linear scan beats a `list` walk up to surprisingly large N in practice.

> **🏭 Industry Note — Bjarne's "Why you should avoid linked lists" talk:**
> Bjarne ran a benchmark inserting random integers, keeping them sorted, then removing them. He varied N from 100 to 1,000,000 across `std::vector` and `std::list`:
> - **`std::vector` was faster at every size**, often by 10-100×.
> - The Big-O analysis (O(n) for vector insert, O(log n) for binary tree + O(1) for list erase) said list should win.
> - **Cache misses** dominated. Walking a linked list is a series of random memory accesses; walking a vector is sequential.
>
> Takeaway: **trust measurements over textbook complexity** for modern hardware. Default to vector; reach for list/map only when profiling proves you need them.

> **🎯 Mental Model — The container choice flowchart:**
> ```
> Need ordered, scannable list?    → std::vector
> Need fast key→value lookup?      → absl::flat_hash_map (or std::unordered_map)
> Need ordered keys + range queries? → std::map (std::flat_map in C++23)
> Need uniqueness?                  → std::unordered_set / std::set
> Need LIFO / FIFO?                 → std::stack / std::queue (on std::deque)
> Need top-K queries?               → std::priority_queue
> Need exactly N at compile time?   → std::array<T, N>
> Need bounded buffer + indexing?   → boost::circular_buffer, or just std::vector
> Need O(1) push_front?             → std::deque
> ```

## 121. `union`s
*(Ep. 83)*

A `union` is a class type whose members **share the same storage**. Only one member is active at a time.

```cpp
union Bytes {
    std::uint32_t u;
    float         f;
    char          b[4];
};

Bytes x;
x.u = 0x40490FDB;          // ~pi as IEEE 754 float
// Reading x.f after writing x.u is UB in C++ (allowed in C).
```

Modern C++ verdict: **avoid raw unions in application code.** They predate sound type discrimination and require manual lifetime management for nontrivial members. Use `std::variant` instead (next section).

Unions still have a place in low-level systems code: hardware registers with multiple views, careful protocol parsing within `char`/`std::byte` aliases.

## 122. `std::variant`
*(Ep. 84)*

C++17's tagged union: a type-safe sum type.

```cpp
#include <variant>
#include <iostream>
#include <string>

std::variant<int, double, std::string> v = 42;
v = 3.14;
v = std::string{"hello"};

std::cout << v.index() << '\n';                  // 2 (string is index 2)

if (std::holds_alternative<std::string>(v))
    std::cout << std::get<std::string>(v) << '\n';
```

The killer feature is `std::visit`:

```cpp
std::visit([](auto&& x) {
    std::cout << x << '\n';                      // calls correct operator<< per type
}, v);

// Or with multiple overloads via lambda overload set:
struct Visitor {
    void operator()(int n)               { std::cout << "int " << n << '\n'; }
    void operator()(double d)            { std::cout << "double " << d << '\n'; }
    void operator()(const std::string& s){ std::cout << "string " << s << '\n'; }
};
std::visit(Visitor{}, v);
```

Why it's powerful:
- Compile-time exhaustiveness checking — visit every alternative or you get a compile error.
- No vtables — dispatch is via index lookup, often inlinable.
- Total memory: `max(sizeof(alternatives)) + small index`.

For "this OR that" data — message types, parser AST nodes, network packet variants — `std::variant` is usually a better answer than an inheritance hierarchy.

> **🎯 Mental Model — `std::variant` is C++'s tagged union / sum type:**
> If you've used Rust enums, OCaml variants, TypeScript union types — `std::variant` is the same idea. The compiler knows the alternatives; `std::visit` forces you to handle each. No vtable, no inheritance, no dynamic_cast.

> **🏭 Industry Note — When variant beats inheritance:**
> | Inheritance | `std::variant` |
> |---|---|
> | Open set (anyone can derive later) | Closed set (you list every alternative) |
> | Heap allocation usually required | Stack-allocated (size = max(alternatives)) |
> | Virtual dispatch (vtable lookup) | Static dispatch (jump table or `if` chain) |
> | New derived class doesn't require recompile | New alternative requires recompile of all `visit`s |
> | Exhaustiveness not checked | `visit` enforces all alternatives handled |
>
> **Variant wins** for: AST nodes, parser tokens, state machines, message types, network packets.
> **Inheritance wins** for: plugin systems, GUI widget hierarchies, anything where the set genuinely extends at runtime.

```cpp
// Network message variant
struct ConnectMsg    { std::string addr; int port; };
struct DisconnectMsg { int code; };
struct DataMsg       { std::vector<std::byte> payload; };

using Msg = std::variant<ConnectMsg, DisconnectMsg, DataMsg>;

void handle(const Msg& m) {
    std::visit([](auto&& x) {
        using T = std::decay_t<decltype(x)>;
        if constexpr (std::is_same_v<T, ConnectMsg>)        { /* ... */ }
        else if constexpr (std::is_same_v<T, DisconnectMsg>){ /* ... */ }
        else if constexpr (std::is_same_v<T, DataMsg>)      { /* ... */ }
    }, m);
}
```

---

# Part XI — STL Iterators

## 123. Iterators: Introduction
*(Ep. 135)*

An iterator is a generic pointer — an object that yields elements one at a time when you `++` it and read with `*`. STL containers expose iterators via `begin()` and `end()`, where `end()` is one **past** the last element.

```cpp
std::vector<int> v = {1, 2, 3};

for (auto it = v.begin(); it != v.end(); ++it) {
    std::cout << *it << ' ';
}
```

A range `[first, last)` is **half-open** — `first` included, `last` excluded. This is so that empty ranges (`first == last`) are natural and `last - first` gives the count.

Iterator forms you'll see:
- `begin()` / `end()` — read/write
- `cbegin()` / `cend()` — `const`
- `rbegin()` / `rend()` — reverse
- `crbegin()` / `crend()` — const reverse

## 124. Iterator Categories
*(Ep. 136)*

Different containers expose different iterator capabilities. Algorithms specify their requirements via iterator categories.

| Category | Operations |
|----------|-----------|
| **Input** | `*it` (read), `++it`, comparable. Single-pass. |
| **Output** | `*it = x`, `++it`. Single-pass. |
| **Forward** | Like input/output but multi-pass. |
| **Bidirectional** | Forward + `--it` |
| **Random access** | Bidirectional + `it + n`, `it - it`, `it[n]`, comparison `<`/`>` |
| **Contiguous** *(C++17)* | Random access + memory contiguity |

Container → iterator category:

| Container | Category |
|-----------|----------|
| `array`, `vector`, `string`, `span` | Contiguous |
| `deque` | Random access |
| `list`, `set`, `map`, `multiset`, `multimap` | Bidirectional |
| `forward_list`, `unordered_*` | Forward |

If an algorithm says "requires random-access iterators" (like `std::sort`), passing a `std::list::iterator` won't compile — and there's a good reason. `list` provides `list::sort()` as a member precisely because the generic algorithm can't be written efficiently for non-random-access iterators.

## 125. Range-Access Functions
*(Ep. 137)*

C++11 added free functions in `<iterator>` that work on **anything** range-like: containers, raw arrays, initializer lists.

```cpp
#include <iterator>

int  arr[5]  = {1, 2, 3, 4, 5};
auto v       = std::vector{1, 2, 3};

std::begin(arr);   std::end(arr);              // works for raw arrays!
std::begin(v);     std::end(v);
std::cbegin(v);    std::cend(v);                // const versions
std::rbegin(v);    std::rend(v);                // reverse
std::size(v);                                    // C++17
std::data(v);                                    // C++17 — pointer to first
std::empty(v);                                   // C++17
```

**Use `std::begin(x)` rather than `x.begin()`** in generic code so it works on raw arrays and types you don't own.

## 126. Writing a Custom Iterator
*(Eps. 138, 139)*

To make your own container play nicely with the STL, expose an iterator type with the right operations and the right traits.

```cpp
#include <iterator>
#include <iostream>

template <typename T>
class Ring {
    T*          buf_;
    std::size_t cap_;
    std::size_t size_;
    std::size_t head_;
public:
    // ... constructor, destructor, etc.

    class iterator {
        Ring*       r_;
        std::size_t pos_;       // logical index 0..size_

    public:
        // Required by iterator traits
        using iterator_category = std::random_access_iterator_tag;
        using value_type        = T;
        using difference_type   = std::ptrdiff_t;
        using pointer           = T*;
        using reference         = T&;

        iterator(Ring* r, std::size_t p) : r_(r), pos_(p) {}

        reference operator*()  const { return r_->buf_[(r_->head_ + pos_) % r_->cap_]; }
        iterator& operator++()       { ++pos_; return *this; }
        iterator  operator++(int)    { auto t = *this; ++(*this); return t; }

        bool operator==(const iterator& o) const { return r_ == o.r_ && pos_ == o.pos_; }
        bool operator!=(const iterator& o) const { return !(*this == o); }

        difference_type operator-(const iterator& o) const {
            return static_cast<difference_type>(pos_) - static_cast<difference_type>(o.pos_);
        }
        // ... + n, - n, [n], <, >, += etc. for full random access
    };

    iterator begin() { return {this, 0}; }
    iterator end()   { return {this, size_}; }
};
```

The required type aliases inside the iterator (`value_type`, `iterator_category`, `difference_type`, `pointer`, `reference`) are what `std::iterator_traits<It>` keys off. Without them, generic algorithms can't know how to use your iterator.

## 127. Iterator Invalidation
*(Ep. 140)*

When a container is modified, some iterators may stop pointing at valid memory. Each container has different rules.

| Container | Insert invalidates | Erase invalidates |
|-----------|-------------------|--------------------|
| `vector`, `string` | All if reallocation; else iterators at/after position | At/after erased |
| `deque` | All except those at front/back if inserting at front/back | All if not at ends |
| `list`, `forward_list` | None | Only the erased element |
| `set`, `map` (tree) | None | Only the erased element |
| `unordered_*` | All if rehash; else none | Only the erased element |

Classic bugs:

```cpp
std::vector<int> v = {1, 2, 3, 4};
for (auto it = v.begin(); it != v.end(); ++it) {
    if (*it == 2)
        v.push_back(99);                          // iterator INVALIDATED if reallocates
}

for (auto it = v.begin(); it != v.end(); ++it) {
    if (*it % 2 == 0)
        v.erase(it);                              // ❌ iterator now invalid; ++it is UB
}
```

The right pattern is to use the iterator returned by `erase`:

```cpp
for (auto it = v.begin(); it != v.end(); ) {
    if (*it % 2 == 0) it = v.erase(it);
    else              ++it;
}
```

Or much better, use the **erase-remove idiom** (section 136) or `std::erase_if` (C++20).

> **🏭 Industry Note — Iterator invalidation is a frequent CVE source:**
> Browser and JIT bugs often stem from "I had a pointer/iterator, called a function, the function reallocated, now my pointer dangles." Real CVEs in V8, WebKit, and Chrome have followed this pattern. Defensive techniques:
> - **Indices over iterators** when you might modify the container.
> - **Capture by value** instead of by reference when storing.
> - **Re-fetch after any potentially-mutating call.**
> - **Use AddressSanitizer in CI** — catches most use-after-invalidation at test time.

> **🎯 Mental Model — Iterators are pointer-shaped, not pointer-equal:**
> A vector iterator usually IS a pointer (or a thin wrapper) — that's why `vector::operator[]` and pointer arithmetic feel the same. A list iterator is a wrapped Node*. A map iterator is a wrapped tree-node pointer. The API is unified; the underlying mechanics aren't. This is why algorithms care about iterator *categories* (§124) — they need to know what operations are cheap.

---


# Part XII — STL Algorithms

## 128. Algorithms — Introduction & Generic Design
*(Ep. 141)*

The `<algorithm>` header gives you ~100 free functions that operate on **iterator ranges** rather than containers. This is the STL's central insight: separate **what** data lives in (containers) from **how** it's traversed (iterators) from **what you do to it** (algorithms). Any algorithm works on any container that exposes the required iterator category.

```cpp
#include <algorithm>
#include <vector>
#include <list>
#include <array>

std::vector<int> v = {3, 1, 4, 1, 5, 9, 2, 6};
std::list<int>   l = {3, 1, 4, 1, 5, 9, 2, 6};
std::array<int, 8> a = {3, 1, 4, 1, 5, 9, 2, 6};

// Same algorithm, three different containers
auto it1 = std::find(v.begin(), v.end(), 4);
auto it2 = std::find(l.begin(), l.end(), 4);
auto it3 = std::find(a.begin(), a.end(), 4);
```

### Naming conventions worth memorizing

| Suffix | Meaning |
|--------|---------|
| `_if` | Takes a predicate (unary boolean callable) instead of a value |
| `_n` | Operates on the next `n` elements rather than a range `[first, last)` |
| `_copy` | Writes results to an output iterator instead of modifying in place |
| `stable_` | Preserves the relative order of equivalent elements |
| `is_` | Returns `bool` without modifying anything |

For example: `find` / `find_if` / `find_if_not`, `copy` / `copy_n` / `copy_if`, `sort` / `stable_sort`, `partition` / `stable_partition` / `is_partitioned`.

### Three return-value patterns

1. **Iterator** — `find`, `lower_bound`, `remove`. Returns either a found position or the `last` iterator as a sentinel for "not found."
2. **Boolean / count** — `all_of`, `count_if`. Pure queries.
3. **Pair / struct** — `mismatch`, `minmax_element`. Returns multiple iterators.

### Execution policies (C++17)

Algorithms can take an optional first argument that requests parallel or vectorized execution:

```cpp
#include <execution>

std::sort(std::execution::par, v.begin(), v.end());          // parallel
std::sort(std::execution::par_unseq, v.begin(), v.end());    // parallel + vectorized
std::sort(std::execution::seq, v.begin(), v.end());          // explicit sequential (default)
```

The element operations must be data-race-free; otherwise behavior is undefined. Useful for embarrassingly parallel work on large datasets — but measure, don't assume parallel is faster.

### C++20 ranges versions

Every classic algorithm has a `std::ranges::` counterpart that takes a range directly:

```cpp
#include <ranges>

std::ranges::sort(v);                              // no .begin()/.end() boilerplate
auto it = std::ranges::find(v, 4);                 // value version
auto it2 = std::ranges::find_if(v, [](int x) { return x > 3; });
```

The rest of Part XII uses the iterator-pair form for clarity, but in modern C++20+ code the ranges form is preferred.

> **🏭 Industry Note — Why STL algorithms beat hand-rolled loops:**
> 1. **Correctness** — `std::sort` is decades-tested; your bubble sort isn't.
> 2. **Performance** — sort, find, partition use tuned implementations (introsort = quicksort + heapsort + insertion).
> 3. **Parallelism** — drop in `std::execution::par` to use all cores; impossible with hand-written loops.
> 4. **Readability** — `std::find_if(v, [](auto x){ return x > 10; })` reads as intent; a manual loop reads as mechanics.
> 5. **Composability** — algorithms compose, ranges-views compose better.
>
> The Sean Parent quote: *"No raw loops."* In review, look for hand-written loops that could be `find_if`, `count_if`, `transform`, `accumulate`, etc.

> **🔬 Under the Hood — `std::sort` is faster than `qsort`:**
> The C `qsort` takes a function pointer for comparison — indirect call per comparison, can't be inlined. C++ `std::sort` takes the comparator as a template parameter — inlined by the compiler. Result: typically 2-3× faster on the same data. The pattern: **anywhere C uses a function pointer for callback, C++ should use a functor or lambda + template parameter** for inlining.

> **⚖️ Tradeoff — Parallel algorithms:**
> ```cpp
> std::sort(std::execution::par, v.begin(), v.end());
> ```
> - **Worth it** when: N > ~10,000, element comparisons are non-trivial.
> - **Not worth it** when: small N, comparator is trivial (memory bandwidth, not CPU, is the bottleneck), or you don't have spare cores.
> - **Often regresses** in microbenchmarks because thread setup dominates.
> - **Implementation maturity varies**: libstdc++ uses Intel TBB; libc++ has gaps; MSVC is solid.

## 129. Search Algorithms
*(Eps. 142, 143)*

### `std::find` — first match by value

```cpp
#include <algorithm>
#include <vector>

std::vector<int> v = {1, 3, 5, 7, 9, 5};

auto it = std::find(v.begin(), v.end(), 5);
if (it != v.end()) {
    std::cout << "found at index " << (it - v.begin()) << '\n';   // 2
}
```

### `std::find_if` / `std::find_if_not` — first match by predicate

```cpp
auto it = std::find_if(v.begin(), v.end(),
                       [](int x) { return x > 5; });               // first > 5

auto it2 = std::find_if_not(v.begin(), v.end(),
                            [](int x) { return x < 10; });         // first NOT < 10
```

### `std::adjacent_find` — first pair of equal consecutive elements

```cpp
std::vector<int> v = {1, 2, 3, 3, 4, 5};
auto it = std::adjacent_find(v.begin(), v.end());
// it points to the first 3; std::next(it) is the second 3.

// With a custom comparator: first decreasing pair
auto dip = std::adjacent_find(v.begin(), v.end(),
                              [](int a, int b) { return a > b; });
```

Useful for detecting duplicates in a sorted range or spotting transitions.

### `std::search` — find a subsequence

```cpp
std::vector<int> haystack = {1, 2, 3, 4, 5, 6, 7};
std::vector<int> needle   = {3, 4, 5};

auto it = std::search(haystack.begin(), haystack.end(),
                      needle.begin(),   needle.end());
// it points to the 3 in haystack
```

For repeated searches in long text, `std::boyer_moore_searcher` (C++17) is asymptotically faster:

```cpp
#include <functional>

std::string text    = "the quick brown fox jumps over the lazy dog";
std::string pattern = "lazy";

auto it = std::search(text.begin(), text.end(),
                      std::boyer_moore_searcher(pattern.begin(), pattern.end()));
```

### `std::find_end` — last occurrence of a subsequence

```cpp
std::vector<int> v = {1, 2, 3, 1, 2, 3, 4};
auto it = std::find_end(v.begin(), v.end(),
                        std::next(v.begin(), 1), std::next(v.begin(), 3));   // {2, 3}
// it points to the second 2 (last occurrence of {2,3})
```

### `std::find_first_of` — first element that matches any in a set

```cpp
std::vector<char> text     = {'a', 'b', 'c', 'd'};
std::vector<char> vowels   = {'a', 'e', 'i', 'o', 'u'};

auto it = std::find_first_of(text.begin(), text.end(),
                             vowels.begin(), vowels.end());
// it points to 'a' (or 'd' — actually 'a' since it's first)
```

Common in tokenizers: "find the first delimiter character."

## 130. Comparison Algorithms
*(Ep. 144)*

### `std::equal` — element-wise equality

```cpp
std::vector<int> a = {1, 2, 3};
std::vector<int> b = {1, 2, 3};
std::vector<int> c = {1, 2, 4};

bool same1 = std::equal(a.begin(), a.end(), b.begin());           // true
bool same2 = std::equal(a.begin(), a.end(), c.begin());           // false

// Safer 4-iterator overload (C++14) — checks both lengths
bool same3 = std::equal(a.begin(), a.end(), b.begin(), b.end());
```

Always prefer the 4-iterator form: the 3-iterator overload reads past `b.end()` if `a` is longer, which is undefined behavior.

### `std::mismatch` — find first differing position

Returns a pair of iterators to the first non-matching elements.

```cpp
std::vector<int> a = {1, 2, 3, 4};
std::vector<int> b = {1, 2, 9, 4};

auto [it_a, it_b] = std::mismatch(a.begin(), a.end(), b.begin());
// *it_a == 3, *it_b == 9
```

Useful for diffing arrays or finding longest common prefix.

### `std::lexicographical_compare` — dictionary order

Returns `true` if the first range is lexicographically less than the second.

```cpp
std::string s1 = "apple";
std::string s2 = "apricot";

bool less = std::lexicographical_compare(s1.begin(), s1.end(),
                                          s2.begin(), s2.end());   // true
```

This is what `operator<` on `std::string` and `std::vector` ultimately calls.

### `std::lexicographical_compare_three_way` (C++20) — for spaceship

Returns a `std::strong_ordering` / `weak_ordering` instead of a bool — useful when implementing `operator<=>` for container-like types.

## 131. Quantifiers
*(Ep. 145)*

Predicate-checking algorithms that mirror the mathematical quantifiers ∀, ∃, ¬∃.

```cpp
#include <algorithm>
#include <vector>

std::vector<int> v = {2, 4, 6, 8};

bool all_even  = std::all_of(v.begin(), v.end(),
                              [](int x){ return x % 2 == 0; });    // true
bool any_neg   = std::any_of(v.begin(), v.end(),
                              [](int x){ return x < 0; });          // false
bool none_odd  = std::none_of(v.begin(), v.end(),
                               [](int x){ return x % 2 == 1; });    // true
```

**Empty-range semantics** (important to memorize):
- `all_of`  on empty range → `true`  (vacuous truth)
- `any_of`  on empty range → `false`
- `none_of` on empty range → `true`

This matches mathematical convention and means input validation passes through cleanly.

```cpp
// Replace this verbose loop
bool all_positive = true;
for (int x : v) { if (x <= 0) { all_positive = false; break; } }

// with intent-revealing code
bool all_positive = std::all_of(v.begin(), v.end(),
                                [](int x){ return x > 0; });
```

## 132. Counting
*(Ep. 146)*

```cpp
std::vector<int> v = {1, 2, 2, 3, 3, 3, 4};

auto n1 = std::count(v.begin(), v.end(), 3);                       // 3
auto n2 = std::count_if(v.begin(), v.end(),
                        [](int x){ return x > 2; });                // 4
```

Return type is `iterator_traits::difference_type` — for `vector<int>::iterator`, that's a signed integer. Don't store it in `size_t` blindly if you're going to subtract.

For multiple counts at once, a single loop is sometimes clearer than multiple `count_if` passes:

```cpp
int evens = 0, odds = 0, zeros = 0;
for (int x : v) {
    if      (x == 0)     ++zeros;
    else if (x % 2 == 0) ++evens;
    else                 ++odds;
}
```

But for a single condition, `count_if` is clearer and self-documenting.

## 133. Copy
*(Eps. 147, 148)*

### `std::copy` — copy a range to an output

The destination must already have room. A common bug is copying into an empty `vector` without reserving space first.

```cpp
std::vector<int> src = {1, 2, 3, 4, 5};
std::vector<int> dst(5);                              // pre-sized!

std::copy(src.begin(), src.end(), dst.begin());
```

To grow as you copy, use `std::back_inserter` from `<iterator>`:

```cpp
#include <iterator>

std::vector<int> dst;                                  // empty
std::copy(src.begin(), src.end(), std::back_inserter(dst));
// dst is now {1, 2, 3, 4, 5}
```

`back_inserter` is an output iterator that calls `push_back` on every write. Similar wrappers: `front_inserter` (uses `push_front`, so good for `deque`/`list`/`forward_list`) and `inserter` (inserts at a given position).

### `std::copy_n` — copy the first `n` elements

```cpp
std::vector<int> src = {1, 2, 3, 4, 5};
std::vector<int> dst(3);

std::copy_n(src.begin(), 3, dst.begin());             // dst == {1, 2, 3}
```

### `std::copy_if` — copy only matching elements

```cpp
std::vector<int> src = {1, 2, 3, 4, 5, 6};
std::vector<int> evens;

std::copy_if(src.begin(), src.end(),
             std::back_inserter(evens),
             [](int x){ return x % 2 == 0; });
// evens == {2, 4, 6}
```

### `std::copy_backward` — copy from the back

Necessary when source and destination ranges overlap and the destination ends after the source starts.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5, 0, 0};
std::copy_backward(v.begin(), v.begin() + 5, v.end());
// v == {1, 2, 1, 2, 3, 4, 5}
```

### `std::move` (algorithm, not the cast)

Moves elements instead of copying — useful for ranges of move-only types like `unique_ptr`:

```cpp
#include <memory>

std::vector<std::unique_ptr<int>> src;
src.push_back(std::make_unique<int>(42));
std::vector<std::unique_ptr<int>> dst;

std::move(src.begin(), src.end(), std::back_inserter(dst));
// src elements are now in moved-from state (empty unique_ptrs)
```

## 134. Generation
*(Eps. 149, 150)*

### `std::fill` — assign one value everywhere

```cpp
std::vector<int> v(5);
std::fill(v.begin(), v.end(), 7);                     // v == {7, 7, 7, 7, 7}
```

### `std::fill_n` — fill the first `n`

```cpp
std::fill_n(v.begin(), 3, 0);                         // v == {0, 0, 0, 7, 7}
```

### `std::generate` — call a nullary function for each element

```cpp
#include <random>

std::vector<int> rolls(10);
std::mt19937 rng(42);
std::uniform_int_distribution<int> d6(1, 6);

std::generate(rolls.begin(), rolls.end(),
              [&]{ return d6(rng); });
// rolls is now 10 random dice values
```

### `std::generate_n` — generate `n` values starting from an iterator

```cpp
std::vector<int> seq;
int i = 0;
std::generate_n(std::back_inserter(seq), 5, [&]{ return i++ * i; });
// seq == {0, 1, 4, 9, 16} — but careful: post-increment in lambda is shared state
```

## 135. `reverse`, `reverse_copy`
*(Ep. 151)*

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};

std::reverse(v.begin(), v.end());                     // v == {5, 4, 3, 2, 1}

// Or non-destructively
std::vector<int> src = {1, 2, 3, 4, 5};
std::vector<int> dst(5);
std::reverse_copy(src.begin(), src.end(), dst.begin());
// dst == {5, 4, 3, 2, 1}, src unchanged
```

You can also reverse with iterators directly via `rbegin()`/`rend()` if you only need to *read* in reverse order without mutating.

## 136. Erase-Remove Idiom; `std::erase` / `erase_if` (C++20)
*(Eps. 152, 153)*

`std::remove` and `std::remove_if` **don't actually erase elements** — they can't, since they only have iterators, not the container. Instead, they shift unwanted elements to the end and return an iterator to the new logical end. You then call `erase` on the container to truly remove them.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5, 6};

// Classic two-step "erase-remove" idiom
v.erase(std::remove_if(v.begin(), v.end(),
                       [](int x){ return x % 2 == 0; }),
        v.end());
// v == {1, 3, 5}
```

Visualizing what `remove_if` does to `{1, 2, 3, 4, 5, 6}` looking for evens:

```
Before:  1  2  3  4  5  6
              ↓ shift kept elements forward
After:   1  3  5  ?  ?  ?     ← returned iterator points here
                  └─ "garbage" — kept for safety, must be erased
```

### C++20 — `std::erase` and `std::erase_if`

C++20 added free functions that do the right thing in one call:

```cpp
#include <vector>

std::vector<int> v = {1, 2, 3, 4, 5, 6};
std::erase_if(v, [](int x){ return x % 2 == 0; });    // v == {1, 3, 5}

std::vector<int> w = {1, 2, 3, 2, 1};
std::erase(w, 2);                                      // w == {1, 3, 1}
```

Use these over the old idiom in any new C++20+ code. They're defined for all the standard containers (including `string`, `list`, `set`, `map` — each picks the right underlying operation).

## 137. `sample`
*(Ep. 154)*

C++17. Selects up to `n` random elements from a range without replacement.

```cpp
#include <algorithm>
#include <random>
#include <vector>
#include <iterator>

std::vector<int> population(100);
std::iota(population.begin(), population.end(), 0);   // 0..99

std::vector<int> chosen;
std::mt19937 rng(std::random_device{}());

std::sample(population.begin(), population.end(),
            std::back_inserter(chosen),
            5, rng);
// chosen has 5 distinct elements from population, in stable order
```

Useful for reservoir-sampling-style algorithms, A/B test bucketing, random walks, etc.

## 138. `rotate`
*(Ep. 155)*

`rotate(first, middle, last)` rearranges the range so that `middle` becomes the new `first`. Returns the iterator to the element that was originally at `first`.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};

std::rotate(v.begin(), v.begin() + 2, v.end());
// v == {3, 4, 5, 1, 2}
```

The mental model: think of the range as a circular buffer; rotate is "pick where the new starting point is."

Practical use — move-to-front:

```cpp
// Move the element at position k to the front
auto it = v.begin() + k;
std::rotate(v.begin(), it, it + 1);
```

## 139. `shuffle`
*(Ep. 156)*

Randomly permutes a range using a uniform random bit generator.

```cpp
#include <algorithm>
#include <random>

std::vector<int> deck(52);
std::iota(deck.begin(), deck.end(), 0);

std::mt19937 rng(std::random_device{}());
std::shuffle(deck.begin(), deck.end(), rng);
```

The old `std::random_shuffle` was removed in C++17 because it relied on `rand()`, which has terrible statistical properties. Always use `shuffle` with a proper engine like `mt19937` (or `mt19937_64` for 64-bit ranges).

## 140. `unique`, `unique_copy`
*(Ep. 157)*

Removes **consecutive** duplicates (so you usually `sort` first if you want global uniqueness). Like `remove`, it returns an iterator to the new logical end — pair it with `erase`.

```cpp
std::vector<int> v = {1, 1, 2, 3, 3, 3, 4, 5, 5};
v.erase(std::unique(v.begin(), v.end()), v.end());
// v == {1, 2, 3, 4, 5}

// For globally unique values, sort first
std::vector<int> w = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
std::sort(w.begin(), w.end());
w.erase(std::unique(w.begin(), w.end()), w.end());
// w == {1, 2, 3, 4, 5, 6, 9}
```

Custom equality:

```cpp
std::vector<int> v = {1, -1, 2, -2, 2, 3};
auto it = std::unique(v.begin(), v.end(),
                      [](int a, int b){ return std::abs(a) == std::abs(b); });
v.erase(it, v.end());
// v == {1, 2, 3}
```

`unique_copy` is the non-destructive version: writes unique elements to an output iterator.

## 141. `transform`
*(Eps. 158, 159)*

The STL's `map` (in the functional-programming sense). Applies a function to each element and writes results to an output range.

```cpp
std::vector<int> src = {1, 2, 3, 4, 5};
std::vector<int> dst(5);

std::transform(src.begin(), src.end(), dst.begin(),
               [](int x){ return x * x; });
// dst == {1, 4, 9, 16, 25}
```

In-place is fine — source and destination can overlap:

```cpp
std::transform(src.begin(), src.end(), src.begin(),
               [](int x){ return x + 100; });
```

### Two-input transform

Applies a binary operation to corresponding elements of two ranges:

```cpp
std::vector<int> a = {1, 2, 3};
std::vector<int> b = {10, 20, 30};
std::vector<int> c(3);

std::transform(a.begin(), a.end(), b.begin(), c.begin(),
               std::plus<>());
// c == {11, 22, 33}
```

`std::plus<>`, `std::minus<>`, `std::multiplies<>`, `std::divides<>`, `std::modulus<>`, `std::negate<>` live in `<functional>`. The `<>` (empty template argument) lets the compiler deduce the operand type.

## 142. Partition Family
*(Eps. 160, 161)*

`partition` rearranges a range so all elements satisfying a predicate come first, and returns the iterator to the first element that *doesn't* satisfy it.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8};

auto mid = std::partition(v.begin(), v.end(),
                          [](int x){ return x % 2 == 0; });
// v might be {2, 4, 6, 8, 5, 3, 7, 1} — order within each group is NOT preserved
// mid points to the first odd element (5)
```

### `stable_partition` — preserves order

```cpp
std::vector<int> v = {1, 2, 3, 4, 5, 6};
std::stable_partition(v.begin(), v.end(),
                      [](int x){ return x % 2 == 0; });
// v == {2, 4, 6, 1, 3, 5} — guaranteed
```

### `is_partitioned`, `partition_point`

```cpp
bool ok = std::is_partitioned(v.begin(), v.end(),
                              [](int x){ return x % 2 == 0; });

// In an already-partitioned range, find the partition point in O(log n)
auto pt = std::partition_point(v.begin(), v.end(),
                               [](int x){ return x % 2 == 0; });
```

`partition_point` works like `lower_bound` but for any monotonic predicate. Useful for finding split points in pre-sorted data.

### `partition_copy` — write the two halves separately

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};
std::vector<int> evens, odds;

std::partition_copy(v.begin(), v.end(),
                    std::back_inserter(evens),
                    std::back_inserter(odds),
                    [](int x){ return x % 2 == 0; });
// evens == {2, 4}, odds == {1, 3, 5}
```

Quicksort's recursive step is conceptually a partition around a pivot. The C++ standard guarantees `std::partition` is O(n) with O(n) swaps in the worst case.

## 143. Sorting
*(Eps. 162, 163, 164)*

### `std::sort` — introsort, average O(n log n)

```cpp
std::vector<int> v = {3, 1, 4, 1, 5, 9, 2, 6};

std::sort(v.begin(), v.end());                        // ascending
std::sort(v.begin(), v.end(), std::greater<>());      // descending

// Custom comparator — sort by absolute value
std::sort(v.begin(), v.end(),
          [](int a, int b){ return std::abs(a) < std::abs(b); });
```

`std::sort` requires **random-access iterators**. For `std::list`, use `list::sort()` member function.

The comparator must define a **strict weak ordering** — basically: `comp(a, a)` is false, and if `comp(a, b)` and `comp(b, c)` then `comp(a, c)`. Violating this is UB; with strict iterator debugging modes, sorts may abort or hang.

### `std::stable_sort` — preserves order of equivalent elements

```cpp
struct Person { std::string name; int age; };
std::vector<Person> people = {
    {"alice", 30}, {"bob", 25}, {"charlie", 30}, {"dora", 25}
};

std::stable_sort(people.begin(), people.end(),
                 [](const Person& a, const Person& b){ return a.age < b.age; });
// Result: bob, dora (both 25, original order), alice, charlie (both 30, original order)
```

Use `stable_sort` whenever the relative order of equivalent elements matters — sorting by multiple criteria via successive stable sorts is a classic technique.

### `std::is_sorted` / `std::is_sorted_until`

```cpp
bool ok = std::is_sorted(v.begin(), v.end());
auto bad = std::is_sorted_until(v.begin(), v.end());   // first OOO element
```

### `std::partial_sort` — sort just the top `k`

```cpp
std::vector<int> v = {5, 4, 3, 2, 1, 6, 7, 8, 9, 10};
std::partial_sort(v.begin(), v.begin() + 3, v.end());
// First 3 elements are the smallest 3, in order: {1, 2, 3, ...}
// Rest is unspecified order.
```

O(n log k) — much faster than full sort when k ≪ n. Implemented with a heap.

### `std::nth_element` — partition around the nth smallest

```cpp
std::vector<int> v = {5, 4, 3, 2, 1, 9, 8, 7, 6};
auto mid = v.begin() + v.size() / 2;

std::nth_element(v.begin(), mid, v.end());
// *mid is now the median (5)
// Elements before mid are all <= *mid; elements after are all >= *mid
// But each "half" is in unspecified order
```

O(n) average — much faster than sort for finding medians or quantiles. Classic uses: median filters in image/signal processing, percentile metrics in monitoring.

## 144. Merge
*(Eps. 165, 166)*

### `std::merge` — combine two sorted ranges

```cpp
std::vector<int> a = {1, 3, 5};
std::vector<int> b = {2, 4, 6};
std::vector<int> result(6);

std::merge(a.begin(), a.end(),
           b.begin(), b.end(),
           result.begin());
// result == {1, 2, 3, 4, 5, 6}
```

Stable: equal elements from `a` come before equal elements from `b`.

### `std::inplace_merge` — merge two adjacent sorted halves

```cpp
std::vector<int> v = {1, 3, 5, 2, 4, 6};               // two sorted halves
std::inplace_merge(v.begin(), v.begin() + 3, v.end());
// v == {1, 2, 3, 4, 5, 6}
```

This is the merge step of mergesort; you'd use it in custom sorters or when you have data arriving in pre-sorted batches.

## 145. Binary Search
*(Eps. 167, 168)*

All three require a **sorted** range.

### `std::lower_bound` — first position where value could be inserted

Returns an iterator to the first element **not less than** value.

```cpp
std::vector<int> v = {1, 2, 4, 4, 4, 6, 8};

auto lo = std::lower_bound(v.begin(), v.end(), 4);     // first 4
auto hi = std::upper_bound(v.begin(), v.end(), 4);     // one past last 4
// Distance lo..hi = count of 4s in v
```

### `std::upper_bound` — first position past matching values

Returns an iterator to the first element **strictly greater than** value.

### `std::binary_search` — just a yes/no

```cpp
bool exists = std::binary_search(v.begin(), v.end(), 4);
```

If you need both "does it exist" and "where is it", call `lower_bound` once and check both conditions:

```cpp
auto it = std::lower_bound(v.begin(), v.end(), 4);
bool found = (it != v.end() && *it == 4);
```

### `std::equal_range` — pair `(lower_bound, upper_bound)`

```cpp
auto [lo, hi] = std::equal_range(v.begin(), v.end(), 4);
std::cout << std::distance(lo, hi) << " fours\n";       // 3
```

All three: **O(log n) comparisons**, but only **O(log n) iterator movements** for random-access iterators. With non-random-access iterators (e.g. `std::set::iterator`), still O(n) movements — so use the container's member function `set::find()` instead.

## 146. Set Operations
*(Eps. 169, 170)*

Operate on **sorted** ranges (despite the name — not specific to `std::set`).

```cpp
std::vector<int> a = {1, 2, 3, 4, 5};
std::vector<int> b = {3, 4, 5, 6, 7};
std::vector<int> result;
```

### `std::set_union` — A ∪ B

```cpp
std::set_union(a.begin(), a.end(),
               b.begin(), b.end(),
               std::back_inserter(result));
// result == {1, 2, 3, 4, 5, 6, 7}
```

### `std::set_intersection` — A ∩ B

```cpp
result.clear();
std::set_intersection(a.begin(), a.end(),
                      b.begin(), b.end(),
                      std::back_inserter(result));
// result == {3, 4, 5}
```

### `std::set_difference` — A \ B

```cpp
result.clear();
std::set_difference(a.begin(), a.end(),
                    b.begin(), b.end(),
                    std::back_inserter(result));
// result == {1, 2}
```

### `std::set_symmetric_difference` — A △ B (in either but not both)

```cpp
result.clear();
std::set_symmetric_difference(a.begin(), a.end(),
                              b.begin(), b.end(),
                              std::back_inserter(result));
// result == {1, 2, 6, 7}
```

### `std::includes` — is A a superset of B?

```cpp
std::vector<int> super = {1, 2, 3, 4, 5};
std::vector<int> sub   = {2, 4};
bool contains = std::includes(super.begin(), super.end(),
                              sub.begin(), sub.end());          // true
```

All are O(m + n). For unsorted sets or hash sets, you'd use container-specific operations.

## 147. Heap Algorithms
*(Eps. 171, 172)*

A **heap** is a tree-like structure embedded in an array where each parent is ≥ (max-heap) or ≤ (min-heap) its children. The standard heap algorithms work on any random-access range.

### Building and maintaining a heap

```cpp
#include <algorithm>
#include <vector>

std::vector<int> v = {3, 1, 4, 1, 5, 9, 2, 6};

std::make_heap(v.begin(), v.end());           // v is now a max-heap
// v.front() is the maximum (9)

v.push_back(10);
std::push_heap(v.begin(), v.end());           // re-heapify after push_back
// v.front() == 10

std::pop_heap(v.begin(), v.end());            // moves max to the BACK
int max = v.back();                            // 10
v.pop_back();                                  // now physically remove
```

`pop_heap` doesn't actually remove the element — it swaps front and back and re-heapifies the [first, last-1) portion. You then `pop_back` to remove it.

### Heapsort

```cpp
std::vector<int> v = {3, 1, 4, 1, 5, 9, 2, 6};
std::make_heap(v.begin(), v.end());
std::sort_heap(v.begin(), v.end());            // v is now sorted ascending
```

`sort_heap` is O(n log n) but has worse constants than `std::sort` (which uses introsort). Useful when you already have a heap.

### `std::is_heap` / `std::is_heap_until`

```cpp
bool ok = std::is_heap(v.begin(), v.end());
auto first_bad = std::is_heap_until(v.begin(), v.end());
```

These low-level building blocks underpin `std::priority_queue`. Direct use is rare in app code but central to scheduler / event-loop / Dijkstra implementations.

## 148. Min/Max Algorithms
*(Eps. 173–176)*

### Value-based: `min`, `max`, `minmax`, `clamp`

```cpp
int a = std::min(3, 7);                        // 3
int b = std::max(3, 7);                        // 7
auto [lo, hi] = std::minmax(3, 7);             // {3, 7} as std::pair

// Initializer-list versions
int c = std::min({4, 2, 7, 1, 5});             // 1
int d = std::max({4, 2, 7, 1, 5});             // 7
auto [m, M] = std::minmax({4, 2, 7, 1, 5});    // {1, 7}

// clamp (C++17) — restrict to [lo, hi]
int v = std::clamp(15, 0, 10);                 // 10
int w = std::clamp(-5, 0, 10);                 // 0
int x = std::clamp(5, 0, 10);                  // 5
```

### Range-based: `min_element`, `max_element`, `minmax_element`

Return **iterators** (not values), so you can use position info.

```cpp
std::vector<int> v = {4, 2, 7, 1, 5};
auto it_min = std::min_element(v.begin(), v.end());
auto it_max = std::max_element(v.begin(), v.end());
std::cout << *it_min << " at " << (it_min - v.begin()) << '\n';   // 1 at 3

auto [it_lo, it_hi] = std::minmax_element(v.begin(), v.end());
```

`minmax_element` is more efficient than separate `min_element` + `max_element`: roughly 3n/2 comparisons instead of 2n.

### Custom comparators

```cpp
struct Player { std::string name; int score; };
std::vector<Player> players = { {"a", 30}, {"b", 50}, {"c", 20} };

auto best = std::max_element(players.begin(), players.end(),
    [](const Player& a, const Player& b){ return a.score < b.score; });
// best->name == "b"
```

The comparator is "less than" — `max_element` finds the element for which no other element is greater.

## 149. `swap`, `iter_swap`
*(Ep. 204)*

```cpp
int a = 1, b = 2;
std::swap(a, b);                               // a == 2, b == 1

std::vector<int> v = {1, 2, 3, 4, 5};
std::iter_swap(v.begin(), v.begin() + 4);      // v == {5, 2, 3, 4, 1}
```

### `std::swap_ranges`

```cpp
std::vector<int> a = {1, 2, 3};
std::vector<int> b = {4, 5, 6};
std::swap_ranges(a.begin(), a.end(), b.begin());
// a == {4, 5, 6}, b == {1, 2, 3}
```

### Custom `swap`

For your own classes, define a `swap` member or free function — many STL algorithms use ADL-found `swap`:

```cpp
class Buffer {
    char* data_;
    std::size_t size_;
public:
    void swap(Buffer& other) noexcept {
        std::swap(data_, other.data_);
        std::swap(size_, other.size_);
    }
    friend void swap(Buffer& a, Buffer& b) noexcept { a.swap(b); }
};
```

A correctly-implemented `swap` is a building block for the **copy-and-swap idiom** for exception-safe assignment:

```cpp
Buffer& operator=(Buffer other) {            // pass by value: copy
    swap(other);                              // swap with the copy
    return *this;
}                                              // 'other' destroyed with old state
```

This gives you the strong exception guarantee: if construction throws, the assignment never starts.

---

# Part XIII — Numeric Algorithms

## 150. `midpoint`, `lerp`
*(Eps. 177, 178)*

C++20 added two small but valuable numeric utilities in `<numeric>`.

### `std::midpoint` — overflow-safe average

The naive `(a + b) / 2` overflows when both are near `INT_MAX`. `std::midpoint` computes the midpoint correctly for all integral and floating types, and also works on **pointers** (yielding the midpoint of a range — useful for binary search).

```cpp
#include <numeric>

int a = std::numeric_limits<int>::max();
int b = std::numeric_limits<int>::max() - 2;

int bad  = (a + b) / 2;                    // UB — signed overflow
int good = std::midpoint(a, b);            // correct: INT_MAX - 1

// Pointer midpoint
int arr[100];
int* mid = std::midpoint(arr + 0, arr + 100);  // arr + 50
```

For floats, midpoint avoids overflow to infinity for very large operands.

### `std::lerp` — linear interpolation

Returns a value between `a` and `b` parameterized by `t` (typically in [0, 1]).

```cpp
double a = std::lerp(0.0, 10.0, 0.5);          // 5.0
double b = std::lerp(0.0, 10.0, 0.25);         // 2.5
double c = std::lerp(100.0, 200.0, 0.75);      // 175.0
```

The implementation handles edge cases (NaN, infinities, t outside [0,1]) with carefully-specified semantics. In graphics, animation, signal processing, color mixing — `lerp` is everywhere.

## 151. `iota`
*(Ep. 179)*

Fills a range with sequentially incrementing values.

```cpp
#include <numeric>

std::vector<int> v(10);
std::iota(v.begin(), v.end(), 1);              // v == {1, 2, ..., 10}

std::vector<char> letters(5);
std::iota(letters.begin(), letters.end(), 'a'); // {'a', 'b', 'c', 'd', 'e'}
```

The name comes from the APL ⍳ (iota) operator. C++20 also offers `std::views::iota`:

```cpp
#include <ranges>
for (int i : std::views::iota(1, 11)) std::cout << i << ' ';   // 1..10
```

Useful any time you need 0..N-1 as input to an algorithm — indexing tricks, generating permutations, building lookup tables.

## 152. `adjacent_difference`, `partial_sum`
*(Eps. 180, 181)*

Two complementary algorithms: one computes differences between consecutive elements, the other computes running totals. They're inverses (up to the first element).

### `std::adjacent_difference`

```cpp
#include <numeric>

std::vector<int> v = {1, 3, 6, 10, 15};
std::vector<int> diff(5);

std::adjacent_difference(v.begin(), v.end(), diff.begin());
// diff == {1, 2, 3, 4, 5}
// First element is copied as-is; subsequent are v[i] - v[i-1]
```

Useful for: derivative of a signal, packet inter-arrival times, finite differences in numerical methods.

### `std::partial_sum` — cumulative sum / prefix sum

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};
std::vector<int> sums(5);

std::partial_sum(v.begin(), v.end(), sums.begin());
// sums == {1, 3, 6, 10, 15}
```

Inversely related to `adjacent_difference` — running this on `{1, 2, 3, 4, 5}` produces `{1, 3, 6, 10, 15}`, and running `adjacent_difference` on `{1, 3, 6, 10, 15}` gives back `{1, 2, 3, 4, 5}`.

Both take an optional binary op:

```cpp
// Cumulative max
std::vector<int> v = {3, 1, 4, 1, 5, 9, 2, 6};
std::vector<int> cmax(v.size());

std::partial_sum(v.begin(), v.end(), cmax.begin(),
    [](int a, int b){ return std::max(a, b); });
// cmax == {3, 3, 4, 4, 5, 9, 9, 9}
```

Prefix sums are a workhorse algorithmic primitive — range-sum queries in O(1) after O(n) preprocessing, monotone stacks, sliding-window aggregates.

## 153. `inner_product` (Map–Reduce Pairs)
*(Ep. 182)*

Combines two ranges pairwise and reduces to a single value. The default operation is sum-of-products — a dot product.

```cpp
#include <numeric>

std::vector<int> a = {1, 2, 3};
std::vector<int> b = {4, 5, 6};

int dot = std::inner_product(a.begin(), a.end(), b.begin(), 0);
// 1*4 + 2*5 + 3*6 = 32
```

The fourth argument is the initial accumulator. You can override both operations:

```cpp
// Element-wise multiply, then take the max
int m = std::inner_product(a.begin(), a.end(), b.begin(),
                            0,                              // init
                            [](int x, int y){ return std::max(x, y); },  // reduce
                            [](int x, int y){ return x * y; });          // map
// max(4, 10, 18) = 18

// Hamming distance: count positions where a and b differ
std::vector<int> p = {1, 2, 3, 4};
std::vector<int> q = {1, 9, 3, 8};
int dist = std::inner_product(p.begin(), p.end(), q.begin(),
                               0,
                               std::plus<>(),
                               std::not_equal_to<>());
// 0 + 1 + 0 + 1 = 2
```

Effectively a stripped-down map-reduce on pairs. Useful for vector math, similarity metrics, statistical correlation.

## 154. `accumulate` (Fold)
*(Ep. 183)*

The sequential left fold: starts with an initial value and applies a binary op to combine it with each element in order.

```cpp
#include <numeric>

std::vector<int> v = {1, 2, 3, 4, 5};

int sum  = std::accumulate(v.begin(), v.end(), 0);                 // 15
int prod = std::accumulate(v.begin(), v.end(), 1, std::multiplies<>()); // 120

// Build a comma-separated string
std::vector<std::string> words = {"hello", "world", "cpp"};
std::string joined = std::accumulate(
    std::next(words.begin()), words.end(), words[0],
    [](const std::string& acc, const std::string& s){ return acc + ", " + s; });
// "hello, world, cpp"
```

**Crucial trap — initial value type:**

```cpp
std::vector<double> v = {1.5, 2.5, 3.5};
auto bad  = std::accumulate(v.begin(), v.end(), 0);     // 0 is int! Result: 7 (truncates each step? — actually 7)
auto good = std::accumulate(v.begin(), v.end(), 0.0);   // 7.5
```

The accumulator type follows the initial value's type, not the range's element type. Always match the type carefully.

`accumulate` is **strictly sequential** — operations happen left-to-right. For parallelizable folds, use `reduce` (next section).

> **🏭 Industry Note — Numeric algorithms are the foundation of ML/scientific computing:**
> - `transform_reduce` is the building block of **inner products, norms, and weighted sums** — used in ML inference, signal processing, physics simulation.
> - `partial_sum` / `inclusive_scan` are core to **parallel prefix sum** — used in compaction (filtering arrays), histogram building, image processing.
> - `iota` initializes range indices for "for each row of a matrix" patterns.
>
> Most numeric libraries (Eigen, xtensor, NumPy under the hood) use these primitives with custom backends. Knowing the standard ones makes you faster at picking up domain libraries.

## 155. `reduce` (Parallel Fold) and `transform_reduce`
*(Eps. 184, 185)*

C++17. Like `accumulate`, but the operation may execute in **unspecified order** — which means the binary op must be associative and commutative for deterministic results.

```cpp
#include <numeric>
#include <execution>

std::vector<int> v(1'000'000);
std::iota(v.begin(), v.end(), 1);

long long sum1 = std::reduce(v.begin(), v.end(), 0LL);                          // sequential
long long sum2 = std::reduce(std::execution::par, v.begin(), v.end(), 0LL);     // parallel
long long sum3 = std::reduce(std::execution::par_unseq, v.begin(), v.end(), 0LL); // parallel + vectorized
```

**Why this can be faster:** the implementation can split the range across threads and combine sub-results. Even sequentially, the compiler has more freedom to vectorize because it doesn't have to preserve left-to-right order.

**Why this can be surprising:** floating-point addition is not associative. `reduce` on floats may give different results on different runs.

```cpp
std::vector<double> v = { /* a million floats */ };
double s = std::reduce(v.begin(), v.end(), 0.0);   // result may vary slightly each run
```

For deterministic FP sums, use `accumulate`.

### `transform_reduce` — fused map-reduce

```cpp
std::vector<int> a = {1, 2, 3};
std::vector<int> b = {4, 5, 6};

// Dot product, parallelizable
int dot = std::transform_reduce(a.begin(), a.end(), b.begin(),
                                 0,
                                 std::plus<>(),       // reduce op
                                 std::multiplies<>()); // transform op
// 32

// Sum of squares
int ss = std::transform_reduce(a.begin(), a.end(),
                                0,
                                std::plus<>(),
                                [](int x){ return x * x; });
// 1 + 4 + 9 = 14
```

`transform_reduce` is the "parallel-friendly `inner_product`" and the natural primitive for parallel computations like norms, weighted sums, statistical moments.

## 156. `exclusive_scan`, `inclusive_scan`
*(Ep. 186)*

C++17. Parallel-friendly versions of `partial_sum`.

### `inclusive_scan` — result[i] includes input[i]

```cpp
#include <numeric>

std::vector<int> v = {1, 2, 3, 4, 5};
std::vector<int> out(5);

std::inclusive_scan(v.begin(), v.end(), out.begin());
// out == {1, 3, 6, 10, 15}  -- same as partial_sum
```

### `exclusive_scan` — result[i] excludes input[i]

```cpp
std::exclusive_scan(v.begin(), v.end(), out.begin(), 0);
// out == {0, 1, 3, 6, 10}
// out[i] = init + v[0] + v[1] + ... + v[i-1]
```

The initial value goes first (`0` here), and the last element of input is never used.

Exclusive scan is the more useful primitive in parallel algorithms — it gives you, for each position, the cumulative sum of everything *before* it, which is exactly what you need to allocate output positions in a parallel filter, parallel partition, etc.

Both come with execution policies and fused-transform variants (`transform_inclusive_scan`, `transform_exclusive_scan`), making them building blocks for parallel data-parallel pipelines.

---

# Part XIV — Output, Streams, and Files

## 157. `std::format` (C++20)
*(Eps. 187, 188)*

C++20's modern, type-safe formatting library — Python-like, fast, and free of `printf`'s ABI hazards.

```cpp
#include <format>
#include <iostream>

std::string s = std::format("Hello, {}! You are {} years old.", "Alice", 30);
std::cout << s << '\n';
// Hello, Alice! You are 30 years old.
```

### Positional and named arguments

```cpp
std::format("{0} {1} {0}", "ping", "pong");           // "ping pong ping"
std::format("{1:>10} {0}", "world", "hello");         // "     hello world"
```

### Format specifiers

The mini-language inside `{}` is `{[index]:[fill][align][sign][#][0][width][.precision][type]}`.

```cpp
std::format("{:5}",    42);          // "   42"     (width 5, right-align int)
std::format("{:<5}",   42);          // "42   "     (left-align)
std::format("{:^5}",   42);          // " 42  "     (center)
std::format("{:05}",   42);          // "00042"     (zero-pad)
std::format("{:+}",    42);          // "+42"       (force sign)
std::format("{:#x}",   255);         // "0xff"      (hex with prefix)
std::format("{:#b}",   10);          // "0b1010"    (binary)
std::format("{:.3f}",  3.14159);     // "3.142"     (3 decimal places)
std::format("{:.3e}",  1234567.0);   // "1.235e+06" (scientific)
std::format("{:10.3f}", 3.14);       // "     3.140"
```

### Compile-time checking

```cpp
// std::format("{}", 1, 2);    // compile-time error in C++23: too many args
// std::format("{:d}", "abc"); // compile-time error: string can't use 'd'
```

The format string is checked at compile time (C++20) — a major win over `printf`.

### `std::format_to` and `std::format_to_n`

Write into an existing buffer or output iterator instead of allocating a `string`:

```cpp
#include <iterator>
char buf[64];
auto end = std::format_to(buf, "x = {}", 42);
*end = '\0';                                          // null-terminate

// Bounded version: write at most N characters
std::format_to_n(buf, sizeof(buf) - 1, "x = {}", 42);
```

## 158. `std::format` with STL Containers
*(Ep. 189)*

C++23 added formatters for ranges and containers (`<format>` with `__cpp_lib_format_ranges`):

```cpp
#include <format>
#include <vector>
#include <map>

std::vector<int> v = {1, 2, 3};
std::cout << std::format("{}\n", v);                 // [1, 2, 3]

std::map<std::string, int> m = {{"a", 1}, {"b", 2}};
std::cout << std::format("{}\n", m);                 // {"a": 1, "b": 2}

// Custom range formatting (C++23)
std::cout << std::format("{::#x}\n", v);             // [0x1, 0x2, 0x3]
std::cout << std::format("{:n}\n", v);                // 1, 2, 3  (no brackets)
```

The `:n` flag drops the brackets — useful when joining.

Before C++23, you'd typically use a loop or `std::accumulate` to build the string manually.

## 159. `std::formatter` for Custom Types
*(Ep. 190)*

To make your own type formattable, specialize `std::formatter`:

```cpp
#include <format>

struct Point { double x, y; };

template <>
struct std::formatter<Point> {
    constexpr auto parse(std::format_parse_context& ctx) {
        return ctx.begin();                          // no custom spec for now
    }

    auto format(const Point& p, std::format_context& ctx) const {
        return std::format_to(ctx.out(), "({}, {})", p.x, p.y);
    }
};

// Use
Point p{1.5, 2.5};
std::cout << std::format("{}\n", p);                 // (1.5, 2.5)
```

To support format specifiers (`{:.2f}`):

```cpp
template <>
struct std::formatter<Point> : std::formatter<double> {
    auto format(const Point& p, std::format_context& ctx) const {
        auto out = ctx.out();
        *out++ = '(';
        out = std::formatter<double>::format(p.x, ctx);
        *out++ = ',';
        *out++ = ' ';
        out = std::formatter<double>::format(p.y, ctx);
        *out++ = ')';
        return out;
    }
};

// Now this works:
std::cout << std::format("{:.2f}\n", Point{1.5, 2.5});   // (1.50, 2.50)
```

The `: std::formatter<double>` inheritance trick reuses the double formatter's `parse` to handle precision/width specs.

## 160. `std::print` (C++23)
*(Ep. 191)*

`std::format` + automatic write to a stream, in one call:

```cpp
#include <print>

std::print("Hello, {}!\n", "world");                 // writes to stdout
std::println("x = {}", 42);                          // auto newline

std::print(stderr, "Error: {}\n", "oops");           // to stderr
std::println(std::cout, "to cout");                  // to cout
```

Faster than `std::cout << std::format(...)` because it can write directly to the stream's buffer without an intermediate `string` allocation, and it bypasses iostream's sync overhead.

For now (May 2026) `std::print` is well-supported in GCC 14+ and Clang 18+. If unavailable, the equivalent is `std::cout << std::format(...);`.

## 161. `std::cout`
*(Ep. 192)*

The standard output stream. Buffered (line-buffered when connected to a terminal, fully buffered otherwise).

```cpp
#include <iostream>

std::cout << "int: " << 42 << '\n';
std::cout << "double: " << 3.14 << '\n';
std::cout << std::hex << 255 << '\n';                // ff
std::cout << std::dec << 255 << '\n';                // 255
std::cout << std::setw(10) << 42 << '\n';            // "        42" (need <iomanip>)
std::cout << std::setprecision(3) << 3.14159 << '\n'; // 3.14
std::cout << std::fixed << 3.0 << '\n';              // 3.000
```

### Manipulators

| Manipulator | Effect |
|------|--------|
| `std::endl` | `'\n'` + flush |
| `std::flush` | Force flush |
| `std::hex`, `std::dec`, `std::oct` | Integer base |
| `std::boolalpha` | Print bools as `true`/`false` |
| `std::setw(n)` | Field width (one-shot — resets after next item) |
| `std::setfill(c)` | Padding character |
| `std::setprecision(n)` | FP digits (interpretation depends on `std::fixed`/`std::scientific`) |
| `std::fixed`, `std::scientific` | FP notation |

### Performance note

`std::cout` is synced with `printf` by default — slow for high-volume output. Disable for fast pipelines:

```cpp
std::ios_base::sync_with_stdio(false);
std::cin.tie(nullptr);                                // don't flush cout on cin reads
```

Combined with `'\n'` instead of `std::endl`, this can give 10x+ speedups in competitive programming or log-heavy code.

> **🏭 Industry Note — Production logging frameworks:**
> Almost no production C++ uses `std::cout` directly for logging. Standard libraries:
> | Library | Used by | Highlights |
> |---|---|---|
> | **spdlog** | Many OSS / industry | Fast, header-only, async sinks, format library built in |
> | **glog** | Google | Severity levels, conditional logging, stack traces on FATAL |
> | **Boost.Log** | Boost users | Heavy, flexible, slow to compile |
> | **fmt** | Half the industry | Not a logger — but the formatter underneath spdlog/std::format |
> | **{fmtlog}** | HFT | Sub-microsecond log latency |
>
> Key requirements: structured logging (key-value pairs, JSON output), level filtering, async batching, integration with monitoring (Prometheus, Datadog). Roll-your-own is almost always wrong for production.

> **⚠️ Pitfall — iostream is slow:**
> `std::cout` performance is genuinely poor compared to `printf` or `std::format`. The reasons: locale awareness, sync with stdio, virtual function calls in the stream hierarchy. For per-frame logging in games, per-request logging in servers, etc., `std::format` + raw write is significantly faster.

## 162. `cerr` and `clog` — Buffered vs Unbuffered
*(Ep. 193)*

Three standard output streams:

| Stream | Buffered? | Flushed on `cout`? | Use for |
|--------|-----------|---------------------|---------|
| `std::cout` | Yes | n/a | Normal output |
| `std::cerr` | **No** (unbuffered) | Implicitly | Errors that must appear immediately |
| `std::clog` | Yes | No | Logs (don't slow down for every write) |

```cpp
std::cerr << "Fatal: " << e.what() << '\n';          // shown instantly even if program crashes
std::clog << "Connection opened from " << addr << '\n'; // buffered like cout
```

Why this matters: if your program crashes after `std::cout << "got here\n";`, the message may never appear (it's still in the buffer). `std::cerr` writes through immediately. Always log critical / debug-trace messages to `cerr` if you don't want to risk losing them.

## 163. `std::ostream` Member Functions
*(Ep. 194)*

Low-level methods that bypass `operator<<` formatting:

```cpp
#include <iostream>

std::cout.put('H');                                  // single char
std::cout.write("Hello\n", 6);                       // raw bytes, no formatting
std::cout.flush();                                   // force flush

std::cout.fill('0');
std::cout.width(5);
std::cout << 42;                                     // "00042"

if (std::cout.good())  { /* stream ok */ }
if (std::cout.fail())  { /* recoverable failure */ }
if (std::cout.bad())   { /* irrecoverable */ }
if (std::cout.eof())   { /* EOF (mostly relevant for cin) */ }
```

`.write()` is essential for binary I/O (section 167). Don't use it for text intermixed with formatted output unless you flush carefully.

## 164. `std::cin`
*(Ep. 195)*

Standard input — also buffered.

```cpp
#include <iostream>
#include <string>

int n;
std::cin >> n;                                       // read an int

std::string word;
std::cin >> word;                                    // one whitespace-delimited word

std::string line;
std::getline(std::cin, line);                        // a whole line

// Check for failure
if (!(std::cin >> n)) {
    std::cerr << "not an int\n";
    std::cin.clear();                                // clear error flags
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');  // skip bad input
}
```

### The mixed `>>` and `getline` trap

```cpp
int n;
std::cin >> n;                                       // leaves the '\n' in the buffer
std::string line;
std::getline(std::cin, line);                        // reads the leftover '\n' — gets empty line!

// Fix: discard rest of line after numeric read
std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
std::getline(std::cin, line);
```

This trips up nearly every C++ student. `operator>>` skips leading whitespace but leaves trailing whitespace (including `'\n'`) untouched. `getline` then reads zero characters and stops at that newline.

## 165. Creating and Appending Files
*(Eps. 196, 197)*

```cpp
#include <fstream>
#include <iostream>

// Write (truncates existing)
std::ofstream out("data.txt");
if (!out) { std::cerr << "open failed\n"; return 1; }
out << "Line 1\n";
out << "Line 2\n";
// file closed when 'out' goes out of scope — RAII

// Append
std::ofstream app("data.txt", std::ios::app);
app << "Line 3\n";

// Binary write
std::ofstream bin("data.bin", std::ios::binary);
int x = 42;
bin.write(reinterpret_cast<const char*>(&x), sizeof(x));
```

### Open modes

| Flag | Meaning |
|------|---------|
| `std::ios::in` | Read (default for `ifstream`) |
| `std::ios::out` | Write (default for `ofstream`; truncates) |
| `std::ios::app` | Append to end |
| `std::ios::trunc` | Truncate (default with `out`) |
| `std::ios::binary` | Binary mode (don't translate `\n`/`\r\n`) |
| `std::ios::ate` | Open and seek to end |

Combine with `|`: `std::ios::in | std::ios::out | std::ios::binary`.

Always check the stream after opening — file might not exist, permissions might be wrong, disk might be full.

## 166. Reading Files
*(Ep. 198)*

```cpp
#include <fstream>
#include <iostream>
#include <string>
#include <sstream>

// Line by line
std::ifstream in("data.txt");
std::string line;
while (std::getline(in, line)) {
    std::cout << line << '\n';
}

// Word by word
std::ifstream in2("data.txt");
std::string word;
while (in2 >> word) {
    /* ... */
}

// Whole file into a string
std::ifstream in3("data.txt");
std::stringstream buf;
buf << in3.rdbuf();
std::string contents = buf.str();
```

### Read a binary file into a vector

```cpp
std::ifstream in("data.bin", std::ios::binary | std::ios::ate);
auto size = in.tellg();
in.seekg(0);

std::vector<char> buf(size);
in.read(buf.data(), size);
```

For text files, prefer line-by-line. For binary, read in chunks (e.g., 64 KiB) for memory-friendly streaming.

## 167. Binary I/O
*(Ep. 199)*

Binary I/O bypasses text formatting — you write the raw memory representation of objects.

```cpp
#include <fstream>

struct Header {
    std::uint32_t magic;
    std::uint16_t version;
    std::uint16_t flags;
};

Header h{0xDEADBEEF, 1, 0};

std::ofstream out("file.bin", std::ios::binary);
out.write(reinterpret_cast<const char*>(&h), sizeof(h));

Header h2;
std::ifstream in("file.bin", std::ios::binary);
in.read(reinterpret_cast<char*>(&h2), sizeof(h2));
```

### Portability hazards

1. **Endianness** — byte order differs between architectures. For cross-platform formats, define an explicit endianness (usually little-endian for modern hardware) and byteswap if needed.
2. **Padding** — the compiler may insert alignment padding between fields. Two structs with the same fields in different order can have different sizes.
3. **Type sizes** — always use `<cstdint>` (`uint32_t`, etc.) for serialized data, never `int`/`long` (whose sizes vary by platform).
4. **Pointers and references** are meaningless after write — they reference memory addresses in this run only.

Always verify your struct has the expected binary size:

```cpp
struct Header {
    std::uint32_t magic;     // 4 bytes
    std::uint16_t version;   // 2 bytes
    std::uint16_t flags;     // 2 bytes
};
static_assert(sizeof(Header) == 8, "Header layout unexpected — check padding");
```

If the assert fails, reorder members or add explicit padding fields. For maximum portability, serialize field-by-field rather than writing the whole struct at once.

> **🏭 Industry Note — Serialization library landscape:**
> | Library | Use case |
> |---|---|
> | **Protobuf** (Google) | RPC, cross-language; binary + schema; mature |
> | **FlatBuffers** (Google) | Zero-copy reads, mobile/games |
> | **Cap'n Proto** | Memory-mapped, low latency |
> | **MsgPack** | Compact, language-agnostic |
> | **CBOR** | RFC standard, used in IoT |
> | **Boost.Serialization** | Header-only C++, supports user types |
> | **cereal** | Modern, header-only, easy custom types |
> | **JSON** (`nlohmann/json`, `simdjson`) | Human-readable, slow vs binary |
>
> **Don't roll your own binary format** unless you have a specific reason (extreme performance, hardware constraints). The portability hazards above (endianness, padding, type sizes) are exactly what these libraries handle for you.

For protocol-style binary I/O in networking code, you'd typically write field-by-field with explicit byte ordering:

```cpp
void write_u32_be(std::ostream& s, std::uint32_t x) {
    char buf[4] = {
        char((x >> 24) & 0xff),
        char((x >> 16) & 0xff),
        char((x >> 8)  & 0xff),
        char(x         & 0xff)
    };
    s.write(buf, 4);
}
```

This avoids both endianness and padding issues at the cost of a few cycles per write.

## 168. Serialize and Deserialize a `struct`
*(Ep. 200)*

A small, complete example of writing and reading a list of records:

```cpp
#include <fstream>
#include <vector>
#include <string>
#include <cstdint>

struct Record {
    std::uint32_t id;
    double        value;
    char          name[16];                          // fixed-size for easy I/O
};

void save(const std::vector<Record>& records, const std::string& path) {
    std::ofstream out(path, std::ios::binary);
    std::uint64_t n = records.size();
    out.write(reinterpret_cast<const char*>(&n), sizeof(n));
    out.write(reinterpret_cast<const char*>(records.data()),
              records.size() * sizeof(Record));
}

std::vector<Record> load(const std::string& path) {
    std::ifstream in(path, std::ios::binary);
    std::uint64_t n;
    in.read(reinterpret_cast<char*>(&n), sizeof(n));
    std::vector<Record> records(n);
    in.read(reinterpret_cast<char*>(records.data()),
            n * sizeof(Record));
    return records;
}
```

For real-world use, libraries like Cap'n Proto, Protocol Buffers, FlatBuffers, or MessagePack handle schema evolution, endianness, and varint encoding — far better choices than hand-rolled binary I/O for any non-trivial format.

## 169. String Streams (`<sstream>`)
*(Ep. 201)*

`std::stringstream` is an in-memory stream backed by a `std::string`. Same `<<` and `>>` interface as `cout`/`cin`.

```cpp
#include <sstream>
#include <iostream>

// Building strings
std::ostringstream oss;
oss << "x = " << 42 << ", y = " << 3.14;
std::string s = oss.str();                           // "x = 42, y = 3.14"

// Parsing strings
std::istringstream iss("42 3.14 hello");
int    a;
double b;
std::string c;
iss >> a >> b >> c;                                  // 42, 3.14, "hello"

// Both directions
std::stringstream ss;
ss << 123;
int n;
ss >> n;                                             // 123
```

### Common idiom: split a string by whitespace

```cpp
std::istringstream iss("the quick brown fox");
std::vector<std::string> words;
std::string word;
while (iss >> word) words.push_back(word);
```

### Split by custom delimiter

```cpp
std::istringstream iss("a,b,c,d");
std::vector<std::string> parts;
std::string p;
while (std::getline(iss, p, ',')) parts.push_back(p);
```

`std::stringstream` is convenient but allocates and has formatting overhead. For hot paths, `std::from_chars` / `std::to_chars` (`<charconv>`) are much faster:

```cpp
#include <charconv>
const char* s = "42";
int n;
std::from_chars(s, s + 2, n);                        // no allocation, no locale
```

## 170. Raw String Literals `R"(...)"`
*(Ep. 202)*

C++11. Lets you write strings without escaping backslashes, quotes, or newlines.

```cpp
std::string path    = R"(C:\Users\Alice\Documents\file.txt)";
std::string regex   = R"(\d+\.\d+)";
std::string json    = R"({"name": "Alice", "age": 30})";

std::string multiline = R"(
SELECT id, name
FROM   users
WHERE  age > 18
)";
```

The `R"(...)"` form uses `(` and `)` as delimiters. If you need to include `)"` in the string, use a custom delimiter:

```cpp
std::string s = R"END(this has )" in it)END";
// delimiter is END( ... )END
```

Indispensable for: file paths on Windows, regular expressions, embedded JSON / SQL / HTML, multiline templates.

## 171. `std::to_string` and `std::stoi`
*(Ep. 202)*

Quick number ↔ string conversions in `<string>`.

```cpp
#include <string>

std::string s1 = std::to_string(42);                 // "42"
std::string s2 = std::to_string(3.14);               // "3.140000" — fixed precision!
std::string s3 = std::to_string(-17);                // "-17"

int    n = std::stoi("42");                          // 42
int    h = std::stoi("ff", nullptr, 16);             // 255 (hex)
double d = std::stod("3.14");                        // 3.14
long   l = std::stol("123456789");

// With error position
std::size_t pos;
int x = std::stoi("42abc", &pos);                    // x = 42, pos = 2
```

### Pitfalls

- `to_string(double)` uses default precision and always uses `.` regardless of locale — but the formatting (`fixed` with 6 digits) is rarely what you want. Prefer `std::format("{}", d)` for better defaults.
- `stoi` throws `std::invalid_argument` on no conversion, `std::out_of_range` on overflow. Catch them or pre-validate.
- For locale-sensitive parsing, use `std::stringstream` with `imbue`.

For performance-critical code, `std::to_chars` / `std::from_chars` (C++17) outperform `to_string` / `stoi` significantly:

```cpp
#include <charconv>

char buf[16];
auto [end, ec] = std::to_chars(buf, buf + sizeof(buf), 42);
*end = '\0';                                          // "42"

int n;
auto [ptr, ec2] = std::from_chars("42", "42" + 2, n); // n = 42
```

No allocation, no exceptions, no locale — just bytes. Among the fastest int/float-to-string converters in any language.

---

# Part XV — Ranges (C++20)

## 172. Ranges Part 1 — Problems They Solve
*(Eps. 226, 227)*

Classic STL works on **iterator pairs**. That's flexible but verbose, error-prone, and inhibits composition. C++20 ranges solve four pain points:

**1. Repetition.** `(v.begin(), v.end())` on every call is noise.

```cpp
// Before
std::sort(v.begin(), v.end());
auto it = std::find(v.begin(), v.end(), 42);

// After (ranges)
std::ranges::sort(v);
auto it = std::ranges::find(v, 42);
```

**2. Mismatched iterator pairs.** `std::sort(v.begin(), w.end())` compiles and is UB. Ranges takes a single object and can't be split.

**3. No composition.** Want "first 10 elements that are even, doubled"? In classic STL you allocate intermediate vectors.

```cpp
// Before — three passes, two temporaries
std::vector<int> evens;
std::copy_if(v.begin(), v.end(), std::back_inserter(evens),
             [](int x){ return x % 2 == 0; });

std::vector<int> first10;
std::copy_n(evens.begin(), std::min<size_t>(10, evens.size()),
            std::back_inserter(first10));

std::vector<int> doubled(first10.size());
std::transform(first10.begin(), first10.end(), doubled.begin(),
               [](int x){ return x * 2; });

// After — one pass, no temporaries
auto result = v | std::views::filter([](int x){ return x % 2 == 0; })
                | std::views::take(10)
                | std::views::transform([](int x){ return x * 2; });
```

**4. Lazy evaluation.** Views don't compute until you iterate. You can compose infinite ranges:

```cpp
// First 5 squares of natural numbers
auto squares = std::views::iota(1)                                // 1, 2, 3, ...
             | std::views::transform([](int n){ return n * n; })
             | std::views::take(5);
// {1, 4, 9, 16, 25}
```

## 173. Ranges Part 2 — Parts of a Range
*(Ep. 228)*

A **range** is anything you can `begin()` and `end()` on. Formally (concepts):

- `std::ranges::range<R>` — has `begin(R)` and `end(R)`.
- `std::ranges::view<R>` — a lightweight, copyable, non-owning range with O(1) move/copy/destroy.
- `std::ranges::sized_range<R>` — knows its size in O(1).
- `std::ranges::forward_range<R>`, `bidirectional_range`, `random_access_range`, `contiguous_range` — iterator-strength refinements.

### Sentinel ≠ iterator (a key generalization)

Classic STL required `end` to be the same type as `begin`. C++20 allows `end` to be a **sentinel** of a different type — useful for null-terminated strings, lazy ranges, and infinite ranges with a stop condition.

```cpp
const char* str = "hello";
// std::ranges::find_if(str, '\0' as a sentinel...) — possible via custom view
```

The classic STL function `std::find` requires `last` to be the same type as `first`. The ranges version `std::ranges::find` only requires it to satisfy the sentinel concept.

### Range adaptors

A **range adaptor** is an object that, given a range, produces a new (lazy) view. The `|` operator pipes a range through an adaptor:

```cpp
auto v2 = v | std::views::reverse;                    // v in reverse, lazily
auto v3 = std::views::reverse(v);                     // equivalent
```

## 174. Views and Adaptors; `ranges::to`
*(Ep. 229)*

Views are **non-owning, lazy, and composable**. Lazy means: elements are processed **one at a time as you iterate**, not all upfront. Copying a view is O(1) — it copies a pointer and some state, not the data.

> A view does no work until you iterate it. Chaining ten views doesn't create ten intermediate vectors — the pipeline is a single fused loop.

Views reference the underlying container — modifying that container can invalidate the view.

```cpp
#include <ranges>
#include <vector>

std::vector<int> v = {1, 2, 3, 4, 5};

auto evens = v | std::views::filter([](int x){ return x % 2 == 0; });
for (int x : evens) std::cout << x << ' ';            // 2 4
```

### Materialize a view back into a container

C++23 added `std::ranges::to`:

```cpp
auto vec = std::views::iota(1, 6)
         | std::views::transform([](int n){ return n * n; })
         | std::ranges::to<std::vector>();             // {1, 4, 9, 16, 25}
```

Before C++23, you'd materialize with a constructor:

```cpp
auto view = v | std::views::filter(/* ... */);
std::vector<int> materialized(view.begin(), view.end());
```

### View overhead

Views are extremely lightweight — typically a pointer + iterator state. Most compose into a single fused loop at `-O2`. But pipelines aren't free of *all* cost: predicates may be re-evaluated, and some adaptors (`filter`, `drop_while`) require multi-pass behavior that downgrades the iterator category.

## 175. `transform`, `drop_while`
*(Ep. 230)*

### `views::transform` — lazy `std::transform`

```cpp
auto squares = v | std::views::transform([](int x){ return x * x; });
```

The function is invoked **per access** during iteration — not once up-front. Don't put expensive computation in a transform if you'll iterate the view multiple times.

### `views::filter` — lazy `std::copy_if`

```cpp
auto evens = v | std::views::filter([](int x){ return x % 2 == 0; });
```

Filter is at most a **forward range** (not bidirectional / random-access) even if the source was random-access, because finding `--it` requires re-scanning.

### `views::take`, `views::drop`

```cpp
auto first3 = v | std::views::take(3);                // {1, 2, 3}
auto last2  = v | std::views::drop(3);                // {4, 5}
```

### `views::take_while`, `views::drop_while`

```cpp
auto front = v | std::views::take_while([](int x){ return x < 4; });   // {1, 2, 3}
auto back  = v | std::views::drop_while([](int x){ return x < 4; });   // {4, 5}
```

`take_while` stops at the first element failing the predicate; `drop_while` skips elements while the predicate is true and then yields the rest **unconditionally** (even if some later elements would also satisfy the predicate).

### `views::reverse`

```cpp
auto rev = v | std::views::reverse;                   // {5, 4, 3, 2, 1}
```

## 176. `views::keys`, `values`, `elements`
*(Ep. 231)*

For ranges of tuples / pairs (like maps):

```cpp
#include <map>
#include <ranges>

std::map<std::string, int> ages = {{"alice", 30}, {"bob", 25}};

for (const auto& key : ages | std::views::keys) {     // names
    std::cout << key << '\n';
}
for (int v : ages | std::views::values) {              // ages
    std::cout << v << '\n';
}

// Generic: project the Nth element of each tuple
std::vector<std::tuple<int, std::string, double>> records = {
    {1, "alice", 3.14}, {2, "bob", 2.71}
};
for (auto& s : records | std::views::elements<1>) {    // strings
    std::cout << s << '\n';
}
```

`views::keys` is shorthand for `views::elements<0>`; `values` is `views::elements<1>`.

## 177. `cartesian_product`, `take`
*(Ep. 231)*

### `views::cartesian_product` (C++23) — all combinations

```cpp
std::vector<int>         xs = {1, 2, 3};
std::vector<std::string> ys = {"a", "b"};

for (auto [x, y] : std::views::cartesian_product(xs, ys)) {
    std::cout << x << y << ' ';
}
// 1a 1b 2a 2b 3a 3b
```

Hugely useful for parametric tests, grid generators, search-space enumeration.

### `views::zip` (C++23) — parallel iteration

```cpp
std::vector<int>         ids   = {1, 2, 3};
std::vector<std::string> names = {"alice", "bob", "charlie"};

for (auto [id, name] : std::views::zip(ids, names)) {
    std::cout << id << ':' << name << '\n';
}
```

### `views::enumerate` (C++23) — index + value

```cpp
for (auto [i, x] : std::views::enumerate(v)) {
    std::cout << i << ": " << x << '\n';
}
```

### Chaining example

```cpp
auto result = std::views::iota(1)
            | std::views::transform([](int n){ return n * n; })
            | std::views::filter([](int n){ return n % 2 == 0; })
            | std::views::take(5);
// {4, 16, 36, 64, 100}
```

Lazy, infinite source, three transformations, bounded by `take(5)` — and the whole thing fuses into a single loop with no heap allocations.

> **🏭 Industry Note — Ranges adoption (2026):**
> - **Brand-new projects:** ranges everywhere, replaces most explicit iterator code.
> - **Pre-C++20 codebases:** use **range-v3** (the prototype library that became C++20 ranges) as a backport.
> - **Compile times:** ranges can balloon compile times (heavy templates); use sparingly in hot headers.
> - **Debugging:** stepping through a ranges pipeline in a debugger is brutal — variable names are decorated with adapter types. Most teams break pipelines back into loops when debugging hot bugs.

> **🎯 Mental Model — Ranges are LINQ for C++:**
> If you've used C# LINQ or Java streams or Rust iterators — ranges are the same idea. Lazy, composable, value-semantic. The pipe operator (`|`) reads left-to-right like a shell pipeline. The trade-off is the same: more declarative, sometimes harder to debug.

---

# Part XVI — Safety & Errors (C++ Safety series)

## 178. The Zero-Overhead Principle
*(Ep. 232)*

Bjarne Stroustrup's "zero-overhead principle" (also "you don't pay for what you don't use"):

1. **You don't pay for what you don't use.** Don't-use exceptions? They cost almost nothing at runtime. Don't use RTTI? No vtable overhead.
2. **What you do use, you can't write better by hand.** `std::vector::operator[]` compiles to one indirect load — no checks, no surprises. `std::sort` outperforms hand-rolled `qsort` because the comparator inlines.

This shapes the whole language: features like virtual calls, exceptions, and RTTI add cost *only when used*. A class without virtual functions has no vtable. A function not in a try block has no extra stack frame for exceptions.

```cpp
struct Plain { int x; };                              // sizeof == 4
struct WithVirtual {                                  // sizeof == 16 (on 64-bit, vtable ptr)
    int x;
    virtual ~WithVirtual() = default;
};
```

**The implication for safety:** safe constructs (smart pointers, `vector`, `string`) are written so that the compiler can optimize them to be as fast as raw memory/arrays/cstrings in release builds. There's rarely a "performance" reason to choose unsafe primitives.

## 179. Language-Level Safety
*(Ep. 233)*

C++ inherits C's "trust the programmer" stance, which leaves many safety gaps. Modern C++ has tools to close most of them, but you have to opt in.

### Categories of safety

| Category | Risk | Modern remedy |
|----------|------|---------------|
| **Memory** | dangling, double-free, leaks | smart pointers, RAII, `vector` |
| **Bounds** | array overflow | `.at()`, `gsl::span`, `-D_GLIBCXX_DEBUG` |
| **Type** | UB via cast | `static_cast`, `std::bit_cast`, `std::variant` |
| **Lifetime** | use-after-free, dangling refs | borrow rules (manual), AddressSanitizer |
| **Initialization** | reading uninit data | `{}` init, `-Wuninitialized` |
| **Integer** | overflow, narrowing | `-fsanitize=undefined`, `std::cmp_*` |
| **Concurrency** | data races | mutexes, atomics, ThreadSanitizer (not covered here) |

### Tools to catch the rest

```bash
g++ -std=c++23 -Wall -Wextra -Wpedantic -Wconversion -Wshadow \
    -fsanitize=address,undefined -O1 -g app.cpp
```

| Tool | Catches |
|------|---------|
| `-fsanitize=address` (ASan) | OOB, use-after-free, leaks |
| `-fsanitize=undefined` (UBSan) | signed overflow, null deref, UB casts |
| `-fsanitize=thread` (TSan) | data races |
| `-D_GLIBCXX_DEBUG` (libstdc++) | iterator invalidation, OOB on `operator[]` |
| `-D_LIBCPP_DEBUG=1` (libc++) | similar for libc++ |
| Valgrind | leaks, uninit reads (no recompile) |
| Static analyzers (clang-tidy, cppcheck, MSVC `/analyze`) | lifetime, nullness |

**Use these in CI, not just locally.** A test suite running under ASan + UBSan catches a large fraction of memory and UB bugs.

> **🏭 Industry Note — Memory safety in 2026 — the elephant in the room:**
> Industry data shows ~70% of CVEs in C/C++ codebases are memory safety bugs (use-after-free, buffer overflow, type confusion). This has driven:
> - **Microsoft, Google** publicly stating new components should be written in **Rust** when possible.
> - **Linux kernel** accepted Rust as a second language (in addition to C).
> - **Android** writing new code in Rust; legacy C++ being incrementally hardened.
> - **WebAssembly** and **sandboxing** for isolating untrusted code paths.
> - **C++ "profiles"** (proposed for C++26) — a way to opt into language-level safety guarantees on a per-file basis.
>
> For now: in C++, your defenses are RAII + smart pointers + sanitizers + fuzzing + bounds-checked containers + concepts. Use all of them.

## 180. Attributes (`[[nodiscard]]`, `[[noreturn]]`, …)
*(Ep. 234)*

Attributes annotate code with semantics the compiler can check or optimize against.

### `[[nodiscard]]`

Warns if the return value is ignored. Catches bugs where someone calls a pure / fallible function and drops the result.

```cpp
[[nodiscard]] int compute();
[[nodiscard("memory leak: store the pointer")]]
char* allocate();

// nodiscard on a type — every function returning that type triggers
[[nodiscard]] struct Status { /* ... */ };
```

Apply to: pure functions, factory functions returning owned resources, fallible APIs (`std::optional`, `std::expected`).

### `[[noreturn]]`

Tells the compiler a function never returns (it calls `std::abort`, `throw`s unconditionally, `std::exit`s).

```cpp
[[noreturn]] void die(const std::string& msg) {
    std::cerr << msg << '\n';
    std::abort();
}

int classify(int x) {
    if (x < 0) die("negative");
    return x;
    // No "missing return" warning because die never returns.
}
```

### `[[maybe_unused]]`

Suppress unused-variable warnings — especially helpful for parameters used only in some build configurations.

```cpp
void log([[maybe_unused]] const std::string& tag, int code) {
    #ifdef DEBUG
    std::cerr << tag << ": " << code;
    #else
    std::cerr << code;
    #endif
}
```

### `[[deprecated]]`

```cpp
[[deprecated("use parse_v2 instead")]]
int parse(const std::string& s);
```

Generates a warning at every call site — useful during API migrations.

### `[[likely]]`, `[[unlikely]]` (C++20)

Branch-prediction hints. Use only when profiling shows it helps.

```cpp
if (error_code) [[unlikely]] {
    handle_error();
}
```

### `[[fallthrough]]` (C++17)

Suppresses warning that you forgot a `break` in a `switch`.

```cpp
switch (n) {
    case 1:
        do_thing();
        [[fallthrough]];      // intentional!
    case 2:
        do_other();
        break;
}
```

## 181. Prefer `explicit` and `{}`-Initialization
*(Ep. 235)*

Two language defaults that lead to bugs; modern best practice flips them.

### `explicit` on single-arg constructors

By default, a single-argument constructor enables **implicit conversions** — sometimes useful, often surprising.

```cpp
struct Distance {
    Distance(int meters);     // NOT explicit — implicit conversion enabled
};

void travel(Distance d);
travel(42);                    // compiles! 42 → Distance(42)
```

That conversion may not be intended (`42` could be miles, dollars, anything). Marking the constructor `explicit` forces the call site to be unambiguous:

```cpp
struct Distance {
    explicit Distance(int meters);
};

travel(42);                    // ❌ compile error
travel(Distance{42});          // ✅ clear
```

**Rule of thumb:** `explicit` on all single-arg constructors unless implicit conversion is genuinely desirable (e.g., `std::string` accepting `const char*`).

### `{}`-initialization (uniform initialization)

`{}` initialization disallows **narrowing conversions**, while `()` allows them silently:

```cpp
int  a(3.14);     // a == 3, silent truncation
int  b{3.14};     // ❌ compile error: narrowing
int  c = 3.14;    // same as a — silent
int  d = {3.14};  // ❌ compile error
```

This catches a class of bugs (float-to-int, long-to-int, double-to-float) at compile time.

```cpp
struct Color { uint8_t r, g, b; };

Color c1{300, 0, 0};           // ❌ 300 doesn't fit in uint8_t
Color c2(300, 0, 0);           // compiles, wraps to 44 — bug!
```

The only gotcha: `{}` interacts with `std::initializer_list` (section 60). For most types this doesn't matter; for `std::vector` it does:

```cpp
std::vector<int> v1(10, 5);   // 10 fives
std::vector<int> v2{10, 5};   // 2 elements: 10 and 5
```

So: prefer `{}` everywhere except where you specifically need a count/size constructor on a container.

## 182. Exceptions: Introduction
*(Eps. 236, 237)*

Exceptions are C++'s mechanism for propagating errors from where they're detected to where they can be handled. They unwind the stack, calling destructors along the way (this is what RAII makes safe).

### Syntax

```cpp
#include <stdexcept>
#include <iostream>

int divide(int a, int b) {
    if (b == 0)
        throw std::invalid_argument("division by zero");
    return a / b;
}

int main() {
    try {
        std::cout << divide(10, 0) << '\n';
    } catch (const std::invalid_argument& e) {
        std::cerr << "caught: " << e.what() << '\n';
    } catch (const std::exception& e) {        // base class — catch-all for std exceptions
        std::cerr << "other: " << e.what() << '\n';
    } catch (...) {                            // truly catch-all
        std::cerr << "unknown\n";
    }
}
```

### `std::exception` hierarchy (subset)

```
std::exception
├── std::logic_error            (programmer error — could have been avoided)
│   ├── std::invalid_argument
│   ├── std::out_of_range
│   ├── std::domain_error
│   └── std::length_error
├── std::runtime_error          (external / environmental error)
│   ├── std::overflow_error
│   ├── std::range_error
│   └── std::system_error       (with std::error_code)
├── std::bad_alloc              (new failed)
├── std::bad_cast               (dynamic_cast on reference failed)
└── std::bad_optional_access
```

**Always catch by `const reference`** (`catch (const std::exception&)`). Catching by value slices polymorphic exceptions; catching by pointer is awkward because the lifetime is unclear.

### Re-throwing

```cpp
try {
    risky();
} catch (const std::exception& e) {
    std::cerr << "logging: " << e.what() << '\n';
    throw;                                     // re-throw the *original* exception
}
```

`throw;` (no expression) preserves the original exception type — important if you catch as base class but want to propagate the actual derived type.

## 183. Exceptions and RAII
*(Ep. 238)*

The killer feature: when an exception propagates, **destructors run** for every fully-constructed local object on the stack. This is what makes resource cleanup automatic.

```cpp
void process(const std::string& path) {
    std::ifstream in(path);                    // RAII: file closed on any exit
    std::lock_guard lock(global_mutex);        // RAII: mutex released on any exit
    auto buf = std::make_unique<char[]>(1024); // RAII: memory freed on any exit

    if (!in) throw std::runtime_error("cannot open " + path);

    // ... use buf, in, lock ...

    // If anything throws here, all three are cleaned up correctly.
}
```

The same code without RAII — using `malloc`/`free`, `pthread_mutex_lock`/`unlock`, manual `close()` — would need every error path to do explicit cleanup. Easy to miss; easy to leak; impossible to handle correctly when *new code* throws.

**The contrapositive**: if you have classes that *don't* use RAII (raw `new`, `FILE*`, `malloc`), exceptions are dangerous because they can skip cleanup. The first defense is making your types RAII-correct, *then* enabling exceptions.

### `noexcept` — promise not to throw

```cpp
void clean_up() noexcept {
    // If a noexcept function throws, std::terminate is called immediately.
}
```

Mark destructors, move constructors, and `swap` as `noexcept` whenever possible. This unlocks STL optimizations (e.g., `std::vector` moves elements during reallocation only if the move ctor is `noexcept`; otherwise it falls back to slower copies).

## 184. Stack Unwinding
*(Ep. 239)*

When a `throw` happens, control transfers to the nearest matching `catch`. As control travels up the call stack, every local object's destructor is called in **reverse construction order**.

```cpp
struct Trace {
    std::string name;
    Trace(std::string n) : name(std::move(n)) { std::cout << "ctor " << name << '\n'; }
    ~Trace()                                   { std::cout << "dtor " << name << '\n'; }
};

void inner() {
    Trace t1("inner1");
    Trace t2("inner2");
    throw std::runtime_error("boom");
    // t2, t1 destroyed in reverse
}

void outer() {
    Trace t3("outer3");
    inner();                                    // exception propagates through
    // t3 destroyed before catch in main()
}

int main() {
    try {
        outer();
    } catch (const std::exception& e) {
        std::cout << "caught\n";
    }
}
// Output:
// ctor outer3
// ctor inner1
// ctor inner2
// dtor inner2
// dtor inner1
// dtor outer3
// caught
```

### When unwinding fails: `std::terminate`

If a destructor throws **while another exception is in flight**, the program calls `std::terminate()` (which by default calls `std::abort`). This is why destructors should virtually always be `noexcept`.

```cpp
struct Bad {
    ~Bad() { throw std::runtime_error("bad"); }  // dangerous!
};
```

If a `Bad` is destroyed during stack unwinding, the program dies. C++11 made destructors implicitly `noexcept` to discourage this.

## 185. Why Some People Hate Exceptions
*(Ep. 240)*

Real, common objections:

**1. Hidden control flow.** Looking at a function, you can't tell what calls might throw without inspecting every callee transitively. Compare with `Result`-style return types in Rust.

**2. Cost on the happy path is small but nonzero.** Tables for stack unwinding bloat binaries. Profile-guided optimizations can be limited. For some hot paths (game engines), this matters.

**3. Cost on the failure path is large.** Throwing involves walking the stack, calling many destructors, lookup in unwind tables. Microseconds, not nanoseconds. In a low-latency trading or game-loop context, this is unacceptable.

**4. Hard to use in resource-constrained / embedded environments.** Real-time systems can't tolerate unbounded latency. Embedded toolchains often disable exceptions (`-fno-exceptions`) entirely.

**5. Lifetime / safety hazards.** Code that's not exception-safe (no RAII) breaks in subtle ways when exceptions are enabled. Some codebases ban exceptions to avoid having to enforce RAII strictly.

**6. ABI fragmentation.** Code compiled with and without exceptions doesn't mix cleanly. Cross-language boundaries (C, Rust, Python) require exception barriers.

### Style guides

- **Google C++ Style Guide** historically banned exceptions; the policy is more nuanced now but new code in Google tends to avoid them.
- **LLVM** disables exceptions internally for size and ABI reasons.
- **Game engines** (Unreal, Unity native, custom engines) typically disable exceptions and use sentinel return codes.
- **Mozilla, Chromium** mixed.
- **Most "ordinary" application code** uses exceptions freely.

### Alternatives

- `std::optional<T>` for "value or nothing."
- `std::expected<T, E>` (C++23) for "value or error" (Rust's `Result`).
- `std::error_code` for low-level OS-style errors without unwinding.

> **✅ Decision Rule — Error handling pick chart:**
> ```
> What kind of error?
>   ├── Programmer bug (precondition violated)
>   │     → assert / contract (debug only) OR std::abort
>   ├── Resource exhaustion / truly exceptional
>   │     → throw exception (memory, file I/O, network failure)
>   ├── Expected failure mode (parse error, key not found, parse number)
>   │     ├── No error info needed → std::optional<T>
>   │     ├── Error info needed → std::expected<T, ErrorType> (C++23) or Result<T, E> (custom)
>   │     ├── OS errno style → std::error_code
>   │     └── Returning bool + out-param → legacy; avoid in new code
>   └── Distributed system / cross-process
>         → status code in protocol (gRPC status, HTTP code) — not exceptions
> ```
>
> The modern consensus: **exceptions for the truly exceptional, `std::expected` for the routine.**

> **🏭 Industry Note — Per-domain exception policy:**
> | Domain | Exception policy |
> |---|---|
> | Application code (apps, services) | Use freely; modern style |
> | Game engines | Disabled (`-fno-exceptions`); use return codes / assertions |
> | High-frequency trading | Disabled; sentinels + branchless code |
> | Embedded (automotive, aerospace) | Disabled; MISRA forbids |
> | Plugin APIs / DLL boundaries | Translate to error codes at the boundary; exceptions don't cross ABIs reliably |
> | Coroutine code | Often disabled; coroutines + exceptions interact awkwardly |
>
> **Rule:** when calling a library, know its exception policy. Catch exceptions at API boundaries to translate them; don't let library exceptions surface to callers who can't handle them.

## 186. Exceptions in a Real-World Codebase (OGRE 3D)
*(Ep. 241)*

Mike walks through OGRE 3D — a graphics engine that does use exceptions — to show idiomatic usage. Key takeaways:

1. **Custom exception hierarchy** rooted in a `OgreException` extending `std::exception`. Each derived class signals a category (file not found, invalid parameter, internal error).
2. **Macros for `throw` sites** that capture file/line and assemble a useful message. C++20's `std::source_location` lets you do this without macros now.
3. **Exceptions used at API boundaries**, not in tight loops. Initialization, resource loading, parsing — yes. Per-frame rendering — no.
4. **`OGRE_EXCEPT` always throws by value** with full type info, and is caught by reference at well-defined "exception barriers" (top of frame loop, plugin boundary).

The lesson: when used as an *API-boundary* mechanism for exceptional conditions, exceptions add little overhead and clarify control flow. The "ban exceptions" guidance is about specific contexts (real-time, embedded), not a universal rule.

## 187. `std::stacktrace` (C++23)
*(Ep. 242)*

C++23 added programmatic stack trace capture, finally giving C++ the kind of debug info Python and Java have had for decades.

```cpp
#include <stacktrace>
#include <iostream>

void inner() {
    auto trace = std::stacktrace::current();
    std::cout << trace;                        // formatted, multi-line
}

void outer() { inner(); }
int  main()  { outer(); }
```

Output (approximate):
```
0# inner at app.cpp:5
1# outer at app.cpp:11
2# main at app.cpp:12
```

### Storing in custom exceptions

```cpp
class AppError : public std::runtime_error {
    std::stacktrace trace_;
public:
    AppError(const std::string& msg)
        : std::runtime_error(msg)
        , trace_(std::stacktrace::current()) {}

    const std::stacktrace& where() const noexcept { return trace_; }
};

try {
    throw AppError("something failed");
} catch (const AppError& e) {
    std::cerr << e.what() << '\n' << e.where() << '\n';
}
```

Note: capturing a stacktrace is **not** free — it can take hundreds of microseconds. Don't do it on every operation; do it when constructing the error object so it's there if needed.

Compiler/library support is uneven: GCC 14+, libstdc++ with `-lstdc++_libbacktrace` on Linux; MSVC has support; Clang is still catching up as of 2026.

## 188. Function-Try-Block
*(Ep. 243)*

A rarely-used feature: a `try`/`catch` that wraps the **entire function body**, including the member initializer list of constructors.

```cpp
struct Connection {
    std::ifstream input_;
    std::ofstream output_;

    Connection(const std::string& in_path, const std::string& out_path)
    try : input_(in_path), output_(out_path)   // member init list inside try
    {
        if (!input_)  throw std::runtime_error("input failed");
        if (!output_) throw std::runtime_error("output failed");
    } catch (const std::exception& e) {
        // Cleanup or rethrow.
        std::cerr << "construction failed: " << e.what() << '\n';
        throw;                                  // implicit rethrow in ctor's function-try-block
    }
};
```

### Constructor caveat

In a constructor's function-try-block, the catch handler **must rethrow** — once a constructor's body or initializer list throws, the object was never fully constructed and you cannot return from the catch normally. The compiler inserts an implicit `throw;` if you don't.

Why use it? The catch handler can see and act on initialization failures that happen in the member init list — something an ordinary try block inside the body can't reach.

In practice this is rare; usually you'd refactor to avoid the need, e.g., by validating inputs before the init list or by using factory functions.

## 189. Custom `std::exception`
*(Ep. 244)*

Define your own exception types for domain-specific errors.

```cpp
#include <exception>
#include <string>

class ParseError : public std::exception {
    std::string msg_;
    std::size_t line_;
    std::size_t col_;
public:
    ParseError(std::string msg, std::size_t line, std::size_t col)
        : msg_(std::move(msg)), line_(line), col_(col)
    {
        msg_ = "Parse error at " + std::to_string(line_) + ':' +
               std::to_string(col_) + ": " + msg_;
    }

    const char* what() const noexcept override { return msg_.c_str(); }
    std::size_t line() const noexcept { return line_; }
    std::size_t col()  const noexcept { return col_; }
};

try {
    parse_config(path);
} catch (const ParseError& e) {
    std::cerr << e.what() << '\n';
    // Programmatically use e.line() to highlight in editor, etc.
}
```

### Hierarchies

For a real system, build a small hierarchy that lets callers catch at the granularity they need:

```cpp
class NetworkError : public std::runtime_error {
public:
    using std::runtime_error::runtime_error;
};

class TimeoutError       : public NetworkError { using NetworkError::NetworkError; };
class ConnectionRefused  : public NetworkError { using NetworkError::NetworkError; };
class ProtocolError      : public NetworkError { using NetworkError::NetworkError; };

try {
    send(packet);
} catch (const TimeoutError&)      { /* retry */ }
catch (const NetworkError&)        { /* fail and log */ }
catch (const std::exception&)      { /* anything else */ }
```

Catch order matters: most-derived types must come first, or they'll be shadowed by the base.

## 190. Error Codes — `std::error_code`
*(Ep. 246)*

`<system_error>` provides a unified error-code framework: integer codes typed by a category. Used by `<filesystem>`, networking proposals, and many third-party libraries.

```cpp
#include <system_error>
#include <iostream>

void open_file_noexcept(const std::string& path, std::error_code& ec) {
    std::ifstream in(path);
    if (!in) {
        ec = std::make_error_code(std::errc::no_such_file_or_directory);
        return;
    }
    ec.clear();
    // ...
}

std::error_code ec;
open_file_noexcept("missing.txt", ec);
if (ec) {
    std::cerr << "error: " << ec.message() << " (category: " << ec.category().name() << ")\n";
}
```

### Why use this over exceptions?

- **No unwinding cost** on the failure path — just check a return value.
- **Cross-platform error semantics** — `std::errc::*` maps to `errno` codes uniformly across Windows / POSIX.
- **Composable** — one error code can be checked against multiple categories.

### Custom error categories

```cpp
enum class my_errc { ok = 0, invalid_input, out_of_memory };

class my_category_t : public std::error_category {
public:
    const char* name() const noexcept override { return "myapp"; }
    std::string message(int ev) const override {
        switch (static_cast<my_errc>(ev)) {
            case my_errc::ok:            return "ok";
            case my_errc::invalid_input: return "invalid input";
            case my_errc::out_of_memory: return "out of memory";
        }
        return "unknown";
    }
};

const std::error_category& my_category() {
    static my_category_t inst;
    return inst;
}

std::error_code make_error_code(my_errc e) {
    return {static_cast<int>(e), my_category()};
}
```

C++23's `std::expected<T, E>` is a more modern alternative — values OR errors, with monadic operations.

## 191. `std::optional` and Monadic Operations (C++23)
*(Ep. 247)*

`std::optional<T>` represents "a value or nothing" — useful for fallible lookups, optional parameters, and as a return type alternative to exceptions.

```cpp
#include <optional>
#include <iostream>

std::optional<int> parse_int(const std::string& s) {
    try { return std::stoi(s); }
    catch (...) { return std::nullopt; }
}

if (auto n = parse_int("42")) {
    std::cout << *n << '\n';                  // 42
}
if (auto n = parse_int("abc")) {              // nothing
    std::cout << *n << '\n';
} else {
    std::cout << "not a number\n";
}
```

### Access patterns

```cpp
std::optional<int> opt = 42;

if (opt.has_value())   { /* ... */ }
if (opt)               { /* implicit bool */ }

int a = *opt;                                 // UB if empty
int b = opt.value();                          // throws std::bad_optional_access if empty
int c = opt.value_or(0);                      // 0 if empty (safe default)
```

### Constructing

```cpp
std::optional<int> a;                          // empty
std::optional<int> b = 42;
std::optional<int> c = std::nullopt;
std::optional<std::string> d(std::in_place, 5, 'a');   // emplace: "aaaaa"

a.emplace(99);                                 // construct in place
a.reset();                                     // back to empty
```

### Monadic operations (C++23)

The killer feature: chain operations without nested `if`s.

```cpp
std::optional<int> parse_int(const std::string&);
std::optional<int> double_if_even(int);

// Old style — nested checks
auto r1 = parse_int("42");
std::optional<int> result;
if (r1) {
    auto r2 = double_if_even(*r1);
    if (r2) {
        result = *r2 + 1;
    }
}

// New style — monadic
auto result = parse_int("42")
            .and_then(double_if_even)              // chain another optional-returning fn
            .transform([](int x){ return x + 1; }) // map a value-returning fn
            .or_else([]{ return std::optional{-1}; }); // fallback
```

| Method | Purpose |
|--------|---------|
| `and_then(f)` | `f` returns optional; flat-map. Skip if empty. |
| `transform(f)` | `f` returns value; map. Skip if empty. |
| `or_else(f)` | `f` returns optional; called if empty. |

This is monadic composition — the same pattern you'd see in Rust's `Option`, Haskell's `Maybe`, Java's `Optional`. C++23 brought C++ to parity.

### `std::expected<T, E>` (C++23, not in this playlist)

For the more general "value or specific error type" case, C++23 also adds `std::expected<T, E>`, which has the same monadic interface but carries an error value on the failure side. The playlist scopes this out, but it's worth knowing.

---

# Part XVII — Closing

## 192. Idioms, Pitfalls & Best Practices Cheat Sheet

### Resource management

- **RAII for everything.** Every resource (memory, files, sockets, mutexes, GPU handles) lives in a class whose destructor releases it.
- **Smart pointers over raw `new`/`delete`.** `unique_ptr` by default; `shared_ptr` only when ownership is genuinely shared.
- **Pass non-owning references with `T&` / `const T&` / `T*`**, not smart pointers, unless you're transferring ownership.
- **`make_unique` / `make_shared`** are preferred over `unique_ptr<T>(new T(...))`. Exception-safe and fewer allocations for `shared_ptr`.

### Const correctness

- **`const` member functions** for any method that doesn't modify state.
- **`const T&` parameters** for read-only large objects.
- **Avoid `const` on by-value return** (legacy advice; no longer recommended — inhibits move semantics).
- **`mutable`** only for caching / synchronization state, never for logical state.

### Initialization

- **Use `{}` initialization** to catch narrowing conversions.
- **`auto x = T{...}`** for the AAA (Almost Always Auto) style.
- **Initialize members in-class** with `= 0` / `{}` defaults so constructors don't have to.
- **Member init lists** in constructors, in order matching declaration order.

### Performance

- **Pass by value for sinks** that will store a copy anyway (`T x` then `member = std::move(x)`).
- **Pass by `const T&`** for read-only.
- **Pass by `T&&` only for true sinks** that will move-construct from the argument.
- **Avoid premature copies.** Prefer references in range-for: `for (const auto& x : v)`.
- **Reserve before pushing** into vectors: `v.reserve(n)`.
- **`emplace_back` instead of `push_back`** for in-place construction.

### Modern idioms

- **Structured bindings** (`auto [a, b] = pair`) over `pair.first / .second`.
- **`if`/`switch` init** (`if (auto it = m.find(k); it != m.end())`) to limit scope.
- **`std::optional` / `std::expected`** for fallible returns when exceptions are too heavy.
- **`std::variant` + `std::visit`** over inheritance for closed sums of types.
- **`std::span` / `std::string_view`** for non-owning views into contiguous data.

### Pitfalls to avoid

- **Dangling `string_view` / `span`** — they don't own; outliving the underlying string/vector is UB.
- **`auto` with proxies** — `for (auto x : std::vector<bool>)` copies a proxy, not a bool. Use `for (bool x : v)`.
- **Object slicing** when passing derived types by value to base-typed parameters.
- **Iterator invalidation** after container modification (see section 127).
- **Initialization-order fiasco** for non-local statics across translation units. Use Meyers singletons (function-local statics).
- **Self-assignment in `operator=`** — handle with copy-and-swap or explicit `this == &other` check.
- **Returning `this` by reference from `operator=`** but not handling self-move.

### Build hygiene

- **`-Wall -Wextra -Wpedantic`** always.
- **`-fsanitize=address,undefined`** in debug builds and CI.
- **Header guards / `#pragma once`** in every header.
- **Forward-declare** instead of `#include` when possible to cut build times.
- **`extern template`** for heavy templates to avoid duplicate instantiation across TUs.
- **Use a build system** (CMake, Bazel, Meson) — never `g++ *.cpp` past a tiny demo.

### Networking / systems context (interest-aligned)

For your domain (routing, AI/ML networks, system programming):

- **Use `std::array` / `std::span` for protocol buffers** — fixed-layout, no allocations, range-checked in debug.
- **`std::byte` for raw byte data** — distinguishes bytes from `char` / `int` in interfaces.
- **`std::endian` (C++20)** for compile-time byte-order checks.
- **`std::bit_cast`** for safe type punning over `reinterpret_cast` (sections 82, 84).
- **`<cstdint>` types only** in wire formats (`uint32_t`, never `int`).
- **Avoid `std::unordered_map` with externally-controlled keys** — hash-collision DoS risk. Use `std::map` or a hash-flooded-tolerant map.
- **`std::variant` for packet types** — exhaustive `visit` catches missing handlers at compile time.
- **`noexcept` move ops on packet/message types** so containers can move them efficiently.

---

### Industry essentials cheat sheet

#### Code review red flags

| Flag | Why |
|------|-----|
| `new` / `delete` outside a class destructor | Should be `unique_ptr` / `vector` |
| `shared_ptr` without justification | Probably `unique_ptr` suffices |
| C-style cast `(T)x` | Ambiguous intent; use named casts |
| `reinterpret_cast` outside low-level code | Almost always wrong; use `std::bit_cast` |
| `using namespace std;` in a header | Pollutes everyone's TU |
| Raw `new[]` array | Use `std::vector` or `std::make_unique<T[]>` |
| `static` mutable global | Initialization-order fiasco or thread safety |
| Function returning `T*` (no doc on ownership) | Use `unique_ptr`, `T&`, `T*` (non-owning), or `optional<T>` |
| `catch(...)` then swallowing | At minimum, log; usually rethrow |
| Hand-rolled loop where STL algorithm fits | "No raw loops" |

#### Common-case performance gotchas

| Pattern | Cost | Fix |
|---------|------|-----|
| `vec.push_back` without `reserve` | Multiple reallocations | `vec.reserve(n)` |
| `map[key] = value` (creates if absent) | Default-construct + assign | `map.insert_or_assign(key, value)` or `try_emplace` |
| `string s = "..." + a + b;` | Temporary strings | `s.reserve(...)` then `+=`, or `std::format` |
| `for (auto x : vec_of_strings)` | Copies each string | `for (const auto& x : ...)` |
| `std::shared_ptr` in tight loop copy | Atomic ref count ops | Pass by `const T*` or `T&` for borrow |
| `std::endl` in every log line | Flush per line | `'\n'` and explicit `flush` when needed |
| `std::unordered_map` with default hash | Pointer chasing | `absl::flat_hash_map` or similar |
| Throwing exception across DLL boundary | Undefined / crashes | Translate to error code at the boundary |
| Virtual function called billions of times | Indirect call, no inline | Concept + template, or CRTP |
| `std::list` for sequential data | Cache misses | `std::vector` (almost always) |

#### Testing patterns

- **Unit tests** — pure functions in isolation. GoogleTest, Catch2, doctest.
- **Integration tests** — real I/O, fake clocks, in-memory DBs.
- **Fuzz tests** — random input to parsers/protocol code. libFuzzer, AFL++.
- **Property tests** — invariants over generated input. RapidCheck (Hypothesis for C++).
- **Benchmark tests** — Google Benchmark, nanobench. Pin to specific cores for stability.
- **Static analysis** — clang-tidy + cppcheck in CI.
- **Sanitizers** — ASan, UBSan, TSan in every CI build that can afford the 2-3× slowdown.

#### Logging / observability essentials

- **Structured logging** (key-value, JSON output) — spdlog, glog. Better than free-form strings for production debugging.
- **Distributed tracing** — OpenTelemetry C++ SDK. Critical in microservices.
- **Metrics** — Prometheus client library, or Datadog/StatsD client.
- **Crash reporting** — Breakpad (Chromium), Sentry, custom signal handler + `std::stacktrace` (C++23).
- **Production heap profiling** — heaptrack (Linux), tcmalloc / jemalloc profilers.

#### When to break the rules

The rules in this guide are good defaults — not absolutes. **Senior judgment** is knowing when:
- **Use globals** for true singletons (the logger, the allocator) via Meyers singleton.
- **Use `shared_ptr`** when ownership genuinely is shared and clear (graph nodes, callback registry).
- **Use raw `new`** inside RAII wrapper class implementations.
- **Use `reinterpret_cast`** at hardware boundaries (DMA buffers, registers).
- **Use exceptions** even in performance code — the unwind cost is only on the failure path.
- **Skip `const`** in hot paths where the compiler proves the variable isn't reassigned anyway.
- **Use macros** for log call-site capture (`__FILE__`/`__LINE__`) until `std::source_location` is universally available.

The reason every rule has exceptions: C++ is a *systems language*, and systems work pushes against every abstraction. Knowing the default and knowing when to deviate is the senior-engineer skill.

## 193. Resources & Further Reading

### Books

- **Bjarne Stroustrup, *The C++ Programming Language*, 4th ed.** — the canonical reference, by the language's creator.
- **Bjarne Stroustrup, *A Tour of C++*, 3rd ed. (C++20).** — short, modern, an excellent companion to this guide.
- **Scott Meyers, *Effective Modern C++*.** — 42 items, deep dives into C++11/14 semantics. Still essential.
- **Nicolai Josuttis, *The C++ Standard Library*, 2nd ed.** — detailed STL reference.
- **Nicolai Josuttis, *C++20 - The Complete Guide* and *C++17 - The Complete Guide*.** — what changed in those standards.
- **Anthony Williams, *C++ Concurrency in Action*, 2nd ed.** — for the threading topics deliberately scoped out of this guide.

### Online references

- **[cppreference.com](https://en.cppreference.com)** — the unofficial-but-de-facto authoritative reference. Every standard library entry has an example.
- **[isocpp.org](https://isocpp.org)** — official; tracks the standard and "C++ Core Guidelines" by Stroustrup and Sutter.
- **[godbolt.org](https://godbolt.org) (Compiler Explorer)** — see assembly output across compilers and standards. Indispensable for understanding what the compiler actually does.
- **[quick-bench.com](https://quick-bench.com)** — quick microbenchmarks across compilers.
- **[hsutter.github.io/cppfront](https://hsutter.github.io/cppfront/)** — Herb Sutter's experimental syntax-2 frontend. Glimpse of where C++ might go.

### Style guides

- **C++ Core Guidelines** — https://isocpp.org/CppCoreGuidelines — Stroustrup and Sutter's curated rules.
- **Google C++ Style Guide** — opinionated; useful as a contrast.
- **LLVM Coding Standards** — pragmatic, exception-free style.

### Tools to learn next

- **CMake** — build system.
- **Conan / vcpkg** — package managers.
- **clang-tidy / clang-format** — linting and formatting.
- **Catch2 / GoogleTest / doctest** — testing frameworks.
- **AddressSanitizer / UndefinedBehaviorSanitizer / ThreadSanitizer** — bug-finding sanitizers (built into Clang and GCC).
- **gdb / lldb** — debuggers; pair with `pretty-printers` for STL types.
- **perf / VTune / Tracy** — profilers, in increasing order of GUI polish.

### Mike Shah's other content

- **Software Design / Design Patterns playlist** — covers concurrency, design patterns, and topics scoped out of the language playlist.
- **Software Engineering with C++ playlist** — build systems, CMake, tooling, larger-scale concerns.

### Topics deliberately scoped out (revisited)

Recapping what this guide *doesn't* cover, with starter pointers for each:

- **Concurrency** — `<thread>`, `<mutex>`, `<atomic>`, `<condition_variable>`. Start with Williams' book.
- **C++20 Modules** — `import std;`, `export module foo;`. Adoption is uneven as of 2026; check your toolchain.
- **C++20 Coroutines** — `co_await`, `co_yield`, `co_return`. Powerful but low-level; you'll usually use a coroutine library like cppcoro or Asio's coroutines, not raw primitives.
- **`<filesystem>`** — directory traversal, paths, file metadata. C++17. Largely self-explanatory once you know the rest of the language.
- **`std::expected` (C++23)** — like `std::optional` (section 191) but carrying an error value on the empty side. Same monadic interface.

---

### Learning roadmap (90-day plan)

**Days 1–14 — Foundations (Parts I–III)**
- Daily reps writing Hello World variants, simple functions, pointer puzzles.
- Build something small from scratch: a CSV parser, a JSON pretty-printer, a calculator.
- Read AddressSanitizer + UBSan output until they stop scaring you.

**Days 15–30 — Classes & memory (Parts IV–V)**
- Implement a simple `String` class with Rule of 5. Then throw it away and use `std::string`.
- Build a class hierarchy (shapes, animals, file formats) with virtual functions.
- Refactor one hierarchy into `std::variant`. Compare.

**Days 31–50 — Templates & STL (Parts VI–XII)**
- Write `min`, `max`, `find`, `accumulate` from scratch. Then use the STL versions and read their source.
- Pick 10 algorithms; for each, write a manual loop, then refactor to use the algorithm.
- Implement a custom iterator for a container you make up (ring buffer, sparse vector, tree).

**Days 51–70 — Modern features (Parts XIII–XV)**
- Build a string-formatting helper using `std::format`. Make it pretty-print custom types.
- Take a non-trivial algorithm (image processing, log parsing) and rewrite using ranges.
- Profile before and after with Google Benchmark.

**Days 71–90 — Production patterns (Part XVI + the wider world)**
- Add fuzz tests to a parser you wrote.
- Set up CI with Bazel or CMake + GitHub Actions, sanitizers on every PR.
- Contribute a small fix to an open-source C++ project. (LLVM, fmt, range-v3, doctest are friendly.)

### Industry "what to learn next" by role

| Role you're going into | After this guide, focus on |
|------------------------|-----------------------------|
| **Backend services** | concurrency (Williams' book), gRPC C++, prometheus-cpp, structured logging |
| **Game dev** | DOD (data-oriented design), entt or flecs ECS, GLM math, shader programming |
| **HFT / Finance** | lock-free algorithms, branch-free coding, cache-aware data layouts, perf counters |
| **Embedded** | MISRA C++, freestanding C++, real-time scheduling, hardware abstraction patterns |
| **Compiler / tools** | LLVM internals, type systems, AST design, fuzzing |
| **Robotics** | ROS 2 (C++ side), Eigen for math, real-time considerations, hardware drivers |
| **ML systems** | CUDA / SYCL, PyTorch C++ extensions, TensorRT, MLIR if compiler-adjacent |
| **Browser / OS** | sandboxing, fuzzing, exploit mitigation, low-level OS APIs |

### Final advice from senior engineers

- **Read code more than you write code.** Pick a high-quality C++ project (LLVM, Chromium, MongoDB, SQLite C++ bindings, fmt) and read until you stop being intimidated by their patterns.
- **Profile, don't guess.** Every C++ performance debate dies in front of a benchmark. Tracy, perf, VTune.
- **Memory matters more than algorithms** at modern scale. Cache-friendly O(n²) often beats cache-hostile O(n log n).
- **Use the type system.** If a function takes an `int` that should be a `UserId`, make `UserId` a class. The compiler is your colleague.
- **`std::` is enough.** Don't roll your own vector / string / sort because you think yours will be faster. It won't.
- **Compile-time errors are gifts.** Embrace `constexpr`, `static_assert`, concepts. Catch bugs before users see them.
- **Practice deletion.** Removing code is as important as adding it. C++ codebases that grow without pruning become unmaintainable.

