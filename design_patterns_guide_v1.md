# Design Patterns in Modern C++ — Comprehensive Study Guide (Playlist Edition)

> **Source:** Mike Shah's *Software Design Patterns in C++* YouTube playlist — 24 episodes across 11 patterns
> [`https://www.youtube.com/playlist?list=PLvv0ScY6vfd9wBflF0f6ynlDQuaeKYzyc`](https://www.youtube.com/playlist?list=PLvv0ScY6vfd9wBflF0f6ynlDQuaeKYzyc)
> **References:** *Design Patterns* (Gamma, Helm, Johnson, Vlissides — the Gang of Four), *Game Programming Patterns* (Robert Nystrom, [free online](https://gameprogrammingpatterns.com)), *Modern C++ Design* (Andrei Alexandrescu), *API Design for C++* (Martin Reddy), cppreference.com.
> **Coverage:** Modern C++ (C++17 / C++20 / C++23) implementations of classical GoF patterns and a few that the GoF didn't formalize (Component, Extensible Factory).

## How this guide is organized

The playlist is the spine. Every section is annotated with the episode(s) it draws from — e.g. **(Ep. Strategy-1)**, **(Eps. Observer 1–5)**. If you watch in order, you can read the corresponding section as a written companion; if you read in order, you can spot-check any topic against the matching video.

Mike's running thread through this playlist is a **gaming worldview**: Orcs and goblins for Visitor, Mario and AI characters for Component, Hell Divers 2 aliens for Prototype, a Lord of the Rings RTS for Flyweight, Angry Birds for Observer. The examples are not games-only — they map cleanly to compilers, GUIs, web services, embedded firmware — but the imagery is consistent. This guide preserves that imagery so you can pair each section with the right video.

The guide is **synthesized**, not transcribed. Code examples follow cppreference conventions and have been written to compile cleanly under `g++ -std=c++23 -Wall -Wextra`. Where Mike used raw pointers for teaching brevity, I show both the raw-pointer "first cut" and the smart-pointer modern version, because in production code you almost always want the latter.

**A note on the GoF book:** When Mike says "the gang of four book" he means *Design Patterns: Elements of Reusable Object-Oriented Software* (1994). It defines three families — **Creational**, **Behavioral**, **Structural** — and is still the standard reference. We follow the same taxonomy, with two patterns added that the GoF doesn't cover: **Component** (popularized by *Game Programming Patterns*) and the **Extensible Factory** (from Alexandrescu's *Modern C++ Design*).

---

## Table of Contents

**Part I — Foundations** *(Cross-cutting)*
1. [What is a Design Pattern?](#1-what-is-a-design-pattern)
2. [The Three Families: Creational, Behavioral, Structural](#2-the-three-families)
3. [Programming Paradigms and Where Patterns Live](#3-programming-paradigms-and-where-patterns-live)
4. [The Toolkit: Inheritance, Composition, `std::variant`, and Friends](#4-the-toolkit)
5. [Reading the UML in This Guide](#5-reading-the-uml-in-this-guide)
6. [Trade-off Vocabulary: Flexibility, Maintainability, Extensibility](#6-trade-off-vocabulary)

**Part II — Creational Patterns** *(Eps. Singleton, Factory, Extensible Factory, Prototype)*
7. [Singleton — One and Only One](#7-singleton)
8. [Singleton — Threading, Testing, and the Case Against](#8-singleton-pitfalls)
9. [Factory Method — Don't Call `new` Directly](#9-factory-method)
10. [Factory With Bookkeeping — Counting Allocations](#10-factory-with-bookkeeping)
11. [The Extensible Factory — Register Types at Runtime](#11-extensible-factory)
12. [Prototype — Clone Instead of Re-create](#12-prototype)

**Part III — Behavioral Patterns** *(Eps. Strategy, Command, Iterator, Observer, Visitor)*
13. [Strategy — Swap the Algorithm at Runtime](#13-strategy)
14. [Strategy — C++ Implementation with Dependency Injection](#14-strategy-implementation)
15. [Command — Encapsulating Actions as Objects](#15-command)
16. [Command — Undo / Redo with a History Stack](#16-command-undo-redo)
17. [Iterator — A Uniform Way to Traverse](#17-iterator)
18. [Iterator — STL Iterator Categories and Range-`for`](#18-iterator-stl)
19. [Observer — Naive First Implementation](#19-observer-naive)
20. [Observer — Abstracting Subject and Observer Interfaces](#20-observer-abstraction)
21. [Observer — RAII Registration and Lifetime Management](#21-observer-raii)
22. [Observer — Channels, Buckets, and Selective Notification](#22-observer-channels)
23. [Observer — Real-World Notes and Performance](#23-observer-wrap-up)
24. [Visitor — The Pattern and Why It's Hard](#24-visitor)
25. [Visitor — OO Hierarchies and Where the Pain Starts](#25-visitor-oo)
26. [Visitor — Implementing Double Dispatch in C++](#26-visitor-coding)
27. [Visitor — The `std::variant` + `std::visit` Alternative](#27-visitor-variant)

**Part IV — Structural Patterns** *(Eps. Flyweight, Component)*
28. [Flyweight — Sharing the Heavy Bits](#28-flyweight)
29. [Flyweight — Factory and Handle Systems](#29-flyweight-factory)
30. [Component — Identifying Components](#30-component-identifying)
31. [Component — The Pattern: Composition Over Inheritance](#31-component-pattern)
32. [Component — Implementation in C++](#32-component-implementation)
33. [Component — Data-Oriented Design and ECS](#33-component-ecs)

**Part V — Closing**
34. [Cross-Pattern Cheat Sheet: Pick the Right Pattern](#34-cross-pattern-cheat-sheet)
35. [Modern C++ Features That Replace Patterns](#35-modern-cpp-replaces-patterns)
36. [Code Review Red Flags and Idioms](#36-code-review-red-flags)
37. [Resources & Further Reading](#37-resources)
38. [A 60-Day Study Plan](#38-study-plan)

---

# Part I — Foundations

## 1. What is a Design Pattern?

A **design pattern** is a reusable, named solution to a recurring problem in a particular context. The phrase comes from Christopher Alexander's architecture work in the 1970s; software borrowed it in the 1990s with the *Design Patterns* book by the Gang of Four (GoF). A pattern is **not** a finished library you drop in — it's a description that you implement, freshly each time, for the language and problem at hand.

Three things every pattern definition includes:

1. **A name.** "Singleton" or "Observer" lets you communicate with other engineers in one word what would otherwise take a paragraph.
2. **A problem.** The context the pattern is meant for. Patterns that are right for one problem are wrong for another.
3. **A solution.** A skeleton — usually class roles, method names, and relationships — that you adapt to the specifics.

Patterns are tools, not gospel. The right question on a code review is never "is this the Singleton pattern?" but "is Singleton the right shape for *this* problem, and does the implementation pay the right price?"

> **🎯 Mental Model — Pattern ≠ Algorithm:**
> An algorithm tells you how to *compute* something (sort, search, hash). A pattern tells you how to *organize* code so the computations are composable, maintainable, and testable. Algorithms have correctness proofs; patterns have trade-offs.

> **🏭 Industry Note — When to bring up a pattern name in a meeting:**
> If two engineers are explaining the same code to each other for the third time and they can't agree on what it does, name-dropping the pattern ("this is Visitor — the double-dispatch is intentional") can short-circuit a 30-minute conversation. If everyone in the room knows it on sight, you don't need the name; just write good code.

## 2. The Three Families

The GoF taxonomy. Every pattern in this guide fits in one of them, with the exception of **Component** (a structural pattern that the GoF didn't formalize but which dominates game engines):

| Family | Concerned with | Patterns in this guide |
|---|---|---|
| **Creational** | How objects are instantiated; hiding `new` from callers | Singleton, Factory Method, Extensible Factory, Prototype |
| **Behavioral** | How objects communicate and assign responsibility | Strategy, Command, Iterator, Observer, Visitor |
| **Structural** | How objects are composed into larger structures | Flyweight, Component |

Two cross-cutting observations Mike returns to:

- **The boundary between families is fuzzy.** Factory often uses Singleton (you have one factory, not many). Observer often uses Strategy (the notification action is pluggable). Component is fundamentally Structural but enables behavioral flexibility you can't otherwise get.
- **Family tells you *where the pattern lives in your code*, not what it does.** Creational patterns live near constructors; behavioral patterns live in your main loop; structural patterns live in your class layout and headers.

## 3. Programming Paradigms and Where Patterns Live
*(Ep. Visitor-1)*

Mike opens the Visitor series with a paradigm tour, and it's worth keeping in your head as you read this guide. C++ is **multi-paradigm**: you can program procedurally, object-oriented, functionally, generically, or any blend. The pattern you'd pick to solve a problem depends on which paradigm you're working in.

| Paradigm | Where data lives | Where behavior lives | Typical tool |
|---|---|---|---|
| **Procedural** | `struct`s, `union`s, file-scope globals | Free functions | C-style; pass data into functions |
| **Object-Oriented** | Member variables on a class | Member functions on the same class | Inheritance + virtual dispatch |
| **Functional** | Plain values; no mutation | Free functions, lambdas, higher-order functions | `std::function`, ranges, `std::transform` |
| **Generic** | Template parameters | Function/class templates | `<concepts>`, SFINAE, CRTP |

When you read "the GoF book is heavily object-oriented" — that's true. Many GoF patterns assume you'll use inheritance for everything. Modern C++ has alternatives:

- **Strategy** can be inheritance + virtual `execute()`, **or** `std::function<void()>` injected at runtime, **or** a template parameter at compile time.
- **Visitor** can be the classic double-dispatch dance, **or** `std::variant` + `std::visit`.
- **Observer** can be virtual `onNotify()`, **or** a list of `std::function` callbacks, **or** a signals library like Boost.Signals2.

This guide shows the classical OO implementation first (because it's what the GoF book and most tutorials use), then shows the modern functional/generic alternative when one exists. Pick whichever fits your codebase.

## 4. The Toolkit

The C++ features you'll reach for in this guide:

| Feature | Patterns where it matters |
|---|---|
| **Virtual functions / pure virtual** | All inheritance-based patterns: Strategy, Command, Observer, Visitor, Factory, Component |
| **`override` / `final`** | Anywhere you implement a virtual function — catches signature mismatches |
| **`std::unique_ptr` / `std::shared_ptr`** | Factories return them; ownership transfer in Strategy injection |
| **`std::variant` / `std::visit`** | Modern Visitor; type-safe alternative to inheritance hierarchies |
| **`std::function` / lambdas** | Strategy-as-function; Observer-as-callback; Command-as-callable |
| **`static` member + Meyers Singleton** | Singleton implementation |
| **`std::map` / `std::unordered_map`** | Component lookup, Observer buckets, Flyweight factory cache |
| **Forward declarations + pimpl** | Breaks cyclic dependencies between Subject and Observer headers |
| **`= delete` for copy/move** | Singleton enforcement; non-copyable resource types |
| **RAII** | Observer auto-registration / auto-deregistration in ctor/dtor |
| **Templates** | Generic Factory; CRTP for static polymorphism in Strategy |
| **`enum class`** | Component types, Observer message kinds — type-safe alternative to plain `enum` |

If any of these are unfamiliar, the companion *Modern C++* guide covers them in depth; this guide assumes you can read them.

## 5. Reading the UML in This Guide

The classical pattern diagrams use Unified Modeling Language (UML) class diagrams. The minimum to know:

```
+------------------+        +------------------+
|   ClassName      |        |   <<interface>>  |
+------------------+        |  IInterface      |
| -privateField    |        +------------------+
| +publicField     |        | +virtual op()=0  |
+------------------+        +------------------+
| +method()        |
+------------------+

  A ───▷ B    "A inherits from B" (open triangle points to base)
  A ──◇ B    "A has-a B by composition"  (filled diamond = ownership)
  A ──◆ B    "A has-a B by aggregation"  (hollow diamond = reference)
  A ───▶ B    "A uses B" (open arrow)
```

I keep diagrams ASCII in this guide so they survive copy-paste. The shape and the relationships are what matter — don't memorize the notation, just learn to read it.

## 6. Trade-off Vocabulary

Mike scores every pattern against three axes in the videos. We'll do the same.

| Axis | Question it answers |
|---|---|
| **Flexibility** | Can I change behavior without rewriting structure? |
| **Maintainability** | Can someone new on the team understand and modify this in a year? |
| **Extensibility** | Can I add a *new type* (sort algorithm, monster, observer kind) without touching old code? |

Every pattern improves at least one of these — usually at the cost of more upfront code and one extra layer of indirection. The art is knowing which axis you actually need.

> **🎯 Mental Model — The Open-Closed Principle:**
> A famous SOLID principle: code should be *open* for extension but *closed* for modification. Almost every behavioral and structural pattern in this guide is a way to honor it. Visitor lets you add new operations without modifying classes. Strategy lets you add new algorithms without modifying contexts. Component lets you add new behaviors without modifying entities. When you hear "OCP," think *patterns*.

---

# Part II — Creational Patterns

Creational patterns answer one question: **who creates instances of this class, and how?** Direct calls to `new` (or even direct stack allocation) are the default; creational patterns appear when that default is wrong for your problem — because you need exactly one instance, because the caller shouldn't pick the concrete type, because construction is expensive, or because you want to register types at runtime.

## 7. Singleton
*(Ep. Singleton)*

The **Singleton** pattern enforces that a class has **exactly one instance** and gives everyone a global point of access to it.

When it's the right shape:
- A logger that every module writes to.
- A file system or asset manager owning one cache.
- A game engine's master resource manager.
- A hardware interface where multiple instances would corrupt state.

When it's the **wrong** shape: any time you can pass an instance as a parameter instead. Globals — and Singletons are globals — make testing hard, hide dependencies, and create initialization-order surprises.

### The naïve attempt

```cpp
class Logger {
public:
    Logger()  { std::cout << "Logger created\n"; }
    ~Logger() { std::cout << "Logger destroyed\n"; }
    void log(const std::string& s) { messages_.push_back(s); }
private:
    std::vector<std::string> messages_;
};

int main() {
    Logger a, b, c;   // ❌ we have three loggers. Pattern not enforced.
}
```

To enforce single-instance, we need to **prevent the caller from constructing the type directly**. The tool: make the constructor `private` and provide a static `getInstance()`.

### The C++03-era implementation (don't ship this)

```cpp
class Logger {
public:
    static Logger* getInstance() {
        if (!s_instance_) s_instance_ = new Logger();
        return s_instance_;
    }
    void log(const std::string& s) { messages_.push_back(s); }

private:
    Logger() = default;
    ~Logger() = default;
    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;

    static Logger* s_instance_;
    std::vector<std::string> messages_;
};

Logger* Logger::s_instance_ = nullptr;   // out-of-class definition required
```

Problems:
1. **Returning a raw pointer.** A user can `delete Logger::getInstance()` and crash everything.
2. **Not thread-safe.** Two threads can both pass the `if (!s_instance_)` check and both `new` a Logger.
3. **Leaks** — `s_instance_` is never deleted.
4. **Initialization-order fiasco** — if `s_instance_`'s definition is in another TU and a global constructor uses `getInstance()` before that TU is initialized, you're in undefined territory.

### The Meyers Singleton (this is what you ship)

```cpp
class Logger {
public:
    static Logger& getInstance() {
        static Logger instance;   // constructed once, on first call
        return instance;
    }

    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;

    void log(const std::string& s) { messages_.push_back(s); }

private:
    Logger() = default;   // private; only getInstance can construct
    ~Logger() = default;

    std::vector<std::string> messages_;
};

// Usage
Logger::getInstance().log("hello");
```

Why this is the right answer:
- **Thread-safe since C++11.** The standard guarantees function-local `static` initialization is thread-safe — exactly one thread constructs the instance; others block.
- **Lazy.** The Logger isn't constructed until `getInstance()` is first called.
- **Returns by reference.** No raw pointer to `delete`. The user can't accidentally destroy the singleton.
- **Destroyed at program shutdown** along with other static objects.

> **🔬 Under the Hood — `static` inside a function:**
> A `static` local variable is constructed exactly once across all calls to the function (the first time the function is reached), lives for the rest of the program, and is destroyed in reverse order of construction at program exit. The compiler emits a one-time guard variable and a thread-safe initialization sequence (the "magic statics" feature, C++11).

> **⚠️ Pitfall — The destruction order fiasco:**
> Singletons are destroyed in *reverse order of first construction*. If Logger holds a reference to Allocator and Allocator's destructor logs, but Allocator's `getInstance()` is called *after* Logger's, then at shutdown Logger is destroyed first — and Allocator's destructor logs to a dead Logger. Workaround: explicitly call dependencies' `getInstance()` early to control ordering, or detect a dead singleton and skip the log.

### Why people hate Singletons

- **Hidden dependencies.** A function that calls `Logger::getInstance()` doesn't show in its signature that it logs. Reading the code, you have to peek into the body.
- **Hard to test.** You can't mock the Logger in a unit test because the real one is hardcoded in.
- **Bottleneck.** Single point of contention under concurrency. Even with internal locking, every thread funnels through it.
- **Global state.** All the problems globals have, with extra OOP indirection.

The compromise most senior engineers reach: use Singletons sparingly, only for genuinely-single resources (the logger, the allocator), and never as a convenience to avoid passing parameters around.

> **🏭 Industry Note — Dependency injection beats Singleton:**
> Instead of `Logger::getInstance().log(...)`, take a `Logger&` as a constructor parameter. The dependency is explicit, mocking is trivial in tests, and you can swap implementations per environment. The "DI container" pattern in Java/C# is essentially a sophisticated factory that wires constructor dependencies together — modern C++ usually just uses constructor parameters by hand.

## 8. Singleton Pitfalls
*(Ep. Singleton, continued)*

A few specific traps Mike calls out in the video that bear repeating:

### Trap 1 — Returning a pointer the user can `delete`

```cpp
Logger* p = Logger::getInstance();
delete p;                              // ❌ destroys the singleton
Logger::getInstance()->log("hi");      // ❌ use-after-free
```

Fix: return by reference (`Logger&`), or return a `const` pointer that callers can't legally delete (`Logger* const`). Reference is cleanest.

### Trap 2 — Forgetting to `=delete` copy and move

```cpp
Logger& a = Logger::getInstance();
Logger b = a;                          // ❌ copies the singleton; now two exist
```

Always `=delete` both copy and move constructors **and** assignment operators on a Singleton. Or, equivalently, make them `private` with no body.

### Trap 3 — Multi-threaded access without internal synchronization

Magic statics make *construction* thread-safe. They do **not** make the singleton's *methods* thread-safe. If two threads call `log("hi")` simultaneously, your `vector::push_back` races. Either:
- Make the methods internally synchronized (`std::mutex` member, `std::lock_guard` in each method).
- Document that the Singleton is single-threaded and only call it from one thread.

### Trap 4 — Singleton as a convenience for what should be a parameter

If you find yourself reaching for Singleton to "save passing this everywhere," stop. You're describing dependency injection, not single-instance enforcement. The fact that there are 50 callers doesn't mean there should be one global instance — it means the parameter belongs in a context object the 50 callers all share.

> **🎯 Mental Model — Singleton is about uniqueness, not access:**
> The pattern enforces that exactly one instance exists. It does *not* enforce that access is convenient. Confusing the two — "I need one logger" with "I need easy access to the logger" — is the most common Singleton anti-pattern. The first is a real constraint; the second is a code-organization problem fixed by parameters, namespaces, or a thin facade.

## 9. Factory Method
*(Ep. Factory Method)*

The **Factory Method** pattern provides a generalized function (or method) that creates objects, so callers don't have to pick the concrete type directly. The factory hides which subclass of a base type gets returned.

When to use it:
- You have an inheritance hierarchy and the choice of concrete type depends on runtime data (config file, network message, user input).
- You want to centralize construction logic — initial state, IDs, registration with managers — in one place.
- You want to make construction switchable for testing.

### Setup: the type hierarchy

```cpp
class IGameObject {
public:
    virtual ~IGameObject() = default;
    virtual void update() = 0;
    virtual void render() = 0;
};

class Plane : public IGameObject {
public:
    void update() override { /* ... */ }
    void render() override { /* ... */ }
};

class Boat : public IGameObject {
public:
    void update() override { /* ... */ }
    void render() override { /* ... */ }
};
```

### First cut: a free function with a string parameter

```cpp
IGameObject* makeGameObject(const std::string& type) {
    if (type == "plane") return new Plane();
    if (type == "boat")  return new Boat();
    return nullptr;
}
```

Two problems immediately:
1. **String parameters are a type-safety hole.** `makeGameObject("Plane")` silently returns `nullptr` — a typo at the call site becomes a null-pointer crash later.
2. **Raw pointer ownership is unclear.** Who calls `delete`? The factory? The caller? The container holding the result?

### Better: `enum class` + smart pointer

```cpp
#include <memory>
#include <stdexcept>

enum class ObjectType { Plane, Boat };

std::shared_ptr<IGameObject> makeGameObject(ObjectType type) {
    switch (type) {
        case ObjectType::Plane: return std::make_shared<Plane>();
        case ObjectType::Boat:  return std::make_shared<Boat>();
    }
    throw std::logic_error("unhandled ObjectType in makeGameObject");
}

// Usage
auto obj = makeGameObject(ObjectType::Plane);
```

This is the canonical modern C++ Factory Method:
- **`enum class`** for the type tag — typos become compile errors, and the enumeration is its own scope (you can't accidentally compare an `ObjectType` to a `WeaponType`).
- **`std::shared_ptr`** or `std::unique_ptr` — ownership is explicit and automatic.
- **`throw` on unknown type** — better than `nullptr` silently propagating; you fail loudly at the point of error.

### Choosing between `unique_ptr` and `shared_ptr`

| Return type | When to use it |
|---|---|
| `std::unique_ptr<IGameObject>` | The caller owns the object outright; no sharing. Default choice. |
| `std::shared_ptr<IGameObject>` | The object will be referenced from multiple owners (game collection, render queue, AI's "target" pointer). |
| Raw pointer | Almost never. Only if you have a strict reason and document the ownership contract. |

> **🎯 Mental Model — Factory as the only place that knows concrete types:**
> Imagine your application has 200 files. Only one — the factory's `.cpp` — should `#include "Plane.h"` and `#include "Boat.h"`. Every other file deals exclusively with `IGameObject`. That separation is what makes adding a `Helicopter` class a localized change.

### Pros and Cons

| Pros | Cons |
|---|---|
| Single responsibility — one place handles construction | Two updates required: add the class **and** add the factory case |
| Easy to swap implementations for testing | Adding types requires modifying the factory (we'll fix this with Extensible Factory in §11) |
| Hides concrete types from callers | Adds one function call layer of indirection |
| Centralizes validation, ID assignment, registration | Easy to abuse — every constructor doesn't need a factory |

> **🏭 Industry Note — Naming conventions for factories:**
> Mike's tip: prefix factory function names with `make` (`makeGameObject`, `makeWidget`) so you can grep for them. The standard library follows this: `std::make_unique`, `std::make_shared`, `std::make_pair`. Once a codebase has `make_*` conventions, finding "where do these get created?" is a one-line search.

## 10. Factory With Bookkeeping
*(Ep. Factory Method — adding power to count objects)*

A factory is a natural place to add **cross-cutting concerns** — things that should happen on every construction but don't belong in any individual class's constructor.

The classic example: **count how many of each type you've allocated.** Useful for resource budgeting, leak detection in tests, gameplay-driven decisions ("only 50 planes per level").

### Wrapping the factory in a class with `static` counters

```cpp
class GameObjectFactory {
public:
    static std::shared_ptr<IGameObject> create(ObjectType type) {
        switch (type) {
            case ObjectType::Plane: ++s_planes_; return std::make_shared<Plane>();
            case ObjectType::Boat:  ++s_boats_; return std::make_shared<Boat>();
        }
        throw std::logic_error("unhandled ObjectType");
    }

    static void printCounts() {
        std::cout << "planes: " << s_planes_ << ", boats: " << s_boats_ << '\n';
    }

    GameObjectFactory(const GameObjectFactory&)            = delete;
    GameObjectFactory& operator=(const GameObjectFactory&) = delete;

private:
    GameObjectFactory()  = default;
    ~GameObjectFactory() = default;

    static inline int s_planes_ = 0;   // C++17 inline static — no .cpp definition needed
    static inline int s_boats_  = 0;
};

// Usage
auto p = GameObjectFactory::create(ObjectType::Plane);
auto b = GameObjectFactory::create(ObjectType::Boat);
GameObjectFactory::printCounts();   // planes: 1, boats: 1
```

A few details worth pointing out:

- **`static inline` member initialization (C++17)** is much cleaner than the old "declare in `.hpp`, define in `.cpp`" two-step.
- **Private constructor + deleted copy** makes this effectively a singleton — there's no instance, just static members. You could also model this as a real Meyers Singleton with non-static state.
- **`create()` is `static`**, so you call it on the class, not an instance.

### Tracking *live* objects, not just total allocations

The counter above is monotonic — it never decreases. To track currently-alive objects you have two options:

**Option A — increment in constructor, decrement in destructor.** Bake the bookkeeping into the objects themselves:

```cpp
class Plane : public IGameObject {
public:
    Plane()  { ++s_alive_; }
    ~Plane() { --s_alive_; }
    static int alive() { return s_alive_; }
private:
    static inline int s_alive_ = 0;
};
```

This is **CRTP-ready** — if you have many object types, you can factor this into a template base:

```cpp
template <typename Derived>
class Counted {
public:
    Counted()  { ++s_alive_; }
    ~Counted() { --s_alive_; }
    static int alive() { return s_alive_; }
private:
    static inline int s_alive_ = 0;   // one counter per Derived type
};

class Plane : public IGameObject, public Counted<Plane> { /* ... */ };
```

**Option B — keep `std::weak_ptr`s in the factory.** Whenever you create, store a weak reference; periodically sweep, drop expired ones, and count what's left. This avoids touching the object types, at the cost of one allocation per create and a sweep pass.

> **🎯 Mental Model — Factory as cross-cutting concern hub:**
> The right things to put in a factory: counting, logging, ID assignment, pool reuse, registration with a manager. The wrong things: type-specific construction details (those belong in the type's constructor) or business logic (that belongs elsewhere). Ask "does *every* type need this?" — if yes, factory. If no, individual constructors.

## 11. Extensible Factory
*(Ep. Extensible Factory)*

The plain Factory Method has one structural weakness: **adding a new derived type requires editing the factory function.** That's fine for a closed set of types in your own codebase, but it breaks down when:
- You're shipping a library and users want to add their own types.
- Types are loaded from plugins at runtime.
- You're reading objects from a config file and don't want to ship a new build every time a new type is added.

The **Extensible Factory** (also called the **Registered Factory** or **Self-Registering Factory**) solves this. It comes from Andrei Alexandrescu's *Modern C++ Design* and Martin Reddy's *API Design for C++*.

The idea: instead of hardcoding the cases, the factory holds a **map from type-key to creator function**. New types register their creator with the factory at runtime, and `create()` looks up the key and calls the creator.

### The factory class

```cpp
#include <functional>
#include <map>
#include <memory>
#include <string>

class GameObjectFactory {
public:
    using Creator = std::function<std::shared_ptr<IGameObject>()>;

    static void registerType(const std::string& key, Creator creator) {
        registry_()[key] = std::move(creator);
    }

    static void unregisterType(const std::string& key) {
        registry_().erase(key);
    }

    static std::shared_ptr<IGameObject> create(const std::string& key) {
        auto it = registry_().find(key);
        if (it == registry_().end()) return nullptr;   // or throw
        return it->second();
    }

private:
    static std::map<std::string, Creator>& registry_() {
        static std::map<std::string, Creator> r;
        return r;
    }
};
```

A few design notes:
- **`std::function<...()>`** is more flexible than a raw function pointer — it accepts lambdas, functor objects, and bound member functions.
- **The `registry_()` accessor** is a Meyers Singleton pattern applied to the map itself. Avoids the initialization-order fiasco.
- **Key is `std::string`** for flexibility (config files, network messages); could be `enum class` or `std::type_index` if you have a fixed set.

### Registering types

The cleanest pattern is each type providing its own static `create()`:

```cpp
class Plane : public IGameObject {
public:
    static std::shared_ptr<IGameObject> create() {
        return std::make_shared<Plane>();
    }
    // ... overrides ...
};

class Ant : public IGameObject {          // user-added type, not in original library
public:
    static std::shared_ptr<IGameObject> create() {
        return std::make_shared<Ant>();
    }
    // ... overrides ...
};

// At program startup (or plugin load):
GameObjectFactory::registerType("plane", &Plane::create);
GameObjectFactory::registerType("ant",   &Ant::create);
```

### Self-registration via a static initializer

The trick that makes this *really* clean: each type can register itself in a static initializer, so just including the header is enough.

```cpp
namespace {
    struct AntRegistrar {
        AntRegistrar() {
            GameObjectFactory::registerType("ant", &Ant::create);
        }
    };
    static AntRegistrar s_antRegistrar;   // constructed at startup, before main
}
```

Now adding `Ant` to the program is one new `.cpp` file — no factory edits.

### Usage from a config file

```cpp
std::ifstream level("level1.txt");
std::string line;
while (std::getline(level, line)) {
    auto obj = GameObjectFactory::create(line);
    if (obj) gameObjects.push_back(obj);
}
```

Now `level1.txt` can say:
```
plane
plane
boat
boat
ant
```
and the program spawns the right mix — even types added by plugins, with no recompile.

> **🎯 Mental Model — Extensible Factory = runtime polymorphism over construction:**
> The plain Factory has compile-time polymorphism over construction (the `switch` is fixed at compile). The Extensible Factory has runtime polymorphism: you can add a type at runtime and the factory will create it. The cost is a hash/tree lookup per construction, which is negligible compared to whatever the object actually does.

### Pros and Cons

| Pros | Cons |
|---|---|
| Adding a type doesn't modify factory code | Loses some compile-time type safety (key is a string) |
| Supports plugin systems, scripting, config-driven object creation | Self-registration relies on static initializers — fragile ordering |
| No recompile to ship a new type (with plugins) | Map lookup per `create()` (small but nonzero) |
| Decouples factory from concrete types completely | One more level of indirection than a switch |

> **⚠️ Pitfall — Static initialization order:**
> If the factory's `registry_()` map and the registrar's static struct are in different translation units, you might construct the registrar before the registrar can find the map. The Meyers-Singleton accessor (`static map& registry_()`) sidesteps this — the map is constructed on first call, not at static init time. Always use that pattern, never a file-scope map variable.

## 12. Prototype
*(Ep. Prototype)*

The **Prototype** pattern creates new objects by **cloning an existing instance** rather than constructing from scratch. Useful when:
- Construction is expensive (downloading config from a server, parsing a large file, querying a database).
- You have a fully-configured "template" object and want N variations of it.
- You don't want to expose a complex constructor signature.

Mike's motivating example: an online game like *Helldivers 2* with hundreds of enemies on screen. The alien's mesh, AI behavior tree, animation set, and base stats are identical for every instance — only position, health, and a few attributes differ. Loading all of that from disk *every time* an alien spawns is wasteful. Load it once into a "prototype" alien, then clone.

### The pattern

```cpp
#include <memory>
#include <string>
#include <vector>

class Alien {
public:
    Alien(int id, std::string name)
      : id_(id), name_(std::move(name)) {}

    // Copy constructor — deep copies all the heavy data
    Alien(const Alien& other)
      : id_(-1),                       // new clone gets a placeholder ID
        name_(other.name_ + "_clone"),
        data_(other.data_) {}

    // The clone "interface" method
    virtual std::unique_ptr<Alien> clone() const {
        return std::make_unique<Alien>(*this);
    }

    void setupAlienData() {
        // Simulated expensive operation — in reality: download, parse, allocate
        for (int i = 0; i < 100; ++i) data_.push_back(i);
    }

    void setId(int id)                  { id_ = id; }
    std::vector<int>& data()            { return data_; }

private:
    int id_;
    std::string name_;
    std::vector<int> data_;
};

// Usage
auto prototype = std::make_unique<Alien>(0, "default");
prototype->setupAlienData();            // pay the cost once

for (int i = 0; i < 100; ++i) {
    auto spawned = prototype->clone();   // cheap — copy of in-memory data
    spawned->setId(i);
    // ... place at random position, register with world ...
}
```

### Why not just call the copy constructor directly?

Two reasons Mike emphasizes:

1. **Polymorphism.** If you have `Alien*` and want a copy without knowing the concrete type, `*alien` won't compile (slicing) and `*static_cast<Derived*>(alien)` requires the caller to know the type. `alien->clone()` returns the right type via virtual dispatch.
2. **Explicit intent.** `clone()` is grep-able; `copy = original` is not. In a codebase using the Prototype pattern, you can find every clone site with one search.

You can also parameterize `clone()` — pass a new ID, position, or other variations — so each clone isn't *quite* identical.

### Combining with inheritance

```cpp
class Alien {
public:
    virtual ~Alien() = default;
    virtual std::unique_ptr<Alien> clone() const = 0;
};

class GruntAlien : public Alien {
public:
    std::unique_ptr<Alien> clone() const override {
        return std::make_unique<GruntAlien>(*this);
    }
    // ...
};

class EliteAlien : public Alien {
public:
    std::unique_ptr<Alien> clone() const override {
        return std::make_unique<EliteAlien>(*this);
    }
    // ...
};

// A list of prototypes the spawner picks from
std::vector<std::unique_ptr<Alien>> prototypes;
prototypes.push_back(std::make_unique<GruntAlien>());
prototypes.push_back(std::make_unique<EliteAlien>());

auto& proto = prototypes[rng() % prototypes.size()];
auto spawned = proto->clone();   // virtual dispatch picks the right clone
```

> **🎯 Mental Model — Clone is a virtual copy constructor:**
> C++ doesn't have virtual constructors (you have to know the type to construct it). `clone()` is the language idiom for getting one — a virtual method that returns a copy of the dynamic type. Almost every C++ class hierarchy that supports copying needs a `clone()` method.

### Pros and Cons

| Pros | Cons |
|---|---|
| Pays expensive setup cost once | Requires correct deep-copy implementation (copy constructor must really deep-copy) |
| Virtual dispatch — `clone()` works through base pointers | Each subclass must override `clone()` — boilerplate |
| Clear, grep-able intent | If your objects share state via raw pointers, cloning duplicates pointers, not pointees |
| Easy to vary clones (parameterize `clone()`) | Doesn't fit immutable types that don't need mutation per instance |

> **🏭 Industry Note — Prototype vs Flyweight:**
> Prototype gives you N *independent* copies of a heavy object. Flyweight (§28) gives you N *references* to one shared heavy object. They sound similar — both deal with "many instances of nearly identical objects" — but the choice is whether each instance needs its own state. If the heavy state never changes per instance, Flyweight is cheaper. If each instance mutates its own copy, Prototype.

---

# Part III — Behavioral Patterns

Behavioral patterns are about **how objects collaborate**: who talks to whom, who owns the algorithm, how a request flows through the system. They tend to be the patterns people argue about most — because "good behavior" is more subjective than "good structure."

## 13. Strategy
*(Ep. Strategy-1)*

The **Strategy** pattern (also called the **Policy** pattern) lets you **select an algorithm at runtime** from a family of related algorithms, instead of hardcoding the choice with `if`/`switch`.

The smell that signals you might want Strategy:

```cpp
void sort(std::vector<int>& data) {
    if (data.size() < 16) {
        // ... insertion sort inline ...
    } else if (data.size() < 1024) {
        // ... quicksort inline ...
    } else {
        // ... mergesort inline ...
    }
}
```

Three sorts inlined into one function. As behaviors diverge — different memory budgets, different worst-case requirements, debug-mode logging variants — the function balloons. The conditions and the algorithms are *coupled* when they should be separable.

### The intuition

Mike's framing: when you see a chain of `if`/`else if`/`switch` where each branch is a different *implementation* of the *same conceptual operation*, that's where Strategy lives. The conditional is the **policy decision**; the branches are **interchangeable algorithms**.

Real-world examples:
- Sort algorithms in `std::sort` itself (introsort picks insertion vs quicksort by size).
- Compression algorithms (gzip vs zstd vs lz4).
- AI difficulty levels (each is a different decision policy).
- Image processing kernels (each filter is a strategy).
- Rendering: deferred vs forward vs ray-traced.
- Logging: stdout vs file vs network.

### The classic OO setup

```cpp
class ICombatStrategy {
public:
    virtual ~ICombatStrategy() = default;
    virtual void execute() = 0;
};

class NoCombat : public ICombatStrategy {
public:
    void execute() override { std::cout << "Runs away in fear\n"; }
};

class MeleeCombat : public ICombatStrategy {
public:
    void execute() override { std::cout << "Swings sword\n"; }
};

class RangedCombat : public ICombatStrategy {
public:
    void execute() override { std::cout << "Fires arrow\n"; }
};
```

The **context** (the object that uses the strategy) holds one:

```cpp
class Orc {
public:
    Orc() : strategy_(std::make_unique<NoCombat>()) {}

    void setCombatStrategy(std::unique_ptr<ICombatStrategy> s) {
        strategy_ = std::move(s);
    }

    void doActions() {
        strategy_->execute();
    }

private:
    std::unique_ptr<ICombatStrategy> strategy_;
};
```

Notice what's gone: there's no `if (combatMode == melee)` anywhere. The Orc just delegates to whichever strategy it currently holds. Swapping behavior is a one-line setter call.

```cpp
Orc grom;
grom.doActions();                                            // Runs away in fear
grom.setCombatStrategy(std::make_unique<MeleeCombat>());
grom.doActions();                                            // Swings sword
```

> **🎯 Mental Model — Strategy is a function pointer with extra structure:**
> At its core, Strategy is "pass the algorithm in." In C, you'd pass a function pointer. In C++ with OO, you pass an object whose virtual method *is* the algorithm. In modern C++ with lambdas, you pass a `std::function<void()>`. All three are valid Strategy implementations — pick whichever matches your codebase's style.

## 14. Strategy — Implementation Details
*(Ep. Strategy-2)*

A few implementation choices worth thinking about explicitly.

### Injection style: constructor vs setter

```cpp
// Constructor injection — strategy is set at creation, can be set once
class Orc {
public:
    explicit Orc(std::unique_ptr<ICombatStrategy> s) : strategy_(std::move(s)) {}
private:
    std::unique_ptr<ICombatStrategy> strategy_;
};

// Setter injection — strategy can change over the object's lifetime
class Orc {
public:
    Orc() : strategy_(std::make_unique<NoCombat>()) {}
    void setStrategy(std::unique_ptr<ICombatStrategy> s) { strategy_ = std::move(s); }
private:
    std::unique_ptr<ICombatStrategy> strategy_;
};
```

Choose constructor injection when the strategy is **part of the object's identity** (a sort container that's always quicksort). Choose setter injection when **behavior can change at runtime** (a game character whose combat mode shifts based on conditions).

### Ownership: `unique_ptr` vs raw

The strategy is typically owned by the context. Use `std::unique_ptr<ICombatStrategy>` if the context owns it outright (the common case). Use a raw pointer or `std::shared_ptr` if the strategy is shared across contexts (e.g., one MeleeCombat instance used by all Orcs because the strategy is stateless).

For stateless strategies, **a single shared instance** can be more efficient than per-context unique pointers — but only if you're sure the strategy holds no state.

### Compile-time Strategy: templates

If the strategy is known at compile time, you can erase the virtual call entirely by templating the context:

```cpp
template <typename Strategy>
class Orc {
public:
    void doActions() { strategy_.execute(); }   // no virtual call; inlinable
private:
    Strategy strategy_;
};

// Usage
Orc<MeleeCombat> meleeOrc;     // strategy baked in at compile time
Orc<RangedCombat> rangedOrc;
```

This is **Policy-Based Design** — Alexandrescu's variation. You lose runtime flexibility (you can't swap strategies after construction) but you gain inlining and lose the virtual call overhead. Use it for hot paths where you know the strategy choice at compile time.

### `std::function` as strategy

If the strategy is *just a function call*, you don't need an interface and a class hierarchy:

```cpp
class Orc {
public:
    void setStrategy(std::function<void()> s) { strategy_ = std::move(s); }
    void doActions() { if (strategy_) strategy_(); }
private:
    std::function<void()> strategy_;
};

Orc grom;
grom.setStrategy([]{ std::cout << "Custom melee\n"; });
grom.doActions();
```

This is the most flexible form — any callable works, lambdas with captures included. The cost is `std::function`'s small-buffer optimization plus virtual call indirection. For most cases it's free; for hot loops, measure.

### Pros and Cons

| Pros | Cons |
|---|---|
| Eliminates long `if`/`switch` chains | Adds a virtual call (runtime) or template instantiation (compile time) |
| Each strategy is independently testable | One class per strategy — boilerplate for simple cases |
| Easy to add new strategies (open-closed) | Type erasure (`std::function`) adds small heap allocation |
| Composes with Decorator, Service Locator, etc. | The context must expose enough state for strategies to work |

> **⚠️ Pitfall — Strategies that need context state:**
> If `MeleeCombat::execute()` needs the Orc's position, health, and weapons, you have to pass them in. Either: (a) `execute(Orc& self)` — strategies see the whole Orc, OK for tight coupling; (b) `execute(const PositionAndWeapons& ctx)` — pass only what's needed, more decoupled; or (c) Component pattern (§30) — strategies become components themselves. Choose (b) for clean code, (c) for game engines.

## 15. Command
*(Ep. Command, first half)*

The **Command** pattern (also: Action, Transaction) wraps a request as an object. The object knows how to perform the action (`execute()`) and often how to reverse it (`undo()`). Commands can be stored, queued, logged, replayed.

When to reach for Command:
- **Undo/redo** systems (word processors, image editors, IDEs).
- **Input binding** — different controllers trigger the same command.
- **Queueing requests** — execute commands on the simulation tick, not when the input happens.
- **Macro recording** — record a series of commands, replay them.
- **Network transmission** — serialize a command, send it to a server, execute remotely.

### The basic interface

```cpp
class Command {
public:
    virtual ~Command() = default;
    virtual void execute() = 0;
    virtual void undo()    = 0;
};

struct Character {
    std::string name;
    int x = 0, y = 0;
    void move(int dx, int dy) { x += dx; y += dy; }
};

class MoveCommand : public Command {
public:
    MoveCommand(Character& c, int dx, int dy)
      : character_(c), dx_(dx), dy_(dy) {}

    void execute() override { character_.move(dx_, dy_); }
    void undo()    override { character_.move(-dx_, -dy_); }

private:
    Character& character_;
    int dx_, dy_;
};
```

### Queueing and replay

```cpp
std::vector<std::unique_ptr<Command>> queue;
Character mario{"Mario"};

queue.push_back(std::make_unique<MoveCommand>(mario, 1, 0));
queue.push_back(std::make_unique<MoveCommand>(mario, 0, 1));
queue.push_back(std::make_unique<MoveCommand>(mario, -1, 0));

for (auto& cmd : queue) cmd->execute();
// mario is now at (0, 1)
```

The producer of commands and the consumer that runs them are decoupled. Inputs from a controller can be turned into commands on one thread, queued, and executed on the simulation thread — the classic single-producer-single-consumer pattern.

## 16. Command — Undo/Redo
*(Ep. Command, second half)*

Real undo/redo is two stacks: an **undo stack** holds executed commands; a **redo stack** holds commands undone but available to re-do. When the user does a new action after undoing, the redo stack is cleared.

```cpp
class CommandHistory {
public:
    void execute(std::unique_ptr<Command> cmd) {
        cmd->execute();
        undo_.push_back(std::move(cmd));
        redo_.clear();                  // new action invalidates the redo stack
    }

    void undo() {
        if (undo_.empty()) return;
        undo_.back()->undo();
        redo_.push_back(std::move(undo_.back()));
        undo_.pop_back();
    }

    void redo() {
        if (redo_.empty()) return;
        redo_.back()->execute();
        undo_.push_back(std::move(redo_.back()));
        redo_.pop_back();
    }

private:
    std::vector<std::unique_ptr<Command>> undo_;
    std::vector<std::unique_ptr<Command>> redo_;
};

// Usage
CommandHistory history;
Character mario{"Mario"};

history.execute(std::make_unique<MoveCommand>(mario, 1, 0));  // (1, 0)
history.execute(std::make_unique<MoveCommand>(mario, 0, 1));  // (1, 1)
history.undo();                                                // (1, 0)
history.undo();                                                // (0, 0)
history.redo();                                                // (1, 0)
history.execute(std::make_unique<MoveCommand>(mario, 0, -1));  // (1, -1); redo stack cleared
```

### What `undo()` actually needs to know

`undo()` is the hard part. Two strategies:

**Strategy A — record the inverse operation.** `MoveCommand(+1, 0)` undoes by applying `(-1, 0)`. Clean and small. Works for invertible operations: move, rotate, set-a-value-where-you-know-the-previous-value.

**Strategy B — snapshot the state before execute.** Store the entire pre-state; `undo()` restores it. More general — handles operations whose inverse is hard to compute (e.g., "delete a paragraph" — you need to remember the paragraph) — but uses more memory.

Most real systems blend the two: small commands record inverses; large commands snapshot.

### Composite commands

A `MacroCommand` that holds a list of sub-commands and forwards `execute()`/`undo()` to each lets you treat multi-step operations as a single undo unit:

```cpp
class MacroCommand : public Command {
public:
    void add(std::unique_ptr<Command> cmd) { children_.push_back(std::move(cmd)); }

    void execute() override {
        for (auto& c : children_) c->execute();
    }
    void undo() override {
        for (auto it = children_.rbegin(); it != children_.rend(); ++it) {
            (*it)->undo();   // undo in reverse order
        }
    }

private:
    std::vector<std::unique_ptr<Command>> children_;
};
```

This is the **Composite** pattern (GoF, not in this guide) layered on top of Command — very common in editor undo systems.

> **🎯 Mental Model — Command turns "do X" into "an X to do":**
> The verb becomes a noun. Once an action is a first-class object, you can put it in a list, send it over a network, save it to disk, replay it, undo it. All those superpowers come from the simple act of making the action a *thing*.

### Pros and Cons

| Pros | Cons |
|---|---|
| Decouples the requester from the receiver | One class per action — verbose for trivial operations |
| Enables undo/redo, queuing, logging, networking | Each command holds enough state for undo — can be heavy |
| Easy to record/replay user input | `undo()` correctness is non-trivial |
| Composable into macro commands | Object lifetimes can be tricky if commands hold references to dying objects |

> **⚠️ Pitfall — Dangling references in stored commands:**
> `MoveCommand` holds `Character& character_`. If `character_` is destroyed but the command sits in the history stack, calling `undo()` is undefined behavior. Use `std::weak_ptr` if characters can be deleted, or invalidate the command stack when an object dies, or design so command lifetimes are subsets of target lifetimes.

## 17. Iterator
*(Ep. Iterator)*

The **Iterator** pattern provides a uniform way to traverse a collection without exposing its internal structure. You ask the collection for an iterator; the iterator knows how to step from one element to the next.

The C++ STL is built around this pattern. Every container (`vector`, `list`, `map`, `unordered_set`, `forward_list`) exposes `begin()` and `end()`, and every algorithm (`std::find`, `std::sort`, `std::accumulate`) works in terms of iterators rather than specific containers.

### Why it matters

Compare these three loops:

```cpp
// 1. Raw indexed loop
for (std::size_t i = 0; i < v.size(); ++i) std::cout << v[i];

// 2. Indexed loop, stride 2
for (std::size_t i = 0; i < v.size(); i += 2) std::cout << v[i];

// 3. Range-for
for (const auto& x : v) std::cout << x;
```

Why is #2 *worse* than #3 for "print everything"? It's not slower — it's *less clear*. A reader of #2 has to think about why the stride is 2. A reader of #3 sees "for every element" — no ambiguity. Iterators (and range-`for`) **express intent**.

```cpp
std::vector<int> v = {1, 2, 3, 4, 5};

for (auto it = v.cbegin(); it != v.cend(); ++it)   // const iteration
    std::cout << *it << ' ';

for (auto it = v.rbegin(); it != v.rend(); ++it)   // reverse iteration
    std::cout << *it << ' ';
```

Each line declares — in the type — what it intends to do. `const_iterator` won't let you modify; `reverse_iterator` goes backward. The compiler enforces the contract.

## 18. Iterator — STL Categories
*(Ep. Iterator, continued)*

The C++ Standard Library defines six iterator categories, each adding capability:

| Category | Capability | Example container |
|---|---|---|
| **Input** | Read once, advance | `std::istream_iterator` |
| **Output** | Write once, advance | `std::ostream_iterator` |
| **Forward** | Read + advance multiple times | `std::forward_list` |
| **Bidirectional** | Forward + step backward | `std::list`, `std::set`, `std::map` |
| **Random access** | Bidirectional + jump O(1) | `std::vector`, `std::array`, `std::deque`, raw arrays |
| **Contiguous** *(C++20)* | Random access + memory is contiguous | `std::vector`, `std::array`, raw arrays |

Algorithms in the STL specify the *minimum* category they need. `std::find` works with forward iterators (and anything stronger); `std::sort` needs random access. The compiler will refuse to call `std::sort(list.begin(), list.end())` because `std::list` iterators are bidirectional, not random-access — and that's the type system catching a real performance bug before runtime.

### Range-`for` and `begin()` / `end()`

Range-`for` is sugar:

```cpp
for (auto x : v) { ... }

// equivalent to:
for (auto it = std::begin(v); it != std::end(v); ++it) {
    auto x = *it;
    ...
}
```

Any class with `begin()` and `end()` works in a range-`for`. This is one of the easiest extension points in C++ — write a custom container and it integrates with the language with two functions.

### Writing your own iterator (minimum viable)

```cpp
struct Range {
    int from, to;

    struct iterator {
        int v;
        int operator*() const { return v; }
        iterator& operator++() { ++v; return *this; }
        bool operator!=(const iterator& other) const { return v != other.v; }
    };

    iterator begin() const { return {from}; }
    iterator end()   const { return {to}; }
};

for (int i : Range{1, 5}) std::cout << i;   // 1234
```

The minimum is: dereference operator, pre-increment, inequality, and `begin()`/`end()` on the container. C++20 ranges (covered in the *Modern C++* guide) generalize this significantly.

> **🎯 Mental Model — Iterators are pointers, generalized:**
> A pointer into an array satisfies all the iterator requirements automatically (`*p`, `++p`, `p != q`). Iterators are what you get when you generalize "pointer-into-contiguous-memory" to any traversable structure. That's why STL algorithms can work uniformly on arrays, vectors, and linked lists — they all expose a pointer-like interface.

### Pros and Cons

| Pros | Cons |
|---|---|
| Uniform traversal across containers | Custom iterators are non-trivial to write correctly |
| Enables STL algorithms on your types | Iterator invalidation rules are subtle |
| Range-`for` works automatically | Some operations need stronger iterator categories than you have |
| Expresses intent (const, reverse) in types | Each container's iterator has its own complexity guarantees |

> **⚠️ Pitfall — Iterator invalidation:**
> `vector::push_back` may reallocate and invalidate **all** iterators into the vector. `map::erase` invalidates only the erased iterator, not others. `list::insert` invalidates none. The rules differ per container — always check cppreference for the operation you're doing. Holding an iterator across a mutating operation is the single most common cause of crashes in C++ container code.

## 19. Observer — Naive First Implementation
*(Ep. Observer-1)*

The **Observer** pattern (also: Publish-Subscribe, Listener) lets an object — the **Subject** — maintain a list of **Observers** and notify them automatically when something interesting happens. The observers don't poll; they're called when needed.

Mike opens with Angry Birds: when the bird collides, who responds? Physics, sound, animation, score, achievement, replay log — many subsystems all care, all should react. Hardcoding "play sound; update score; check achievement; ..." into the collision handler couples the bird to every subsystem it touches. Observer decouples.

When to reach for it:
- GUI: button click triggers many handlers.
- Game: events (death, level-up, item-pickup) trigger many subsystems.
- Backend: a new database write should trigger cache invalidation, audit log, metrics, ...
- Anywhere a one-to-many "this just happened" notification needs to be sent.

### The naïve first cut

Two classes, no abstraction yet — just the mechanic.

```cpp
#include <forward_list>
#include <iostream>
#include <string>

class Observer {
public:
    explicit Observer(std::string name) : name_(std::move(name)) {}
    void onNotify() { std::cout << name_ << " says hello\n"; }

private:
    std::string name_;
};

class Subject {
public:
    void addObserver(Observer* o)    { observers_.push_front(o); }
    void removeObserver(Observer* o) { observers_.remove(o); }

    void notifyAll() {
        for (auto* o : observers_) o->onNotify();
    }

private:
    std::forward_list<Observer*> observers_;
};

// Usage
Subject subject;
Observer o1("observer-1"), o2("observer-2"), o3("observer-3");

subject.addObserver(&o1);
subject.addObserver(&o2);
subject.addObserver(&o3);

subject.notifyAll();        // all three say hello

subject.removeObserver(&o3);
subject.notifyAll();        // only o1 and o2
```

Already this is useful — the subject doesn't know what the observers *do*, and observers don't know about each other. We can add a fourth subsystem (logging? metrics?) by writing one new class and calling `addObserver`.

What's missing:
- **Abstraction.** Currently `Subject` only takes one concrete `Observer` type. We want different observer kinds.
- **Lifetime safety.** If an Observer goes out of scope before being removed, the next `notifyAll()` dereferences a dangling pointer.
- **Channels.** We probably don't want *every* observer notified on *every* event.

We'll fix those in the next four sections, mirroring Mike's five-part build-up.

## 20. Observer — Abstraction
*(Ep. Observer-2)*

Step two: turn Subject and Observer into **interfaces**, so users can derive their own concrete versions. Now any "observable" subject and any "watcher" observer can compose.

```cpp
class IObserver {
public:
    virtual ~IObserver() = default;
    virtual void onNotify() = 0;
};

class ISubject {
public:
    virtual ~ISubject() = default;
    virtual void addObserver(IObserver* o)    = 0;
    virtual void removeObserver(IObserver* o) = 0;
    virtual void notifyAll()                  = 0;
};

class Subject : public ISubject {
public:
    void addObserver(IObserver* o)    override { observers_.push_front(o); }
    void removeObserver(IObserver* o) override { observers_.remove(o); }
    void notifyAll()                  override {
        for (auto* o : observers_) o->onNotify();
    }
private:
    std::forward_list<IObserver*> observers_;
};

class Watcher : public IObserver {
public:
    explicit Watcher(std::string name) : name_(std::move(name)) {}
    void onNotify() override { std::cout << "Watcher " << name_ << '\n'; }
private:
    std::string name_;
};

// Usage — same as before, but now any IObserver derivation can subscribe
Subject s;
Watcher w1("alpha"), w2("beta");
s.addObserver(&w1);
s.addObserver(&w2);
s.notifyAll();
```

The change is small but significant: now you can have **multiple observer types** (Watcher, Logger, Recorder, ...) all subscribing to the same subject, each doing its own thing on notification. The subject doesn't care — it just sees `IObserver*`s.

> **🎯 Mental Model — Interfaces are contracts; concrete types are participants:**
> `IObserver` is a contract: "I have an `onNotify()` method." `ISubject` is a contract: "I can register and notify observers." Concrete classes (Watcher, Subject) opt in to those contracts. Once you've defined the contracts, you can build any number of participants without touching the contracts — that's the open-closed principle in action.

## 21. Observer — RAII Registration
*(Ep. Observer-3)*

Step three: make observers **auto-register** with the subject in their constructor and **auto-deregister** in their destructor. This solves the lifetime bug: an observer that goes out of scope is automatically removed from its subject.

This is **RAII** (Resource Acquisition Is Initialization) applied to subscription. The "resource" is the subscription itself.

```cpp
class Watcher : public IObserver {
public:
    Watcher(ISubject& subject, std::string name)
      : subject_(subject), name_(std::move(name)) {
        subject_.addObserver(this);     // register on construction
    }

    ~Watcher() override {
        subject_.removeObserver(this);  // deregister on destruction
    }

    Watcher(const Watcher&)            = delete;
    Watcher& operator=(const Watcher&) = delete;

    void onNotify() override { std::cout << "Watcher " << name_ << '\n'; }

private:
    ISubject& subject_;
    std::string name_;
};

// Usage — observers don't need explicit add/remove anymore
Subject s;
{
    Watcher w1(s, "alpha");
    Watcher w2(s, "beta");
    s.notifyAll();              // both fire
    {
        Watcher w3(s, "gamma");
        s.notifyAll();          // all three fire
    }                           // w3 destructor removes itself
    s.notifyAll();              // only alpha and beta
}                               // w1 and w2 destructors remove themselves
s.notifyAll();                  // no one fires; no crash
```

Notice the deleted copy operations. If you allowed copies, the copy would register itself too — and the address it registered with would be wrong because copies have different addresses. Deleting copies is the right default.

> **🔬 Under the Hood — Why the subject must be passed in by reference:**
> The `Watcher` constructor stores `subject_` as `ISubject&`, not `ISubject*`. A reference can't be null and can't be rebound — once a Watcher is constructed, it observes exactly that subject for its entire lifetime. That guarantee is what makes the destructor's `removeObserver(this)` always safe. If you used a pointer, you'd need null checks.

### What if the observer outlives the subject?

We've solved "observer dies first." What about "subject dies first"? When the subject is destroyed while observers still exist, the observers' destructors will try to call `removeObserver` on a dead subject — crash.

Three ways to handle it:
1. **Document the order**: subjects must outlive observers. Common in code where ownership is clear.
2. **Subject notifies observers on its destruction**, telling them to unsubscribe themselves.
3. **`std::weak_ptr<IObserver>` in the subject's list**: subject holds weak refs, so dead observers are sweepable, but you need `shared_ptr`-owned observers.

For most code, (1) is sufficient with clear documentation.

## 22. Observer — Channels and Selective Notification
*(Ep. Observer-4)*

Step four: not every observer cares about every event. A sound subsystem doesn't care about physics updates. Split the observer list into **channels** — buckets keyed by event type.

```cpp
#include <map>

enum class MessageType { PlaySound, HandlePhysics, Log };

class ISubject {
public:
    virtual ~ISubject() = default;
    virtual void addObserver(MessageType msg, IObserver* o)    = 0;
    virtual void removeObserver(MessageType msg, IObserver* o) = 0;
    virtual void notify(MessageType msg)                       = 0;
    virtual void notifyAll()                                   = 0;
};

class Subject : public ISubject {
public:
    void addObserver(MessageType msg, IObserver* o) override {
        observers_[msg].push_front(o);
    }
    void removeObserver(MessageType msg, IObserver* o) override {
        auto it = observers_.find(msg);
        if (it != observers_.end()) it->second.remove(o);
    }
    void notify(MessageType msg) override {
        auto it = observers_.find(msg);
        if (it == observers_.end()) return;
        for (auto* o : it->second) o->onNotify();
    }
    void notifyAll() override {
        for (auto& [_, list] : observers_)
            for (auto* o : list) o->onNotify();
    }

private:
    std::map<MessageType, std::forward_list<IObserver*>> observers_;
};
```

Observers now register for a specific channel:

```cpp
class Watcher : public IObserver {
public:
    Watcher(ISubject& s, MessageType msg, std::string name)
      : subject_(s), msg_(msg), name_(std::move(name)) {
        subject_.addObserver(msg_, this);
    }
    ~Watcher() override { subject_.removeObserver(msg_, this); }

    void onNotify() override { std::cout << name_ << '\n'; }

private:
    ISubject& subject_;
    MessageType msg_;
    std::string name_;
};

// Usage
Subject s;
Watcher snd1(s, MessageType::PlaySound,    "sound-1");
Watcher snd2(s, MessageType::PlaySound,    "sound-2");
Watcher phy1(s, MessageType::HandlePhysics,"physics-1");
Watcher log1(s, MessageType::Log,          "log-1");

s.notify(MessageType::PlaySound);   // sound-1, sound-2
s.notify(MessageType::Log);         // log-1
s.notifyAll();                       // all four
```

> **🎯 Mental Model — Channels = topic-based pubsub:**
> The channelled Observer is exactly the Publish/Subscribe pattern you'd see in RabbitMQ or Kafka: publishers send to a topic, subscribers register interest in topics, and the broker routes messages. The map of `topic → subscriber list` is the broker. C++ Observer with channels is in-process pubsub.

### Passing event data

Often you don't just want to know *that* something happened — you want details. Two ways:

**A — pass an event payload to `onNotify`.** Change the interface:

```cpp
struct Event {
    MessageType type;
    int data;       // or std::variant, or a typed payload struct
};

class IObserver {
public:
    virtual void onNotify(const Event& e) = 0;
};
```

**B — observers query the subject after notification.** The subject changes state, calls `notifyAll`, observers ask `subject.lastEvent()`. Simpler interface but couples observers to the subject's API.

Modern code usually goes with (A). Typed payloads (one struct per event type, or `std::variant<EventA, EventB, EventC>`) are best.

## 23. Observer — Real-World Notes
*(Ep. Observer-5)*

Wrap-up notes from Mike's review episode.

### Where Observer lives in the wild

- **Qt's signals and slots.** Probably the most well-known C++ Observer system; uses MOC code generation.
- **Boost.Signals2.** Header-only, thread-safe Observer. The de-facto choice if you want a library.
- **Game engines.** Unreal's `Delegate` system, Godot's signals, Unity's `UnityEvent`. All Observer under the hood.
- **GUI frameworks.** Almost every event system is Observer.
- **`std::observer_ptr`** (proposed for std but didn't make it) — a non-owning pointer with Observer semantics.

### Performance considerations

- **Iteration cost.** Notifying N observers is O(N). Usually fine; if N is in the millions, reconsider.
- **Allocation.** Each subscription is typically a heap allocation (list node, weak_ptr control block). For high-throughput pubsub, fixed-size buffers or intrusive linked lists (the observer itself contains the link node) cut allocations.
- **Cache locality.** `std::forward_list<Observer*>` chases pointers — every notification is a cache miss. `std::vector<Observer*>` packs them but invalidates iterators on growth. Pick based on your iteration frequency vs. mutation rate.
- **Thread safety.** Default Observer is single-threaded. If you notify from one thread and observers can subscribe from another, you need `std::mutex` or `std::shared_mutex` around the observer list.

### Asynchronous observers

For decoupled subsystems (e.g., a `LogObserver` that writes to disk), running `onNotify` synchronously blocks the subject. Solutions:
- Post the event to a queue; a worker thread drains the queue and calls observers.
- `std::async` per notification — easy but heap-allocates per call.
- A dedicated thread pool with a lock-free queue — for high-throughput.

### Pros and Cons

| Pros | Cons |
|---|---|
| Decouples subject from subscribers — open/closed | Iteration cost grows with subscriber count |
| Multiple subsystems react to one event | Bug-prone lifetimes — dangling subscribers, dead subjects |
| Easy to plug new subscribers in | Notification order is fragile (don't depend on it unless documented) |
| Composes with Strategy, Command, etc. | Reentrancy: an observer that modifies the subscriber list during notification can crash |

> **⚠️ Pitfall — Reentrancy:**
> If `onNotify` causes the observer to unsubscribe itself or another observer, you're modifying the list while iterating it. `forward_list::remove` during iteration is undefined behavior. Two fixes: copy the list before iterating (extra alloc), or defer mutations until after notify (mark for removal, sweep after the loop).

## 24. Visitor — Introduction
*(Ep. Visitor-1)*

The **Visitor** pattern lets you **add new operations** to a stable hierarchy of types **without modifying** those types. It's the inverse of the trade-off you make with normal virtual dispatch.

To understand when Visitor pays off, you have to understand the **expression problem** (Wadler, 1998): in any language with class hierarchies, you can either easily add new *types* (inheritance — add a class, override methods) or easily add new *operations* (write a function over a fixed set of types) but not both with the same ease. Virtual dispatch optimizes the first; Visitor optimizes the second.

| If you frequently... | Use... |
|---|---|
| Add new derived types (Orc, Goblin, Troll, Dragon, ...) | Virtual functions on the base class |
| Add new operations on a fixed type set (Draw, Save, Validate, ...) | Visitor |
| Both — and changes are uncorrelated | `std::variant` + `std::visit`, or accept that one side will be painful |

Visitor is also the canonical example of **double dispatch** — the function called depends on the *dynamic types* of *two* objects (the visitor and the visited). C++ only has single dispatch built in (`virtual` is dispatch on `this`); Visitor implements the second dispatch by hand.

When to reach for it:
- Compilers: AST nodes are stable; new passes (type-check, optimize, codegen) get added often.
- File-format readers: the type hierarchy of "tags in a PDF" is stable; the operations on them (render, extract text, validate) grow.
- Game engines: a closed set of object types; subsystems (render, physics, AI) keep being added.

## 25. Visitor — OO Hierarchies
*(Ep. Visitor-2)*

To set up the problem, here's the OO solution **without** Visitor:

```cpp
class Monster {
public:
    virtual ~Monster() = default;
    virtual void sing()  = 0;
    virtual void draw()  = 0;
    virtual void fight() = 0;
    virtual void save()  = 0;
};

class Orc : public Monster {
    void sing()  override { /* ... */ }
    void draw()  override { /* ... */ }
    void fight() override { /* ... */ }
    void save()  override { /* ... */ }
};

class Goblin : public Monster {
    void sing()  override { /* ... */ }
    void draw()  override { /* ... */ }
    void fight() override { /* ... */ }
    void save()  override { /* ... */ }
};
```

What's wrong:
- **Adding a new operation** (`celebrate()`) means modifying every monster class. That's *modification*, not extension — violates open/closed.
- **All monster code is in the monster classes.** The draw code for Orc is in `Orc::draw`. The save code is in `Orc::save`. If `draw` and `save` should live near each other in the codebase (they're related; they both serialize), too bad — they're separated by type.

Visitor flips this. We move *each operation* out into its own class, and each monster gets one method — `accept(Visitor&)` — that calls back into the visitor.

## 26. Visitor — Coding the Pattern
*(Ep. Visitor-3)*

The classical OO Visitor:

```cpp
class Orc;
class Goblin;

class MonsterVisitor {
public:
    virtual ~MonsterVisitor() = default;
    virtual void visit(Orc&)    = 0;
    virtual void visit(Goblin&) = 0;
};

class Monster {
public:
    virtual ~Monster() = default;
    virtual void accept(MonsterVisitor& v) = 0;
};

class Orc : public Monster {
public:
    void accept(MonsterVisitor& v) override { v.visit(*this); }
    int strength() const { return 100; }
};

class Goblin : public Monster {
public:
    void accept(MonsterVisitor& v) override { v.visit(*this); }
    int sneakiness() const { return 75; }
};
```

Now operations are *separate classes*:

```cpp
class DrawVisitor : public MonsterVisitor {
public:
    void visit(Orc& o)    override { std::cout << "Drawing orc, str " << o.strength() << '\n'; }
    void visit(Goblin& g) override { std::cout << "Drawing goblin, sneak " << g.sneakiness() << '\n'; }
};

class FightVisitor : public MonsterVisitor {
public:
    void visit(Orc& o)    override { std::cout << "Orc fights with strength " << o.strength() << '\n'; }
    void visit(Goblin& g) override { std::cout << "Goblin sneaks in for the kill\n"; }
};

// Usage
std::vector<std::unique_ptr<Monster>> monsters;
monsters.push_back(std::make_unique<Orc>());
monsters.push_back(std::make_unique<Goblin>());

DrawVisitor drawer;
FightVisitor fighter;

for (auto& m : monsters) m->accept(drawer);
for (auto& m : monsters) m->accept(fighter);
```

### Why two dispatches?

The call `m->accept(drawer)` involves two virtual lookups:

1. `m->accept(...)` — virtual dispatch on `m`'s dynamic type. If `m` points to Orc, this calls `Orc::accept`.
2. Inside `Orc::accept`, the call `v.visit(*this)` — virtual dispatch on `v`'s dynamic type, with `*this` resolved at compile time to `Orc&`. If `v` is a `DrawVisitor`, this calls `DrawVisitor::visit(Orc&)`.

That's the **double dispatch** — the final method called depends on both `m`'s type and `v`'s type. C++ does it in two single-dispatches stitched together by the `accept`/`visit` ceremony.

### Adding a new operation: easy

Want to add saving? Write one class:

```cpp
class SaveVisitor : public MonsterVisitor {
public:
    void visit(Orc& o)    override { /* serialize orc */ }
    void visit(Goblin& g) override { /* serialize goblin */ }
};
```

No monster class modified. Open/closed satisfied.

### Adding a new type: hard

Want to add `Troll`? You must:
1. Add `class Troll`.
2. Add `virtual void visit(Troll&) = 0;` to `MonsterVisitor`.
3. Add `void visit(Troll&) override` to **every** existing visitor class. The compiler will refuse to compile until you do — which is good if you want exhaustiveness, painful if there are 50 visitors.

This is the Visitor trade-off in one sentence: **operations are easy, types are hard**. Use it when your type set is stable.

> **🎯 Mental Model — Visitor inverts the matrix:**
> Imagine a matrix where rows are types and columns are operations. Virtual dispatch on the base class puts each cell in the row's class (Orc's row holds all of Orc's operations). Visitor puts each cell in the column's class (DrawVisitor's column holds all draw operations across types). Whichever axis you change more often dictates which way to lay out the matrix.

### Pros and Cons

| Pros | Cons |
|---|---|
| Easy to add new operations (open/closed for operations) | Hard to add new types — every visitor must be updated |
| Operation code is grouped, not scattered | Boilerplate: every visitor needs N `visit` methods |
| Forces exhaustive handling — compiler catches missed types | Two layers of virtual dispatch — minor perf cost |
| Lets you keep operation code out of type definitions | Visitors need access to enough of the type's public API |

## 27. Visitor — `std::variant` + `std::visit`
*(Ep. Visitor-4)*

C++17 added a much lighter-weight alternative to OO Visitor: `std::variant` (a type-safe union) plus `std::visit` (a generic visitor).

```cpp
#include <variant>
#include <iostream>

struct Orc    { int strength    = 100; };
struct Goblin { int sneakiness  = 75;  };

using Monster = std::variant<Orc, Goblin>;

struct DrawVisitor {
    void operator()(const Orc& o)    { std::cout << "Drawing orc, str " << o.strength << '\n'; }
    void operator()(const Goblin& g) { std::cout << "Drawing goblin, sneak " << g.sneakiness << '\n'; }
};

int main() {
    std::vector<Monster> monsters{ Orc{}, Goblin{}, Orc{} };
    for (const auto& m : monsters) std::visit(DrawVisitor{}, m);
}
```

What changed:
- **No `accept` / `visit` ceremony.** `std::visit(visitor, variant)` dispatches automatically.
- **No inheritance.** Types are plain structs. No virtual table.
- **No heap allocations.** `std::variant` is value-type — held inline.
- **Visitor is a functor**, not a class with overridden virtual methods.

### Inline visitors with `overloaded`

The pattern is so common there's an idiom: an `overloaded` helper that turns a set of lambdas into one functor.

```cpp
template <class... Ts> struct overloaded : Ts... { using Ts::operator()...; };
// C++17 deduction guide (C++20 makes it automatic):
template <class... Ts> overloaded(Ts...) -> overloaded<Ts...>;

for (const auto& m : monsters) {
    std::visit(overloaded{
        [](const Orc& o)    { std::cout << "Orc str "    << o.strength    << '\n'; },
        [](const Goblin& g) { std::cout << "Goblin sneak "<< g.sneakiness << '\n'; }
    }, m);
}
```

The `overloaded` struct multiply-inherits from each lambda and pulls in all their `operator()`s. Result: a callable that knows how to handle each variant alternative. C++ idiom canon since C++17.

### Exhaustiveness

`std::visit` requires the visitor handle **every** alternative. Forget one and you get a compile error — the same exhaustiveness guarantee as virtual `=0`, with none of the boilerplate.

```cpp
// Adding a new alternative to the variant:
using Monster = std::variant<Orc, Goblin, Troll>;

// Old visitor compiles fail until Troll case is added:
std::visit(overloaded{
    [](const Orc&)    { /* ... */ },
    [](const Goblin&) { /* ... */ }
    // ❌ error: no match for Troll
}, m);
```

### When variant beats inheritance

| Pick `std::variant` when... | Pick inheritance when... |
|---|---|
| Type set is small, closed, value-semantic | Type set is open or large; new types added by users |
| You want no heap allocations | You need polymorphic ownership across the hierarchy |
| You want exhaustive switch with compile-time guarantee | You need dynamic dispatch through pointers and `dynamic_cast` |
| Types are "data-like" with little behavior | Types have rich method sets that are stable |

### When variant struggles

- **Open type sets.** You can't add a new type without modifying the `using Monster = ...` line everywhere.
- **Recursive types.** A `Expr = std::variant<Lit, Add, Mul>` where Add holds two `Expr`s needs an indirection: `Add { std::unique_ptr<Expr> lhs, rhs; }` — variants must be sized, and infinite recursion isn't sized.

> **🏭 Industry Note — Modern C++ codebases pick `std::variant` by default:**
> If you're starting a new project in C++17 or later and the type set is closed, reach for `std::variant`. Less boilerplate, no virtual dispatch, no heap allocation, exhaustiveness checked at compile time. Use OO Visitor when you genuinely need an open hierarchy (plugins, user-extensible types).

> **🔬 Under the Hood — How `std::visit` dispatches:**
> Modern `std::visit` compiles to a jump table indexed by the variant's discriminator (the index of the held alternative). For an N-alternative variant, it's O(1) — typically one indirect jump. No virtual dispatch, no vtable lookup. On well-optimizing compilers, the compiler can sometimes inline the entire visit when it knows the alternative statically.

---

# Part IV — Structural Patterns

Structural patterns are about **how classes and objects are composed** into larger structures. They tend to be quieter than behavioral patterns — they shape your headers and class layout rather than your control flow.

## 28. Flyweight
*(Ep. Flyweight-1)*

The **Flyweight** pattern reduces memory by **sharing** common state across many objects, while keeping object-specific state per-instance. Use it when you have thousands or millions of objects that mostly look alike but differ in a few attributes.

Mike's example: a real-time strategy game (LotR: Battle for Middle Earth) with 500 identical soldiers on screen. Each soldier has a 3D mesh, textures, animations, base stats — **identical** across all 500. Each also has its own position, rotation, health, current animation frame — **different**. If every soldier carries its own copy of mesh + textures + animations, you waste hundreds of MB.

The fix: separate **intrinsic** state (shared across instances — the heavy stuff) from **extrinsic** state (unique per instance — the light stuff). Many instances reference one shared intrinsic object.

```
Without Flyweight                With Flyweight
─────────────────                ──────────────

Soldier 1: [mesh|tex|anim|x|y]   Soldier 1: [→model | x|y]
Soldier 2: [mesh|tex|anim|x|y]   Soldier 2: [→model | x|y]    ┌──── shared ────┐
Soldier 3: [mesh|tex|anim|x|y]   Soldier 3: [→model | x|y] ───┤ mesh|tex|anim  │
...                              ...                          └────────────────┘
Soldier N: [mesh|tex|anim|x|y]   Soldier N: [→model | x|y]
```

### Terminology

- **Flyweight** — the shared object. Holds the **intrinsic** state.
- **Extrinsic state** — the per-instance state, passed into the flyweight's methods.
- **Flyweight Factory** — creates and caches flyweights so duplicates aren't built.

### Basic implementation

```cpp
#include <iostream>
#include <vector>

class TreeModel {                   // the flyweight
public:
    TreeModel(std::vector<int> mesh, std::string texture)
      : mesh_(std::move(mesh)), texture_(std::move(texture)) {}

    void draw(float x, float y, float z) const {
        std::cout << "Drawing tree at (" << x << ", " << y << ", " << z << ")\n";
        // ... real implementation uses mesh_ and texture_ ...
    }

private:
    std::vector<int> mesh_;          // intrinsic — shared
    std::string texture_;            // intrinsic — shared
};

class Tree {                         // the per-instance wrapper
public:
    Tree(const TreeModel& model, float x, float y, float z)
      : model_(model), x_(x), y_(y), z_(z) {}

    void draw() const { model_.draw(x_, y_, z_); }

private:
    const TreeModel& model_;         // reference to the shared model
    float x_, y_, z_;                // extrinsic — unique
};

// Usage
TreeModel oak({/* mesh data */}, "oak_bark.png");
std::vector<Tree> forest;
for (int i = 0; i < 10000; ++i) {
    forest.emplace_back(oak, rand() % 1000, 0, rand() % 1000);
}
for (const auto& t : forest) t.draw();
```

10,000 trees share **one** mesh and **one** texture. The per-tree memory cost is just the reference plus three floats — maybe 16 bytes total instead of megabytes.

## 29. Flyweight Factory and Handles
*(Ep. Flyweight-2)*

The bare Flyweight isn't enough — you still have to remember not to construct duplicate flyweights. The **Flyweight Factory** caches them:

```cpp
#include <memory>
#include <map>
#include <string>

class TreeModelFactory {
public:
    std::shared_ptr<TreeModel> getModel(const std::string& key) {
        auto it = cache_.find(key);
        if (it != cache_.end()) {
            std::cout << "Reusing " << key << '\n';
            return it->second;
        }
        // Cache miss — construct, store, return
        auto model = std::make_shared<TreeModel>(loadMesh(key), loadTexture(key));
        cache_[key] = model;
        return model;
    }

private:
    std::map<std::string, std::shared_ptr<TreeModel>> cache_;

    std::vector<int>  loadMesh(const std::string&)    { /* expensive */ return {}; }
    std::string       loadTexture(const std::string&) { /* expensive */ return {}; }
};

// Usage
TreeModelFactory factory;
auto oak  = factory.getModel("oak");   // cache miss — loads from disk
auto oak2 = factory.getModel("oak");   // cache hit — reused
auto palm = factory.getModel("palm");  // cache miss
```

Now any caller that asks for "oak" gets the same `TreeModel` — no duplication, even if many systems request the model independently.

### Handles instead of pointers

In some APIs the flyweight isn't a pointer but an **opaque handle** — an integer index into a hidden table. This is how OpenGL works (buffer objects, texture objects, shader programs are all `GLuint` handles), and how many game engines model assets.

```cpp
using TreeHandle = std::size_t;

class TreeRegistry {
public:
    TreeHandle load(const std::string& key) {
        auto it = byKey_.find(key);
        if (it != byKey_.end()) return it->second;
        TreeHandle h = models_.size();
        models_.emplace_back(loadMesh(key), loadTexture(key));
        byKey_[key] = h;
        return h;
    }

    const TreeModel& get(TreeHandle h) const { return models_[h]; }

private:
    std::vector<TreeModel> models_;
    std::map<std::string, TreeHandle> byKey_;
    // loadMesh/loadTexture omitted
};
```

Advantages of handles over pointers:
- **Stable across reallocation.** If the model vector grows, pointers invalidate; handles don't.
- **Smaller** (often `uint32_t` vs 8-byte pointer).
- **Sendable** — handles can serialize over the network; pointers can't.
- **Type-safe** with a `enum class TreeHandle : uint32_t {}` wrapper.

### What you give up

- **Fine-grained per-instance customization.** All trees with the "oak" key are *exactly* identical in their intrinsic state. If one tree needs slightly different bark, you either: (a) make a new "oak-variant" key (factory cache grows), or (b) skip the flyweight for that one tree.
- **Sharing means concurrent access.** If you ever mutate the intrinsic state, every instance using it sees the change. That's usually a feature (changing all trees' texture once), but can be a footgun.
- **Lifetime management.** A naive `getModel` returns a shared_ptr; the factory must outlive all clients, or use shared ownership.

### Pros and Cons

| Pros | Cons |
|---|---|
| Massive memory savings for many similar objects | Adds indirection per access (cache or register lookup) |
| Better cache locality — shared model fits in L1/L2 | Requires careful separation of intrinsic and extrinsic state |
| Faster construction — shared bits already loaded | Mutating shared state affects all instances |
| Pairs naturally with Factory for asset loading | Lifetime: factory must outlive instances |

> **🎯 Mental Model — Flyweight is value-type vs reference-type, applied:**
> If a heavy field is the same across 10,000 instances, it should be a reference (or shared pointer, or handle). If it's unique, it should be a value. Flyweight is the deliberate, named version of "make this a reference because it's shared."

> **🔬 Under the Hood — Why this helps performance:**
> Cache locality. Modern CPUs read memory in 64-byte cache lines. If 10,000 tree objects all carry a copy of a 1 MB mesh, the mesh is *not* in cache when you draw the second tree. If they all reference one mesh, the first tree's draw loads it into cache, and the next 9,999 draws benefit. Mike's race-track illustration in the Flyweight video is exactly this: L1 hits in ~0.5 ns, main memory in ~100 ns — 200x difference.

## 30. Component — Identifying Components
*(Ep. Component-1)*

The **Component** pattern (also: **Entity-Component**, generalized into **Entity-Component-System / ECS**) builds objects by **composing them from independent components** instead of inheriting behavior from a class hierarchy. It's the dominant pattern in modern game engines (Unity, Unreal, Godot) and applies anywhere you have objects whose responsibilities don't fall into a clean inheritance tree.

Mike's setup: looking at a Mario screenshot, what *objects* are there? Mario, Yoshi, enemies, blocks, clouds, UI, the bush in the background. Every object needs a unique ID (a `uint64_t` handle, not a string — strings are slow to compare and easy to typo).

Then: what *components* does each object have? Mario: texture, animation, collision box, position, input handler, physics body, dialogue UI. An enemy AI: texture, animation, collision box, position, AI behavior. The bush: just texture and position.

If we model these with **inheritance** — `class Mario : public Character, public PlayerControlled, public PhysicsObject` — we get into multiple-inheritance hell quickly:

```
                  GameObject
                  /        \
            Static          Dynamic
           /     \         /       \
     Cloud   Bush     Player    Enemy
                          \      /
                          EvilTree  ← inherits both?
```

`EvilTree` is a tree (static) that also moves and attacks (dynamic). Multiple inheritance is technically allowed in C++, but the diamond is a pain — virtual base classes, name collisions, weird construction order. And every new combination of behaviors needs a new class.

### The monolithic alternative

Throw away inheritance; put every possible component as a field on one `GameObject`:

```cpp
class GameObject {
public:
    // ...
private:
    TextureData*   texture_;
    Collider*      collider_;
    Transform*     transform_;
    AIBehavior*    ai_;
    InputHandler*  input_;
    PhysicsBody*   physics_;
    DialogueBox*   dialogue_;
    // ... more, every time you add a system ...
};
```

This works for small projects (a game jam, a prototype). It fails at scale:
- Every `GameObject` carries pointers to every possible component, even if unused (`nullptr`). Memory waste.
- The class becomes a god-object — every system pokes into it, coupling everything to everything.
- Update logic — `if (collider_) checkCollision(); if (ai_) ai_->tick(); ...` — branches forever.

We can do better with explicit Component pattern.

## 31. Component Pattern — Composition Over Inheritance
*(Ep. Component-2)*

The pattern: a `GameObject` holds a **collection of components**. Each component does **one thing** (texture, collision, AI). The GameObject doesn't know what components it has at compile time — they're added dynamically.

```cpp
class IComponent {
public:
    virtual ~IComponent() = default;
    virtual void update() = 0;
};
```

Each subsystem provides its own component:

```cpp
class TextureComponent : public IComponent {
public:
    void update() override { /* render the texture */ }
};

class ColliderComponent : public IComponent {
public:
    void update() override { /* check collisions */ }
};
```

The game object:

```cpp
class GameObject {
public:
    void addComponent(std::unique_ptr<IComponent> c) {
        components_.push_back(std::move(c));
    }

    void update() {
        for (auto& c : components_) c->update();
    }

private:
    std::vector<std::unique_ptr<IComponent>> components_;
};

// Usage
GameObject mario;
mario.addComponent(std::make_unique<TextureComponent>());
mario.addComponent(std::make_unique<ColliderComponent>());
mario.addComponent(std::make_unique<InputComponent>());

GameObject bush;
bush.addComponent(std::make_unique<TextureComponent>());
// bush has no collider, no input

while (running) mario.update();
```

What we gained:
- **Compose any object** by picking components. No combinatorial inheritance explosion.
- **One responsibility per component.** Easy to test in isolation.
- **Decoupled systems.** TextureComponent doesn't know anything about ColliderComponent.
- **Dynamic.** Add or remove components at runtime — power-up gives the player a `FlyingComponent`; remove it when the power-up expires.

### Decoupling

The crucial insight Mike emphasizes: in the monolithic design, the `update()` of a single GameObject knows about every subsystem:

```cpp
void GameObject::update() {                       // monolithic
    if (collider_->collidesWith(floor)) { /* physics knows about floor */ }
    if (renderState_ != Invisible)       { /* render knows about state */ }
    sound_->play(jumpSound);                       // sound knows about a sound
    // ... all systems coupled into one function
}
```

In the Component pattern, each component's `update()` knows only about its own subsystem:

```cpp
void TextureComponent::update()  { /* only graphics here */ }
void ColliderComponent::update() { /* only physics here */ }
void SoundComponent::update()    { /* only sound here */ }
```

The components don't talk to each other directly. If they need to (the collider needs to know the position), they query the parent GameObject for the position component. Decoupled subsystems, separately testable, separately maintainable.

## 32. Component — Implementation
*(Ep. Component-3)*

The naive `std::vector<std::unique_ptr<IComponent>>` is fine for a small game but limits lookup. Usually you want to ask "does this object have a TextureComponent?" — a vector is O(N).

Use a `std::map` (or `std::unordered_map`) keyed by component type:

```cpp
enum class ComponentType { Texture, Collider, Position, AI, Input };

class IComponent {
public:
    virtual ~IComponent() = default;
    virtual void update() = 0;
    virtual ComponentType type() const = 0;
};

class TextureComponent : public IComponent {
public:
    void update() override { /* ... */ }
    ComponentType type() const override { return ComponentType::Texture; }
};

class GameObject {
public:
    void addComponent(std::unique_ptr<IComponent> c) {
        auto t = c->type();
        components_[t] = std::move(c);          // overwrites if duplicate
    }

    IComponent* getComponent(ComponentType t) {
        auto it = components_.find(t);
        return (it != components_.end()) ? it->second.get() : nullptr;
    }

    void update() {
        for (auto& [type, comp] : components_) comp->update();
    }

private:
    std::map<ComponentType, std::unique_ptr<IComponent>> components_;
};
```

Now lookups are O(log N) — usually fine. For tighter inner loops, switch to `std::unordered_map`.

### A templated typed `getComponent<T>()`

Type-safe component access:

```cpp
template <typename T>
T* getComponent() {
    auto it = components_.find(T::staticType());
    return (it != components_.end()) ? static_cast<T*>(it->second.get()) : nullptr;
}

// Each component declares a static type:
class TextureComponent : public IComponent {
public:
    static ComponentType staticType() { return ComponentType::Texture; }
    ComponentType type() const override { return staticType(); }
    // ...
};

// Usage
auto* tex = mario.getComponent<TextureComponent>();
if (tex) tex->setVisible(false);
```

The cast is safe because we keyed by the same type. No `dynamic_cast` cost — just a type-checked index.

### Component ordering

Components in a `std::map` update in **key order**. If physics must run before rendering (it changes positions before they're drawn), `Physics < Rendering` in the `enum class`. Or use a priority queue, or sort the components vector by priority.

### Component-to-component communication

Components live in the same GameObject. If `AIComponent::update()` needs the position:

```cpp
void AIComponent::update() {
    auto* pos = owner_->getComponent<PositionComponent>();
    if (!pos) return;
    targetPosition_ = computePathTo(player, pos->location());
    pos->setLocation(stepToward(targetPosition_));
}
```

The AI component holds a back-pointer to its owner (`GameObject*`) and queries siblings. This is the standard idiom.

### Pros and Cons

| Pros | Cons |
|---|---|
| No multiple-inheritance hell | Component lookup overhead vs direct field access |
| Compose any object from any mix of components | Memory: `unique_ptr` per component is one heap alloc each |
| Add/remove components at runtime | Components must coordinate via the owning GameObject |
| Each component is independently testable | The "what components does Mario have" answer is dynamic — harder to reason about statically |

> **⚠️ Pitfall — Component lifetime and ownership:**
> If two components both need access to a third (the AI needs the collider, the renderer also needs the collider), don't `delete` the collider when the AI is removed. The `unique_ptr<IComponent>` model in the GameObject already handles this — the GameObject owns the components — but be careful with raw pointers passed between components.

## 33. Component — Data-Oriented Design and ECS
*(Ep. Component-4)*

The Component pattern as we've written it is **clean** but not **fast**. Each `update()` iterates a map of components per GameObject, calling virtual functions, chasing pointers. For 10,000 objects times 5 components each, that's 50,000 virtual calls per frame, each potentially missing the cache.

The performance fix is **Data-Oriented Design (DOD)** — and its most popular realization, **Entity-Component-System (ECS)**.

### The problem with object-major iteration

```cpp
for (auto& obj : gameObjects) {
    for (auto& [type, comp] : obj.components) {
        comp->update();   // jumps around in memory
    }
}
```

Memory layout: object 1's components (scattered on the heap), object 2's components (scattered elsewhere), object 3's components (scattered elsewhere again). Every component access is a potential cache miss.

### The DOD reorganization

Instead of object-major (`for each object: for each of its components`), go **system-major**:

```cpp
// All AI components in one flat array
std::vector<AIComponent> allAIs;

// All physics components in one flat array
std::vector<PhysicsComponent> allPhysics;

// Update phase
for (auto& ai : allAIs)         ai.update();      // sequential access; cache-friendly
for (auto& phys : allPhysics)   phys.update();    // sequential access; cache-friendly
for (auto& tex : allTextures)   tex.draw();       // sequential access; cache-friendly
```

Each system iterates a tightly-packed array of *just its component type*. Cache stays hot — the CPU prefetches the next few components automatically. This is often **10–100× faster** than the object-major version for large component counts.

### Entity-Component-System (ECS)

ECS is the formalized version:
- **Entity** — just an ID (`uint32_t`). No state.
- **Component** — pure data, no logic.
- **System** — pure logic, iterates over components.

```cpp
using EntityId = std::uint32_t;

struct Position  { EntityId id; float x, y; };
struct Velocity  { EntityId id; float dx, dy; };

class MovementSystem {
public:
    void update(std::vector<Position>& positions, const std::vector<Velocity>& velocities) {
        // Assume sorted by EntityId, joinable
        // ... merge and apply velocity to position ...
    }
};
```

Real ECS libraries (`entt`, `flecs`) handle the bookkeeping — finding entities that have both Position and Velocity, managing sparse-vs-dense storage, parallelizing systems that don't conflict. The pattern is the same: data is flat and cache-friendly; systems iterate one kind of data at a time.

### When ECS is worth the complexity

| Pick standard Component pattern when... | Pick ECS when... |
|---|---|
| Hundreds of objects, simple update logic | Tens of thousands of objects, performance-critical |
| Components frequently talk to each other | Components are mostly independent data |
| Compile-time fixed component set | Dynamic, runtime-configured entities |
| Game jam, prototype, small project | Production game engine, simulation, very large worlds |

ECS adds significant complexity: separating data from logic, querying systems that match component sets, parallelizing. For a small project, it's overkill. For a AAA game with 100k+ entities, it's table stakes.

> **🎯 Mental Model — Object-major vs System-major:**
> A spreadsheet of `entity × component`. Object-major says "process row by row" — for each entity, do all its components. System-major says "process column by column" — for each component type, do all the entities that have it. Hardware loves system-major: contiguous memory, prefetch, SIMD-friendly. Use object-major when entity counts are small or component interactions dominate; system-major when entity counts are large and components are independent.

> **🏭 Industry Note — `entt`:**
> [`entt`](https://github.com/skypjack/entt) is the most popular C++ ECS library. Header-only, blazing fast, used in Mojang's *Minecraft* (Bedrock), Unity DOTS, and many indie games. If you're building anything with thousands of entities, just start with `entt` — building ECS yourself is a multi-month project and you'll get worse performance.

---

# Part V — Closing

## 34. Cross-Pattern Cheat Sheet
*(Synthesized)*

When you see a code smell, this table tells you which pattern probably fits.

| If you see... | Probable pattern | Why |
|---|---|---|
| Long `if`/`else if` chains picking an algorithm | **Strategy** | Each branch is an interchangeable algorithm |
| `new SomeConcreteClass()` scattered across the codebase | **Factory Method** | Centralize construction; hide concrete types |
| New types added at runtime from config or plugins | **Extensible Factory** | Register, don't recompile |
| Slow object setup repeated many times | **Prototype** | Build once, clone many |
| Need exactly one instance of something | **Singleton** | …but consider DI first |
| Action that might need undo/redo or queueing | **Command** | First-class action objects |
| Notifying multiple subsystems when one thing changes | **Observer** | Open-closed for subscribers |
| Need to traverse a container uniformly | **Iterator** | STL idiom |
| Adding operations to a stable type hierarchy | **Visitor** or **`std::variant`** | Open for ops, closed for types |
| 10,000 nearly-identical objects | **Flyweight** | Share intrinsic state |
| Multiple-inheritance hell to combine behaviors | **Component** | Compose features instead |
| 100k+ objects with simple updates per frame | **ECS** | System-major iteration |

### Pattern partnerships

Patterns rarely appear alone. Common pairings:

- **Singleton + Factory.** Most factories are singletons (one factory for the type hierarchy).
- **Factory + Prototype.** The factory holds prototypes; `create(key)` clones the corresponding prototype.
- **Strategy + Observer.** Observers strategy-plug their `onNotify` behavior.
- **Command + Observer.** Subjects fire commands at observers instead of calling fixed methods.
- **Visitor + Composite.** Operations on tree structures (compiler ASTs are the canonical case).
- **Flyweight + Component.** Components like TextureComponent are flyweights; many objects share textures.
- **Component + Strategy.** Each component is essentially a strategy plugged into the object.

## 35. Modern C++ Features That Replace Patterns
*(Cross-cutting)*

Many of the GoF patterns were designed in 1994 for a world without modern language features. C++ has caught up; some patterns are now language idioms.

| Pattern | Modern C++ replacement |
|---|---|
| Iterator | Range-`for` + `std::begin`/`std::end` (range-`for` is *built-in* Iterator) |
| Strategy (stateless) | `std::function`, lambdas, or template parameter |
| Visitor (closed type set) | `std::variant` + `std::visit` |
| Singleton (function-scope) | Function-local `static` (Meyers Singleton) |
| Factory (sometimes) | `std::make_unique` / `std::make_shared` for trivial cases |
| Observer (lightweight) | `std::function` callback list |
| Command | Lambda capturing the action |
| Builder (not in this guide) | Designated initializers (C++20), or pure functions |

This isn't a license to skip learning the patterns — knowing them is how you recognize the language features as patterns and use them correctly. But it does mean you write less boilerplate. Reach for the language feature first; reach for the full pattern when the feature isn't expressive enough.

> **🎯 Mental Model — Patterns are language-shaped holes:**
> Christopher Alexander's original formulation was that patterns describe forces and resolutions in a problem. A language feature that perfectly resolves the forces becomes the *replacement* for the pattern. C++'s `std::variant` resolves Visitor's open-types problem so cleanly that for closed-type-set Visitor it *is* Visitor. The pattern doesn't disappear — it becomes the language feature.

## 36. Code Review Red Flags
*(Synthesized)*

Patterns done badly. If you see these on a code review, push back.

| Flag | Why it's a problem |
|---|---|
| Singleton used because "we needed easy access" | That's a DI problem, not a single-instance problem |
| Factory function that returns raw `new` pointer | Ownership unclear; use `std::unique_ptr` |
| Observer that holds raw `Subject*` with no documented lifetime | Dangling subject on destruction |
| Visitor that uses `dynamic_cast` instead of accept/visit | Not actually visitor; just type-checking; consider `std::variant` |
| Component class with logic in it (e.g., `update()` does AI) | Components should be data; logic goes in systems (ECS) — or document why |
| Strategy injected via a setter that's never called | Either default-construct correctly, or make it a constructor parameter |
| Prototype `clone()` that does shallow copy | Almost always a bug; deep copies are the point |
| Flyweight factory that doesn't actually cache | Defeats the entire purpose; check the `find` logic |
| Singleton with mutable global state and no locking | Race conditions waiting to happen |
| Command without `undo()` despite docs claiming undo support | Half-implemented pattern |

## 37. Resources & Further Reading

### Books

- **Gamma, Helm, Johnson, Vlissides — *Design Patterns: Elements of Reusable Object-Oriented Software*** (1994). The "Gang of Four" book; the canonical reference. Reads C++03; pair with modern idioms.
- **Robert Nystrom — *Game Programming Patterns*** ([free online](https://gameprogrammingpatterns.com), also in print). The book Mike repeatedly references. Excellent treatment of Component, Flyweight, Observer, Command, and game-specific patterns (Game Loop, Update Method, Service Locator) that GoF doesn't cover.
- **Andrei Alexandrescu — *Modern C++ Design***. Templates + policies = patterns. The Extensible Factory and policy-based Strategy come from here.
- **Martin Reddy — *API Design for C++***. PIMPL, factories, and pattern usage in library design.
- **Scott Meyers — *Effective C++***, *More Effective C++*, *Effective Modern C++*. Not pattern-specific, but every C++ engineer should read all three.

### Online references

- [`cppreference.com`](https://en.cppreference.com) — authoritative for `std::variant`, `std::visit`, `std::function`, `std::unique_ptr`, etc.
- [`isocpp.org/CppCoreGuidelines`](https://isocpp.org/CppCoreGuidelines) — Stroustrup & Sutter's curated rules; many touch on patterns (e.g., R.30 "Take smart pointers as parameters only to explicitly express lifetime semantics").
- [`refactoring.guru/design-patterns`](https://refactoring.guru/design-patterns) — visual, language-agnostic catalog.
- [Mike Shah's site, `mshah.io`](https://www.mshah.io) — companion videos in distraction-free environment.

### Libraries to know

| Library | Pattern(s) | Notes |
|---|---|---|
| **Boost.Signals2** | Observer | Header-only, thread-safe signals/slots |
| **Qt** | Observer | Signals & slots; uses MOC code generation |
| **`entt`** | Component / ECS | Fastest header-only ECS; production-grade |
| **`flecs`** | Component / ECS | Alternative ECS with query system |
| **`spdlog`** | Singleton (sometimes) | Logger; usually used as a singleton |
| **`mpark/variant`** | Visitor | `std::variant` backport for C++11/14 |

## 38. A 60-Day Study Plan

**Days 1–7 — Foundations.** Read Parts I–II. Implement Singleton (Meyers and naive), Factory Method, Extensible Factory. Write tests that demonstrate why Singleton-as-global is bad (mock it out, see the pain).

**Days 8–14 — Creational deep dive.** Add Prototype to a project: an entity system that clones a configured "template" entity. Compare the perf of repeated construction vs prototype cloning.

**Days 15–28 — Behavioral patterns.** One pattern every 2–3 days:
- Strategy: pick three algorithms (sort, compress, hash) and refactor an `if`-chain to Strategy.
- Command: implement an undo/redo stack for a small editor.
- Iterator: write a custom iterator for a tree or sparse vector.
- Observer: build a small event system end-to-end with RAII registration and channels.
- Visitor: pick a small expression-tree problem (calculator, JSON walker). Implement both OO Visitor and `std::variant` + `std::visit`. Compare.

**Days 29–45 — Structural patterns.** 
- Flyweight: identify a memory hog in code you've already written; refactor to Flyweight. Measure before/after.
- Component: build a small entity system with the Component pattern. Add 3–4 component types. Test in isolation.
- ECS bonus: rebuild the same entity system on top of `entt`. Compare line counts and performance.

**Days 46–60 — Integration and review.**
- Pick an open-source C++ project (a game engine, a compiler, a database). Read until you can identify 5 patterns it uses. Note which patterns it uses with library help (Boost.Signals2 for Observer, etc.) vs. hand-rolled.
- Write up notes on what patterns you'd reach for in your own domain (networking, web services, embedded — wherever you work).
- Revisit Singleton and Visitor. They're the two most-abused patterns; rereading after building stuff with the others should change how you see them.

### Final advice

- **Don't pattern-match prematurely.** Write the obvious code first. Refactor to a pattern when the obvious code starts creaking.
- **One pattern at a time.** Patterns compose, but layering three on day one is how codebases become unreadable.
- **The pattern is not the goal.** Maintainable, testable code is the goal. If applying a pattern makes code less of those, undo.
- **Recognize patterns in the standard library.** `std::visit` is Visitor. `std::function` is Strategy. `std::shared_ptr` is partially Flyweight (the control block is shared). The STL is patterns made library.
- **`make_unique` over `new` everywhere.** This is not optional in 2026.
- **Profile before optimizing.** ECS vs Component is a real win at scale; switching for a 100-entity game is wasted effort. Measure first.

The senior-engineer skill in design patterns is not "which pattern fits here?" — it's "do I need a pattern here, or is plain code enough?" Most code doesn't need a pattern. The patterns you do reach for should make the code visibly clearer to the next reader, not just demonstrate that you read the GoF book.
