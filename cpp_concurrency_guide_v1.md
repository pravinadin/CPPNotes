# Modern C++ Concurrency — Comprehensive Study Guide (Playlist Edition)

> **Source:** Mike Shah's *Introduction to Concurrency in C++* YouTube playlist
> [`https://www.youtube.com/playlist?list=PLvv0ScY6vfd_ocTP2ZLicgqKnvq50OCXM`](https://www.youtube.com/playlist?list=PLvv0ScY6vfd_ocTP2ZLicgqKnvq50OCXM)
> **Reference:** Standard library examples follow [cppreference.com](https://en.cppreference.com) idioms.
> **Coverage:** Modern C++ threading — C++11 / C++14 / C++17 / C++20.

## How this guide is organized

The playlist is the spine. Every section below is annotated with the episode it draws from — e.g. **(Ep. *mutex and data races*)** — so if you watch in order, you can read the corresponding section as a written companion; if you read in order, you can spot-check any topic against the matching video.

The guide is **synthesized**, not transcribed. It captures the framing, examples, and pitfalls Mike walks through, then layers on the mental models, "under the hood" notes, and industry context you'd want before using these primitives in a production codebase. Code examples compile cleanly under:

```bash
g++ -std=c++20 -Wall -Wextra -Wpedantic -pthread file.cpp -o file
# Debug build with the race detector enabled:
g++ -std=c++20 -g -O1 -pthread -fsanitize=thread file.cpp -o file
```

**Why a separate guide?** The main *C++ Programming Language* guide deliberately scopes out concurrency for fidelity to that playlist. This guide fills that gap and stands on its own — you can read it without reading the main guide first, though references like *RAII*, *lambdas*, and *smart pointers* will be more grounded if you have.

---

## Table of Contents

**Part I — Foundations of Concurrency**
1. [The What and the Why of Concurrency](#1-the-what-and-the-why-of-concurrency)
2. [Threads as a Model of Concurrency](#2-threads-as-a-model-of-concurrency)
3. [First Thread with `std::thread`](#3-first-thread-with-stdthread)
4. [Passing Callables: Function Pointers, Functors, Lambdas](#4-passing-callables-function-pointers-functors-lambdas)
5. [Launching Many Threads](#5-launching-many-threads)
6. [`std::jthread` — RAII Threads (C++20)](#6-stdjthread--raii-threads-c20)

**Part II — Shared State and Mutual Exclusion**
7. [Shared State and Data Races](#7-shared-state-and-data-races)
8. [`std::mutex` and Critical Sections](#8-stdmutex-and-critical-sections)
9. [`std::lock_guard` — RAII for Locks](#9-stdlock_guard--raii-for-locks)
10. [`try_lock` — Non-Blocking Acquisition](#10-try_lock--non-blocking-acquisition)
11. [Deadlock and How to Avoid It](#11-deadlock-and-how-to-avoid-it)

**Part III — Higher-Level Synchronization**
12. [Condition Variables and `std::unique_lock`](#12-condition-variables-and-stdunique_lock)
13. [`std::atomic` — Lock-Free Shared Values](#13-stdatomic--lock-free-shared-values)

**Part IV — Asynchronous Programming**
14. [`std::async` and `std::future` — Tasks, Not Threads](#14-stdasync-and-stdfuture--tasks-not-threads)
15. [Background Loading with `std::async`](#15-background-loading-with-stdasync)

**Part V — Tooling and Applied Patterns**
16. [ThreadSanitizer (TSan) — Catching Data Races](#16-threadsanitizer-tsan--catching-data-races)
17. [Data Parallelism — A Multithreaded SFML Example](#17-data-parallelism--a-multithreaded-sfml-example)

**Part VI — Closing**
18. [Idioms, Pitfalls & Best Practices Cheat Sheet](#18-cheat-sheet)
19. [Resources & Further Reading](#19-resources)

---

# Part I — Foundations of Concurrency

## 1. The What and the Why of Concurrency
*(Ep. The what and the why of concurrency)*

**Concurrency** is the ability to have two or more events happen or progress at the same time, with some ordering or synchronization between them. **Parallelism** is a stricter form: things happen *truly simultaneously*, with no sharing, no waiting.

A useful analogy from Joe Armstrong: imagine a coffee shop.

- **Parallelism** = two coffee machines, two queues. Each queue is independent — nobody waits on the other line.
- **Concurrency** = two queues, one coffee machine. People can stand in line, check their phones, do other work; but when it's time to actually use the machine, *somebody has to wait*.

In computer terms:
- **Concurrency** is about *dealing with* a lot of things at once (program structure).
- **Parallelism** is about *doing* a lot of things at once (execution).

You typically want concurrency because **performance is the currency of computing** (Charles Leiserson). A single-threaded program on an 8-core machine uses at most 12.5% of the hardware. With concurrency, you can use the rest — to render better graphics, run smarter AI, handle more requests per second, or just feel snappier to the user.

### Why we *need* concurrency

For decades, single-core processors got faster every 18–24 months — Moore's Law combined with **Dennard scaling** (clock speeds rising as transistors shrunk). That's no longer free. Packing transistors closer means switching them on/off faster, which generates heat, which melts chips. **The free lunch is over** (Herb Sutter, 2005).

The hardware industry responded by adding **more cores instead of faster cores**. Modern phones have 4–8. Modern laptops have 8–16. Modern game consoles (Xbox Series X, PS5) ship with 8. To use that hardware, software has to be concurrent. That's the job.

> **🎯 Mental Model — Synchronization is the hard part:**
> The CPU running multiple things at once is "free" (the OS scheduler handles it). What costs effort is **coordinating** them — making sure they don't step on each other's data, making sure one waits when another is producing the result it needs. Almost every chapter of this guide is really about synchronization.

> **🏭 Industry Note — When concurrency pays off:**
> - **CPU-bound work**: parallel image processing, video encoding, scientific simulations, ML inference.
> - **I/O-bound work**: web servers, file loaders, network proxies — a thread is parked waiting on disk/network anyway, so you may as well have many.
> - **UI responsiveness**: never block the main thread on slow work. Push it to a worker; let the UI loop keep painting at 60+ FPS.
>
> Where concurrency **doesn't** pay off: tiny computations (thread startup costs ≫ work), or problems with so much shared state that locking dominates (the so-called *Amdahl's law ceiling*).

## 2. Threads as a Model of Concurrency

Concurrency is the *idea*; **threads** are one of several mechanisms to express it. Others you may have heard of:
- **Processes** (heavyweight, separate address spaces — `fork`/IPC).
- **Coroutines** (cooperative, single-threaded by default — C++20 `co_await`).
- **Actor systems / message passing** (Erlang/Akka style).
- **GPU thread blocks** (CUDA/SYCL, for embarrassingly parallel data work).

A thread is a **lightweight process**: it shares the same address space, code, heap, and global data as its peers in the same process, but each thread has its own:

| Per-thread | Shared (process-wide) |
|------------|-----------------------|
| Stack | Heap (`new`/`malloc`) |
| Registers (program counter, stack pointer, etc.) | Code (`.text`) and constants (`.rodata`) |
| Local variables | Globals and `static` variables |
| Thread-local storage (`thread_local` keyword) | Open files, sockets, signal handlers |

The OS time-slices threads onto cores via **context switching**: it saves one thread's registers, loads another's, and resumes. With multiple cores, threads can also run truly in parallel.

### Why threads are powerful — and dangerous

The power: threads can **share data** directly. No serialization, no IPC, no marshalling — both threads read and write the same memory.

The danger: threads can **share data**. If two threads read and write the same memory without coordination, you get a **data race**, which is undefined behavior in C++. The remainder of this guide is largely about how to share safely.

> **🔬 Under the Hood — Why threads, not processes?**
> Spinning up a new process is expensive: the OS clones page tables, file descriptors, etc. Spinning up a new thread reuses all of that — only the stack and a small Thread Control Block (TCB) are new. On Linux, a thread is just a `clone()` call with `CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND`. From the kernel's perspective, threads and processes are both "tasks" — the differences are in what they share.

> **🏭 Industry Note — Other thread libraries you may encounter:**
> - **POSIX threads (`pthreads`)** — the underlying Linux/Unix primitive. On most platforms, `std::thread` is implemented on top of pthreads (which is why you need `-pthread` to link).
> - **Windows threads (`CreateThread`)** — the Windows native equivalent.
> - **Intel TBB (oneTBB)** — task-based parallelism with work-stealing; `parallel_for`, `parallel_reduce`, pipelines.
> - **OpenMP** — pragma-based parallelism (`#pragma omp parallel for`) for scientific code.
> - **Boost.Thread** — predates `std::thread` and is the source of many of its ideas.
>
> Default to `std::thread`/`std::jthread` for portability. Reach for TBB or OpenMP when you have heavy data-parallel workloads.

## 3. First Thread with `std::thread`
*(Ep. First thread with `std::thread`)*

Since C++11, the standard library exposes the **thread support library** in headers `<thread>`, `<mutex>`, `<atomic>`, `<future>`, `<condition_variable>`, etc.

```cpp
#include <iostream>
#include <thread>

void task(int x) {
    std::cout << "hello from thread, arg = " << x << '\n';
}

int main() {
    std::thread my_thread(task, 100);    // construct → thread starts running immediately
    std::cout << "hello from main thread\n";
    my_thread.join();                    // block main until my_thread finishes
}
```

Compile on Linux:

```bash
g++ -std=c++20 -pthread thread1.cpp -o thread1
```

The `-pthread` flag is critical on Linux — without it, you'll see `undefined reference to pthread_create`. On Windows/MSVC, no extra flag is needed.

### What `join()` does

`my_thread.join()` blocks the **calling** thread (here, `main`) until `my_thread` finishes. After `join()` returns, the thread is no longer joinable.

If you forget to `join()` (or `detach()`) and the `std::thread` destructor runs while the thread is still joinable, **`std::terminate()` is called** and your program aborts. You'll see output like `terminate called without an active exception` followed by a core dump.

```cpp
int main() {
    std::thread t(task, 100);
    // (no join here)
    return 0;   // ⚠️ std::terminate — program aborts
}
```

### Visualizing the fork/join model

```
main thread          worker thread
─────────────         (does not exist yet)
   │
   │  std::thread t(task, 100)
   ├───────────────▶ ─────────────
   │                     │  starts running task()
   │                     │
   │  t.join()           │
   │  (blocks)           │
   ●─────────────────────●  task() returns, thread terminates
   │                     ×
   │  (resumes)
   ▼
```

Threads can either `join()` (caller waits) or `detach()` (caller forgets — thread runs to completion on its own). Detached threads can outlive `main`, which is almost always a bug source; prefer `join()`.

> **⚠️ Pitfall — Threads start executing in their constructor:**
> The instant `std::thread t(f, args...)` runs, the new thread begins. There is no "configure now, launch later" mode. If you need staged startup, pass a `std::promise`/`std::future` or a condition variable into the lambda and have it wait.

> **⚠️ Pitfall — Reference arguments need `std::ref`:**
> `std::thread`'s argument-passing decays references to values by default (it stores copies in the thread object). To pass by reference, wrap in `std::ref(x)` or `std::cref(x)`:
> ```cpp
> int counter = 0;
> std::thread t(increment, std::ref(counter));   // increment(int&)
> ```
> Without `std::ref`, you'd get a compile error.

> **🔬 Under the Hood — `pthread_create` and the C++ ABI:**
> `std::thread`'s constructor allocates a heap object holding the callable and its arguments, then calls `pthread_create` (on POSIX) with a trampoline function that invokes the callable and frees the heap object on return. That's why you can pass a lambda or `std::bind` — the standard library handles the type erasure for you.

## 4. Passing Callables: Function Pointers, Functors, Lambdas
*(Ep. `std::thread` with a lambda in modern C++)*

`std::thread` accepts anything **callable**: a function pointer, a functor (a class with `operator()`), or a lambda. Inline lambdas are usually the cleanest:

```cpp
#include <iostream>
#include <thread>

int main() {
    auto lambda = [](int x) {
        std::cout << "hello from thread, arg = " << x << '\n';
    };

    std::thread t(lambda, 100);
    t.join();
}
```

You can capture local state into the lambda — this is often how you pass *richer* arguments than a simple parameter list:

```cpp
int main() {
    std::vector<int> data = {1, 2, 3, 4};
    int multiplier = 10;

    std::thread t([data, multiplier]() {     // capture by value (copies)
        for (int x : data) std::cout << x * multiplier << ' ';
    });

    t.join();
}
```

### Capture by value vs by reference

| Capture | Lifetime risk | When to use |
|---------|---------------|-------------|
| `[x]`  / `[=]` (by value) | Safe — the lambda owns a copy. | Small/cheap-to-copy data; whenever the thread might outlive the local. |
| `[&x]` / `[&]` (by reference) | **Dangerous** — if the captured variable goes out of scope before the thread finishes, you have a dangling reference. | Only when you're certain the variable outlives the thread (e.g., it's in `main`'s stack and you `join` before returning). |

```cpp
// ⚠️ Dangerous pattern
std::thread spawn_unsafe() {
    int local = 42;
    return std::thread([&local] {        // captures by reference
        std::this_thread::sleep_for(std::chrono::seconds(1));
        std::cout << local << '\n';      // 'local' is gone by now → UB
    });
}
```

### `std::thread` is non-copyable

Looking at `std::thread` on cppreference, the copy constructor is `= delete`. Conceptually, copying a thread doesn't mean anything — a thread is a unique resource. You can `std::move` a thread (transferring ownership to another `std::thread` object), but you can't copy it. That's why threads in containers require `emplace_back`/`push_back` with rvalues:

```cpp
std::vector<std::thread> ts;
ts.push_back(std::thread(task, 1));      // moves the temporary
// ts.push_back(t);                       // ❌ copy — won't compile
ts.push_back(std::move(t));               // ✅ explicit move
```

> **🎯 Mental Model — Lambdas are functors in disguise:**
> Every lambda is, after compilation, a class with `operator()` and a hidden state struct holding its captures. `std::thread` is just constructing an instance of that class and invoking `()` on the new thread. Nothing magical.

## 5. Launching Many Threads
*(Ep. Launching multiple `std::thread`)*

To run the same work on many threads, store them in a `std::vector<std::thread>`. Beware the **subtle pitfall** of joining inside the launch loop:

```cpp
// ❌ Wrong — sequential despite using threads
for (int i = 0; i < 10; ++i) {
    std::thread t([i] { /* work */ });
    t.join();        // waits for THIS thread before launching the next
}
```

Each iteration launches a thread, immediately blocks on it, then launches the next. Effectively single-threaded.

The fix is **two passes**: launch all the threads first, then join all of them.

```cpp
#include <iostream>
#include <thread>
#include <vector>

int main() {
    std::vector<std::thread> threads;
    threads.reserve(10);

    for (int i = 0; i < 10; ++i) {
        threads.emplace_back([i] {
            std::cout << "thread " << std::this_thread::get_id()
                      << " arg " << i << '\n';
        });
    }

    for (auto& t : threads) t.join();
}
```

A few details worth absorbing:
- `std::this_thread::get_id()` returns a `std::thread::id`, a printable opaque type.
- The output will look **interleaved** ("hello fhellrom o ftrom hreathd 1\n…"). That's because `std::cout` itself is shared state — multiple threads writing concurrently produce torn output. The mutex chapters (§8 onwards) fix this.
- `threads.reserve(10)` avoids reallocations during `emplace_back`. Reallocation moves the `std::thread` objects, which is well-defined but pointless work to skip.

> **🎯 Mental Model — "Fan out, fan in":**
> A common parallel pattern: launch *N* workers (fan out), wait for all to finish (fan in), then continue. That's what the two-loop structure expresses. Higher-level libraries (TBB, OpenMP, `std::for_each` with `std::execution::par`) bundle this into one call.

> **🏭 Industry Note — Don't launch threads per-task:**
> Spawning a `std::thread` takes microseconds at minimum (stack allocation, kernel call). For short tasks, that overhead dominates. Real systems use a **thread pool**: spin up *N* threads once, hand them work via a thread-safe queue, reuse them forever. There's no `std::thread_pool` in the standard yet (proposed for C++26), but it's available via TBB, `folly::CPUThreadPoolExecutor`, Asio, or your own ~50 lines of code on top of `std::thread` + `std::condition_variable`.

## 6. `std::jthread` — RAII Threads (C++20)
*(Ep. `jthread` `std::jthread` in C++20)*

C++20 adds `std::jthread` (the "j" stands for "joining"). It's `std::thread` with one critical upgrade: **its destructor joins automatically**.

```cpp
#include <iostream>
#include <thread>

int main() {
    std::jthread t([] {
        std::cout << "jthread doing work\n";
    });
    // No explicit .join(). Destructor joins when t goes out of scope.
}
```

Look at the destructor on cppreference: if the thread is `joinable`, it calls `request_stop()` (see below) and then `join()`. That's RAII applied to threads — same principle as `std::lock_guard` for mutexes or `std::unique_ptr` for memory.

### Cooperative cancellation: `std::stop_token`

`std::jthread` also brings a **cancellation protocol**. The thread receives a `std::stop_token` as its first argument and can poll `stop_requested()`:

```cpp
#include <thread>
#include <chrono>
#include <iostream>

int main() {
    std::jthread worker([](std::stop_token stoken) {
        while (!stoken.stop_requested()) {
            std::cout << "tick\n";
            std::this_thread::sleep_for(std::chrono::milliseconds(200));
        }
        std::cout << "stopping cleanly\n";
    });

    std::this_thread::sleep_for(std::chrono::seconds(1));
    worker.request_stop();        // also called automatically by ~jthread
}
```

This solves the "how do I cleanly tell a thread to exit" problem that plagued C++11/14/17 code (where you'd hand-roll an `std::atomic<bool> stop_flag`).

> **🎯 Mental Model — `jthread` is to `thread` what `unique_ptr` is to `new`:**
> Both replace "remember to call cleanup" with "the destructor does it." On C++20 toolchains, treat `std::jthread` as the default and reach for `std::thread` only when you have a specific reason (e.g., a detach pattern).

> **⚠️ Pitfall — `request_stop` is cooperative:**
> There is no `std::jthread::kill()` or "force terminate." The thread must *opt in* by checking the stop token. If your worker is stuck inside a blocking syscall or a busy loop without checks, `request_stop` does nothing. Design long-running loops to poll the token regularly.

---

# Part II — Shared State and Mutual Exclusion

## 7. Shared State and Data Races
*(Ep. `std::mutex` and preventing data races)*

The point of threads is to share data. The danger is exactly the same.

```cpp
// ❌ Classic data race
static int shared_value = 0;

void increment() {
    for (int i = 0; i < 10'000; ++i) {
        shared_value = shared_value + 1;   // read–modify–write
    }
}

int main() {
    std::vector<std::thread> ts;
    for (int i = 0; i < 100; ++i) ts.emplace_back(increment);
    for (auto& t : ts) t.join();
    std::cout << shared_value << '\n';      // expected 1'000'000 — almost certainly not
}
```

Run it: you'll see different numbers every time, all *less* than 1,000,000.

### Why this happens

`shared_value = shared_value + 1` looks atomic in source but isn't. The compiler emits something like:

```asm
mov eax, [shared_value]    ; load
add eax, 1                 ; increment
mov [shared_value], eax    ; store
```

Two threads interleave at the instruction level:

```
Thread A                Thread B
load shared_value (=42)
                        load shared_value (=42)
add 1 (eax=43)
                        add 1 (eax=43)
store (shared_value=43)
                        store (shared_value=43)
```

Both threads thought they were incrementing, but only one increment "won." The C++ standard calls this a **data race** and says the program's behavior is **undefined** — not "produces a wrong number" but "anything can happen, including crashes or torn values that don't correspond to any interleaving."

### Formal definition

A **data race** occurs when:
1. Two or more threads access the same memory location.
2. At least one access is a write.
3. The accesses are not ordered by a happens-before relationship (no synchronization between them).

If all three hold, it's UB. The fix is to *establish* the happens-before relationship — with a mutex, an atomic, or some other synchronization primitive.

> **🔬 Under the Hood — Why "undefined" not "wrong":**
> Modern compilers and CPUs reorder reads/writes aggressively for performance. The compiler may hoist a load out of a loop, the CPU may execute stores out of order, caches may not be coherent across cores until forced. With proper synchronization, the standard guarantees a sane memory model. Without it, the compiler is allowed to assume no race exists — and may optimize accordingly. Hence "anything can happen."

## 8. `std::mutex` and Critical Sections
*(Ep. `std::mutex` and preventing data races)*

**Mutex** = *mutual exclusion*. A `std::mutex` is a primitive that lets exactly one thread at a time hold it. Other threads attempting to `lock()` it block until the holder calls `unlock()`. The protected region of code is called a **critical section**.

The analogy: one key, one door. Whoever has the key can be in the room; everybody else waits in line. When you leave, you give the key to the next person.

```cpp
#include <mutex>
#include <thread>
#include <vector>
#include <iostream>

static int shared_value = 0;
static std::mutex g_lock;

void increment() {
    for (int i = 0; i < 10'000; ++i) {
        g_lock.lock();
        shared_value = shared_value + 1;     // critical section
        g_lock.unlock();
    }
}

int main() {
    std::vector<std::thread> ts;
    for (int i = 0; i < 100; ++i) ts.emplace_back(increment);
    for (auto& t : ts) t.join();
    std::cout << shared_value << '\n';        // 1'000'000 every time
}
```

Now the read-modify-write is **atomic with respect to other threads**: no other thread can be inside the critical section at the same time.

### `lock()` vs `try_lock()` vs `unlock()`

| Operation | Blocks? | What it does |
|-----------|---------|--------------|
| `m.lock()` | Yes | Acquires the mutex, waiting indefinitely. |
| `m.try_lock()` | No | Returns `true` if acquired, `false` otherwise. |
| `m.unlock()` | No | Releases the mutex. Calling unlock on a mutex you don't hold is UB. |

### Keep critical sections small

Locks serialize execution. Anything inside the critical section runs single-threaded. Two rules:
1. **Hold the lock for the minimum time possible.** Move expensive work (logging, I/O, computation) out of the critical section if it doesn't touch the shared data.
2. **Don't call user code or external libraries while holding a lock** unless you've audited what they do — they might lock another mutex of yours and deadlock you.

```cpp
// ❌ Bad — heavy work inside the lock
g_lock.lock();
auto computed = expensive_pure_function(local_input);
shared_value = computed;
g_lock.unlock();

// ✅ Better — compute outside, only assign inside
auto computed = expensive_pure_function(local_input);
g_lock.lock();
shared_value = computed;
g_lock.unlock();
```

### Other mutex types

| Type | Purpose |
|------|---------|
| `std::mutex` | Plain mutual exclusion. |
| `std::recursive_mutex` | Can be locked multiple times by the *same* thread (each `lock` needs a matching `unlock`). Use sparingly — usually a code-smell. |
| `std::timed_mutex` / `std::recursive_timed_mutex` | `try_lock_for(duration)`, `try_lock_until(time_point)`. |
| `std::shared_mutex` (C++17) | Multiple readers, one writer. Use with `std::shared_lock` for readers, `std::unique_lock` for writers. |

> **🎯 Mental Model — A mutex is a binary semaphore:**
> If you've seen semaphores elsewhere, `std::mutex` is the special case where the counter is 0 or 1. C++20 added `std::counting_semaphore<N>` and `std::binary_semaphore` for the general case.

> **🔬 Under the Hood — How `std::mutex::lock()` works:**
> On most implementations it tries a quick atomic compare-exchange first (the *uncontended fast path*, often called a "spin"). If that fails, it falls back to a **futex** syscall on Linux (`SYS_futex` with `FUTEX_WAIT`), which parks the thread in the kernel until another thread issues `FUTEX_WAKE` from `unlock()`. The fast path is sub-nanosecond when uncontended; the slow path costs microseconds. Hence "keep critical sections small" — under contention, every lock is a kernel trip.

## 9. `std::lock_guard` — RAII for Locks
*(Ep. Preventing deadlock with `std::lock_guard`)*

Hand-pairing `lock()` / `unlock()` is brittle. What if an exception is thrown inside the critical section? What if an early `return` skips the `unlock`? The mutex stays locked forever — every other thread waiting on it blocks forever. That's a deadlock.

```cpp
// ❌ Brittle — unlock skipped on exception
g_lock.lock();
do_something_that_might_throw();
g_lock.unlock();              // never executed if throw happens
```

You could `try { ... } catch (...) { g_lock.unlock(); throw; }` — but that pattern doesn't compose, and you'll forget eventually. The C++ way is **RAII**: wrap the lock in an object whose destructor unlocks.

```cpp
#include <mutex>

std::mutex g_lock;

void safe_increment() {
    std::lock_guard<std::mutex> lock(g_lock);   // locks in constructor
    shared_value++;
    // lock's destructor calls g_lock.unlock() — even on exception, even on early return
}
```

`std::lock_guard` is non-copyable, non-movable, and has exactly one job: hold a lock for its lifetime. C++17 lets you drop the template argument thanks to CTAD: `std::lock_guard lock(g_lock);`.

### `std::scoped_lock` (C++17)

`std::scoped_lock` is `std::lock_guard`'s more powerful sibling. It can lock **multiple mutexes at once** using a deadlock-avoidance algorithm:

```cpp
std::mutex a, b;
// ...
std::scoped_lock lock(a, b);      // acquires both, in a deadlock-safe order
```

Prefer `std::scoped_lock` over `std::lock_guard` when you need to hold more than one mutex; for the single-mutex case either works (and `scoped_lock` is the C++17 default in many style guides).

### Lock hierarchy summary

| Type | When to use |
|------|-------------|
| `std::lock_guard` | Single mutex, simplest case, lifetime scope-bound. |
| `std::scoped_lock` (C++17) | One or more mutexes; default for new code in C++17+. |
| `std::unique_lock` | Need to unlock/re-lock manually, or use with a `condition_variable` (§12). More flexible, slightly more overhead. |
| `std::shared_lock` (C++17) | Reader side of a `std::shared_mutex`. |

> **🎯 Mental Model — RAII is the entire C++ resource discipline:**
> Once you've internalized "the destructor cleans up," every C++ resource follows the same pattern. `std::lock_guard` to mutexes is what `std::unique_ptr` is to `new`, what `std::fstream` is to `fopen`, what `std::jthread` is to `std::thread`. Always.

> **⚠️ Pitfall — Don't pass a *temporary* mutex to `lock_guard`:**
> ```cpp
> std::lock_guard{std::mutex{}};     // useless — locks and immediately unlocks a temporary
> ```
> You need a long-lived mutex object that all threads share.

## 10. `try_lock` — Non-Blocking Acquisition
*(Ep. Using a `try_lock`)*

Sometimes you don't want to wait. `try_lock()` attempts to acquire the mutex; if another thread already holds it, it returns `false` immediately instead of blocking.

```cpp
#include <mutex>
#include <iostream>

std::mutex g_lock;

void job1() {
    if (g_lock.try_lock()) {
        std::cout << "job 1 executed\n";
        g_lock.unlock();
    }
    // else: skip — someone else has it
}
```

### The real-world analogy

You're walking to a store. There's an ATM and someone is using it.
- `lock()` = wait in line until the ATM is free. (Watch your watch the whole time.)
- `try_lock()` = "they're using it — I'll grab my groceries and come back later."

### When to reach for `try_lock`

- **Producer/consumer with fallback work:** if a queue is locked, do *something else* useful instead of blocking.
- **Avoiding priority inversion:** a real-time thread can `try_lock` and reschedule itself if the lock is held by a lower-priority thread.
- **Health checks / debug paths:** "did I deadlock?" — try to lock and skip the operation if you can't.
- **Optimistic algorithms:** attempt a fast path; if contended, fall back to slow path.

### `try_lock` with RAII via `std::adopt_lock`

The bare `try_lock` form on the previous page leaks the lock if an exception fires before `unlock()`. The RAII fix uses `std::lock_guard` with `std::adopt_lock`:

```cpp
if (g_lock.try_lock()) {
    std::lock_guard<std::mutex> lock(g_lock, std::adopt_lock);
    // critical section — lock_guard now owns the lock and will unlock on exit
}
```

`std::adopt_lock` tells the guard "the mutex is already locked; don't lock it again, but do unlock it when I'm destroyed." There's also `std::defer_lock` (don't lock yet — useful with `std::unique_lock`).

> **⚠️ Pitfall — `try_lock` can spuriously fail:**
> The standard allows `try_lock` to return `false` even when the mutex is currently unlocked. This is rare in practice on most implementations but legal. Code that requires "definitely got the lock or definitely didn't" should not rely on `try_lock` for correctness — only as an optimization.

> **🎯 Mental Model — Nested `if/else` on `try_lock` is a smell:**
> If you find yourself writing `if (try_lock) { ... } else if (try_lock_other) { ... } else { ... }`, redesign. You're hand-rolling a state machine that probably wants a condition variable, a lock-free queue, or just a single mutex used in a clear order.

## 11. Deadlock and How to Avoid It
*(Ep. Preventing deadlock with `std::lock_guard`)*

**Deadlock** is when one or more threads are blocked forever, each waiting on a resource the others hold.

The two classic causes:
1. **Forgot to unlock** — a thread acquires a lock and never releases it. Every other waiter blocks forever. (The RAII guards in §9 prevent this.)
2. **Lock ordering inversion** — Thread A locks `m1` then waits for `m2`; Thread B locks `m2` then waits for `m1`. Neither can proceed.

```cpp
// ❌ Classic ordering deadlock
std::mutex m1, m2;

void thread_a() {
    std::lock_guard<std::mutex> g1(m1);
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
    std::lock_guard<std::mutex> g2(m2);     // waits for m2
}

void thread_b() {
    std::lock_guard<std::mutex> g2(m2);
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
    std::lock_guard<std::mutex> g1(m1);     // waits for m1
}
// Run both threads → eventual deadlock
```

### The four Coffman conditions

A deadlock requires *all four* of:
1. **Mutual exclusion** — resources are held exclusively.
2. **Hold and wait** — a thread holds one resource while waiting for another.
3. **No preemption** — resources are released voluntarily.
4. **Circular wait** — there exists a cycle in the wait-for graph.

Break any one and you've broken deadlock. Practical strategies:

### Strategy 1 — Consistent lock ordering

Pick a global ordering for all your mutexes (e.g., by memory address, by integer ID, by name). **Always acquire them in that order.** Cycles become impossible.

```cpp
void transfer(Account& from, Account& to, int amount) {
    // Always lock the lower-addressed account first
    auto* first  = std::min(&from, &to, [](auto a, auto b){ return a < b; });
    auto* second = std::max(&from, &to, [](auto a, auto b){ return a < b; });
    std::lock_guard g1(first->mtx);
    std::lock_guard g2(second->mtx);
    // ...
}
```

### Strategy 2 — `std::scoped_lock` / `std::lock`

`std::scoped_lock` (C++17) and the lower-level `std::lock()` (C++11) atomically acquire multiple mutexes in a deadlock-free way. Internally they use a back-off algorithm (try-and-release-and-retry) so no thread holds one lock while waiting on another.

```cpp
void transfer(Account& from, Account& to, int amount) {
    std::scoped_lock lock(from.mtx, to.mtx);    // safe regardless of order
    from.balance -= amount;
    to.balance   += amount;
}
```

### Strategy 3 — Try-lock with timeout/back-off

Use `std::timed_mutex::try_lock_for()` to give up after a deadline; restart the work or escalate the error.

### Strategy 4 — Lock-free data structures

If the structure is simple (a counter, a flag, a single-producer single-consumer queue), use `std::atomic` instead of a mutex. No mutex → no deadlock.

> **🔬 Under the Hood — How `std::lock` avoids deadlock:**
> The standard says only that it must avoid deadlock; it doesn't specify the algorithm. Most implementations use a try-and-back-off loop: lock the first, try-lock the second, on failure unlock the first and retry from a different starting mutex. It's *not* free — under heavy contention you'll see retries.

> **🏭 Industry Note — Detecting deadlocks in practice:**
> - **ThreadSanitizer (TSan)** detects some lock-order inversions even when a real deadlock didn't occur (§16). Run it in CI.
> - **GDB**: when your program hangs, `attach` and `thread apply all bt` — you'll see every thread parked on a mutex.
> - **Custom lock hierarchy**: tools like Abseil's `MutexHierarchical` enforce lock ordering at runtime via assertions in debug builds.

---

# Part III — Higher-Level Synchronization

## 12. Condition Variables and `std::unique_lock`
*(Ep. Condition Variable in Modern C++ and `unique_lock`)*

Mutexes solve "only one thread at a time." But what about "wait until something is true"? Polling with `try_lock` in a busy loop is wasteful — it burns CPU cycles checking and re-checking. We need a way to **park** a thread and have it woken up when work is ready.

That's `std::condition_variable`. It's a signaling primitive used in tandem with a mutex and a boolean (or any predicate). The canonical pattern is **worker/reporter** (or **producer/consumer**):

```cpp
#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>

std::mutex g_lock;
std::condition_variable g_cv;
bool notified = false;
int  result   = 0;

void worker() {
    std::unique_lock<std::mutex> lock(g_lock);
    result   = 42 + 1 + 7;            // compute something
    notified = true;
    std::this_thread::sleep_for(std::chrono::seconds(2));   // simulate work
    std::cout << "work complete\n";
    lock.unlock();
    g_cv.notify_one();                // wake one waiter
}

void reporter() {
    std::unique_lock<std::mutex> lock(g_lock);
    g_cv.wait(lock, []{ return notified; });
    std::cout << "result is " << result << '\n';
}

int main() {
    std::thread t1(reporter);
    std::thread t2(worker);
    t1.join();
    t2.join();
}
```

### What's actually happening

`g_cv.wait(lock, predicate)` does, atomically:
1. Check the predicate. If true, return immediately.
2. Otherwise: **unlock the mutex** and put the thread to sleep.
3. When woken (by `notify_one`/`notify_all` from another thread), **re-lock the mutex**, then re-check the predicate.
4. If the predicate is still false, go back to sleep (this is the **spurious wakeup** rule — `wait` may return for reasons other than `notify`).

The mutex must be locked before calling `wait`, because the predicate inspects shared state. `wait`'s atomic "unlock → sleep" is what prevents the lost-wakeup race: there's no window where the notifier could fire between your predicate check and your sleep.

### Why `std::unique_lock` and not `std::lock_guard`?

`condition_variable::wait()` needs to **unlock and re-lock** the mutex. `lock_guard` doesn't expose `unlock` — it's strictly "lock at construction, unlock at destruction." `unique_lock` is more flexible: you can `unlock()`, `lock()`, transfer ownership, defer locking — and that flexibility is exactly what `wait` requires.

| | `lock_guard` | `scoped_lock` | `unique_lock` |
|---|---|---|---|
| Locks in constructor | ✅ | ✅ | ✅ (configurable) |
| Unlocks in destructor | ✅ | ✅ | ✅ (if still held) |
| Manual `unlock()` / `lock()` | ❌ | ❌ | ✅ |
| Move-constructible | ❌ | ❌ | ✅ |
| Multiple mutexes | ❌ | ✅ | ❌ |
| Use with `condition_variable` | ❌ | ❌ | ✅ |

### `notify_one` vs `notify_all`

- **`notify_one`**: wakes one waiter (implementation chooses which). Cheaper. Use when waiters are interchangeable (e.g., any of several worker threads can pick up the next task).
- **`notify_all`**: wakes all waiters. Use when the state change is relevant to multiple waiters (e.g., "we're shutting down — everyone exit"), or when waiters check distinct predicates against the same condition variable.

### Always use the predicate form of `wait`

There's an older form: `g_cv.wait(lock)` with no predicate. It returns on **any** wake — spurious or real. You must wrap it in a loop:

```cpp
// Equivalent to wait(lock, predicate), but you have to write the loop yourself
while (!notified) g_cv.wait(lock);
```

The predicate-taking form handles the loop for you. Prefer it.

> **🎯 Mental Model — Condition variables are "wait until predicate":**
> Think of it as `wait_until(predicate)`. The mutex is just an implementation detail of "make sure the predicate-check and the sleep are atomic." When you read CV code, mentally collapse it to: "block this thread until *condition* becomes true."

> **⚠️ Pitfall — Spurious wakeups are real:**
> A thread can return from `wait` even when no `notify` was called. The kernel is allowed to do this for performance reasons (e.g., to wake all waiters and let them re-check, simplifying internal data structures). Always re-check the predicate — which the predicate-taking form of `wait` does automatically. Code that assumes "I'm awake → my predicate must be true" is broken.

> **🔬 Under the Hood — Why the "atomic unlock + sleep" matters:**
> Consider the alternative:
> ```cpp
> // ❌ Broken — there's a race window between unlock and sleep
> g_lock.unlock();
> /* race: notifier could fire here */
> sleep_until_notified();
> g_lock.lock();
> ```
> If `notify_one` fires in the comment line, the sleeping thread misses it forever — a **lost wakeup**. `condition_variable::wait` is implemented as an atomic operation on top of futexes/equivalents specifically to close that window.

> **🏭 Industry Note — Producer/consumer skeleton:**
> ```cpp
> std::queue<Task> q;
> std::mutex m;
> std::condition_variable cv;
> bool done = false;
>
> void producer(Task t) {
>     { std::lock_guard l(m); q.push(std::move(t)); }
>     cv.notify_one();
> }
>
> std::optional<Task> consume() {
>     std::unique_lock l(m);
>     cv.wait(l, []{ return !q.empty() || done; });
>     if (q.empty()) return std::nullopt;     // shutdown
>     Task t = std::move(q.front()); q.pop();
>     return t;
> }
> ```
> This pattern is the building block of every thread pool, work-stealing scheduler, and message queue you'll write.

## 13. `std::atomic` — Lock-Free Shared Values
*(Ep. Using `std::atomic` in modern C++ to update a shared value)*

For the simple case of a counter or a flag, a mutex is overkill. `std::atomic<T>` provides **lock-free** thread-safe operations on a single value, using hardware primitives like compare-exchange or fetch-add.

```cpp
#include <atomic>
#include <thread>
#include <vector>
#include <iostream>

std::atomic<int> counter{0};

void increment() {
    for (int i = 0; i < 10'000; ++i) {
        counter++;            // atomic — no race
    }
}

int main() {
    std::vector<std::thread> ts;
    for (int i = 0; i < 100; ++i) ts.emplace_back(increment);
    for (auto& t : ts) t.join();
    std::cout << counter << '\n';      // always 1'000'000
}
```

The mutex version from §8 produces the same answer; this one is faster and shorter.

### What operators are atomic?

Look at `std::atomic` on cppreference. Built-in atomic operators include:

| Operator | Translates to | Atomic? |
|----------|---------------|---------|
| `++a`, `a++` | `fetch_add(1)` | ✅ |
| `--a`, `a--` | `fetch_sub(1)` | ✅ |
| `a += x`, `a -= x` | `fetch_add/sub` | ✅ |
| `a &= x`, `a |= x`, `a ^= x` | `fetch_and/or/xor` | ✅ |
| `a = x` | `store(x)` | ✅ |
| `int v = a` | `load()` | ✅ |

What's **not** atomic, and is in fact a hidden data race:

```cpp
// ❌ Not atomic — two separate operations
counter = counter + 1;
```

The right side reads `counter` (one atomic op), adds 1, and assigns (another atomic op). Between them, another thread can interleave. **Always use the increment operators or `fetch_add`** for read-modify-write.

### `compare_exchange` and lock-free patterns

For the general "read-modify-write" case, `std::atomic` exposes `compare_exchange_weak/strong`:

```cpp
std::atomic<int> a{0};

int expected = a.load();
int desired;
do {
    desired = transform(expected);    // some computation
} while (!a.compare_exchange_weak(expected, desired));
// On failure, expected is updated to a's current value — retry
```

This is the basis of lock-free data structures (queues, stacks, hazard pointers). Getting it right is hard — Anthony Williams' book is the standard reference.

### Atomic of custom types

You can `std::atomic<T>` any **trivially copyable** type — i.e., a plain old struct with no virtuals, no allocations:

```cpp
struct Point { int x, y; };
std::atomic<Point> p;
p.store({1, 2});
```

Whether the implementation actually uses a hardware lock-free operation depends on the size and alignment. Check `p.is_lock_free()` or `std::atomic<Point>::is_always_lock_free`. If `false`, the implementation falls back to a hidden mutex — still correct, but it's not free.

### Memory orders (advanced)

By default, all `std::atomic` operations use **sequential consistency** (`std::memory_order_seq_cst`) — the strongest, easiest-to-reason-about guarantee. Performance-critical code can relax this:

| Order | Guarantee | Use case |
|-------|-----------|----------|
| `memory_order_relaxed` | Atomicity only, no ordering. | Counters where you don't care about visibility ordering. |
| `memory_order_acquire` / `memory_order_release` | Pairs across threads to publish/observe. | The default for hand-rolled lock-free producer/consumer. |
| `memory_order_acq_rel` | RMW with both. | `compare_exchange` in lock-free code. |
| `memory_order_seq_cst` | Global total order across all sequentially consistent ops. | Default; safe; slightly slower. |

This is its own multi-week topic. The advice for most code is: **stick with the default `seq_cst` until you've profiled and have a specific reason to weaken it.**

> **🎯 Mental Model — Atomic ≠ critical section:**
> A mutex protects an **arbitrary block of code**. An atomic protects **one operation** on **one variable**. If your invariant involves two atomics or two fields of one struct, you need a mutex (or a single `std::atomic<Pair>`). Don't try to assemble correctness from a sequence of relaxed atomics — that's how lock-free bugs are born.

> **🔬 Under the Hood — Hardware primitives:**
> On x86, `counter++` on an `std::atomic<int>` compiles roughly to `lock incl (counter)`. The `lock` prefix asserts the cache line, blocking other cores' accesses until the operation completes. On ARM, atomics use load-linked/store-conditional or LDADD instructions. Either way: ~1 cache-line round-trip, much cheaper than a mutex's syscall slow path.

> **🏭 Industry Note — When to choose atomic vs mutex:**
> - **Atomic** for: counters, statistics, flags ("is shutdown requested?"), single-word state machines.
> - **Mutex** for: multi-field invariants, complex predicates, code that calls into other functions (which may also lock), code paths long enough that microsecond-scale lock cost doesn't matter.
> - **Both**, sometimes: an atomic flag for the fast common path, a mutex behind it for the rare slow path (e.g., the Double-Checked Locking Pattern — beware its history of subtle bugs).

---

# Part IV — Asynchronous Programming

## 14. `std::async` and `std::future` — Tasks, Not Threads
*(Ep. `std::future` and `std::async` in Modern C++)*

`std::async` is a higher-level alternative to `std::thread`: instead of "launch a thread and let me manage it," you say "run this function asynchronously and give me a handle to its result." The handle is a `std::future<T>`.

```cpp
#include <future>
#include <iostream>

int square(int x) { return x * x; }

int main() {
    std::future<int> f = std::async(std::launch::async, square, 12);

    // Do other work while square(12) runs in the background
    std::cout << "main is doing other work...\n";

    int result = f.get();        // blocks until the future is ready
    std::cout << "result is " << result << '\n';
}
```

### What `std::future<T>` is

A `std::future<T>` is a single-use channel from a producer (the async task) to a consumer (whoever calls `.get()`). Operations:

| Operation | Behavior |
|-----------|----------|
| `f.get()` | Blocks until the result is ready, then returns it. Can only be called **once**. |
| `f.wait()` | Blocks until ready, but doesn't consume the result. |
| `f.wait_for(duration)` | Returns a `future_status`: `ready`, `timeout`, or `deferred`. Doesn't block longer than the duration. |
| `f.valid()` | False after `get()` or if default-constructed. |

After `.get()`, the future is empty (`f.valid() == false`). You can `std::move` futures to transfer ownership.

### Launch policies

`std::async`'s first argument is a launch policy:

| Policy | Behavior |
|--------|----------|
| `std::launch::async` | Run on a *new thread*, immediately. (Approximately — implementations are free to use a thread pool.) |
| `std::launch::deferred` | Don't run yet. Run **synchronously, on the calling thread, inside `.get()`**. Effectively lazy evaluation. |
| `std::launch::async | std::launch::deferred` (default) | Implementation chooses. **Avoid relying on this** — behavior varies wildly. |

The default is a notorious portability footgun: on some implementations the task runs on a new thread (parallel speedup), on others it's deferred to `.get()` (no parallelism at all). **Always specify `std::launch::async` explicitly** unless you specifically want deferred semantics.

```cpp
// ❌ Don't do this — behavior is implementation-defined
auto f = std::async(work);

// ✅ Explicit
auto f = std::async(std::launch::async, work);
```

### `std::async` vs `std::thread`

| | `std::async` | `std::thread` |
|---|---|---|
| Returns a result | ✅ via future | ❌ — you handle it yourself |
| Catches exceptions | ✅ rethrown in `get()` | ❌ — uncaught → `terminate()` |
| Cleans up automatically | ✅ at future destruction | ❌ — must `join`/`detach` |
| Lets you control scheduling | Limited (policy) | More direct |
| Maps to a "task" abstraction | ✅ | ❌ |

`std::async` is the higher-level, safer default for "run this function and give me the result." Use `std::thread` (or `std::jthread`) when you genuinely need long-running threads with their own lifecycles.

### Exception propagation

If the async function throws, the exception is captured into the future and rethrown when you call `.get()`:

```cpp
auto f = std::async(std::launch::async, []{ throw std::runtime_error("boom"); return 0; });
try {
    f.get();
} catch (const std::exception& e) {
    std::cerr << e.what() << '\n';     // "boom"
}
```

This is one of the biggest ergonomic wins over `std::thread`.

> **⚠️ Pitfall — Destroying an `async` future blocks:**
> The future returned by `std::async` has a *waiting destructor* — when it goes out of scope, the destructor blocks until the task finishes. This is surprising and breaks the "fire and forget" mental model:
> ```cpp
> std::async(std::launch::async, slow_task);   // returns a temporary future
> // Temporary destroyed at end-of-statement → blocks here!
> ```
> If you need fire-and-forget, hold the future or use `std::thread`/`std::jthread` directly.

> **🎯 Mental Model — Future is a single-shot mailbox:**
> The producer puts a value (or an exception) into it once. The consumer reads from it once. After that, the mailbox is empty. For repeated values, use a queue with a condition variable.

> **🏭 Industry Note — `std::async` is not a great thread pool:**
> The standard doesn't guarantee `std::async` reuses threads — each call may spawn a fresh OS thread. For workloads launching thousands of tasks, prefer a dedicated thread pool (TBB, `folly::Executor`, Asio's `thread_pool`). C++20's `std::executor` proposal aims to standardize this; until adopted, third-party libraries are the way.

## 15. Background Loading with `std::async`
*(Ep. `std::async` in C++ with background thread loading data example)*

A pragmatic use case: **load an asset on a background thread while the main loop keeps running.** Games and GUIs do this constantly — the main thread paints frames or handles input; the background thread reads a file from disk, decodes a texture, or streams data over the network.

```cpp
#include <chrono>
#include <future>
#include <iostream>
#include <thread>

bool buffered_file_loader() {
    int bytes_loaded = 0;
    while (bytes_loaded < 20'000) {
        std::cout << "from the thread: loading file\n";
        std::this_thread::sleep_for(std::chrono::seconds(1));
        bytes_loaded += 1'000;        // simulate 1KB chunks
    }
    return true;
}

int main() {
    auto background = std::async(std::launch::async, buffered_file_loader);

    while (true) {
        std::cout << "main thread is running\n";
        std::this_thread::sleep_for(std::chrono::milliseconds(50));

        // Poll the future without blocking the main loop
        auto status = background.wait_for(std::chrono::milliseconds(1));
        if (status == std::future_status::ready) {
            std::cout << "our data is ready\n";
            break;
        }
    }

    std::cout << "program complete\n";
}
```

The key technique: **`wait_for` with a tiny duration to poll, not block.** Each main-loop iteration:
1. Does its normal work (here, just print + sleep — in a real game, render a frame, process input).
2. Checks if the background task is done.
3. Continues or breaks accordingly.

### Polling vs blocking — when to use which

| Pattern | When to use |
|---------|-------------|
| `f.get()` (blocking) | The main thread can't proceed without the result, and you don't care about UI responsiveness. |
| `f.wait_for(0)` (polling) | Main thread has independent work to do. Poll between iterations. |
| `f.wait()` (blocking without consuming) | You want to *know* it's done so you can re-check a shared flag, but call `get()` later. |

### Common background-loading patterns

- **Asset streaming**: load the next level's assets while the player finishes the current one.
- **Database/network prefetch**: fire off the query as soon as you know you'll need it; consume the future when the UI gets to it.
- **Two-stage rendering**: compute path on background thread, draw on main thread.
- **Lazy initialization**: `std::async(std::launch::deferred, expensive_init)` to compute only when first accessed.

> **🎯 Mental Model — `async` is C++'s answer to JavaScript's promises:**
> If you've used `Promise.then` or `async/await`, `std::future`'s blocking `.get()` is the *opposite end* of the same idea — JS futures are observed via callbacks, C++ futures are observed by polling or waiting. C++20 coroutines and library extensions (`std::experimental::future::then`) close the gap; for now, polling is the standard-library answer.

> **🏭 Industry Note — Don't `wait_for(very_small_duration)` in a tight loop:**
> The example uses 1 millisecond, which is fine for a 60 FPS game (16 ms per frame). In a fast inner loop, this becomes a busy poll. If you're polling more than once per frame, you probably want a condition variable or an event-driven design instead.

---

# Part V — Tooling and Applied Patterns

## 16. ThreadSanitizer (TSan) — Catching Data Races
*(Ep. Example of GCC and Clang thread sanitizer to detect data race)*

Data races are notoriously hard to reproduce. They depend on scheduler interleaving, CPU load, and timing — a race that fires once in a thousand runs locally may fire 90% of the time on a busy CI machine. Stress testing without a tool catches only the gross ones.

**ThreadSanitizer (TSan)** is the right tool. It's built into Clang and GCC. You add a flag at compile time and run normally; TSan instruments every memory access and detects races at runtime.

```bash
g++ -std=c++20 -g -O1 -pthread -fsanitize=thread data_race.cpp -o data_race
./data_race
```

(Use `-O1`, not `-O0` — TSan needs some optimization for accurate stack traces, and not `-O2`+ because optimizations can elide the very accesses you want to monitor.)

The output looks like:

```
WARNING: ThreadSanitizer: data race (pid=12345)
  Write of size 4 at 0x55c... by thread T2:
    #0 increment() data_race.cpp:8
  Previous write of size 4 at 0x55c... by thread T1:
    #0 increment() data_race.cpp:8
  Location is global 'shared_value' of size 4 at 0x55c... (data_race+0x000...)
```

You get:
- The two threads involved (`T1`, `T2`).
- Each access's stack trace.
- The variable name and address.
- Whether it was a read or a write.

### What TSan catches

| Category | Caught? |
|----------|---------|
| Data races (concurrent unordered read/write) | ✅ |
| Lock-order inversions (potential deadlocks) | ✅ |
| Use of destroyed mutex | ✅ |
| `std::atomic` misuse (mixing relaxed/seq_cst incorrectly) | Partially |
| Iterator invalidation across threads | ✅ (via the underlying memory race) |
| Logic bugs (wrong but race-free code) | ❌ — that's not its job |

### Cost

TSan slows your program down ~5–15× and increases memory ~5–10×. That's fine for tests, **not** for production. The typical workflow:
- **CI**: run the full test suite under TSan on every PR.
- **Local debugging**: compile a single binary with TSan when investigating a suspected race.
- **Production**: don't ship the TSan binary; ship the optimized one.

### Other sanitizers worth knowing

| Sanitizer | Flag | Catches |
|-----------|------|---------|
| **AddressSanitizer (ASan)** | `-fsanitize=address` | use-after-free, buffer overflow, double-free, leaks |
| **UndefinedBehaviorSanitizer (UBSan)** | `-fsanitize=undefined` | signed overflow, null deref, misaligned access |
| **MemorySanitizer (MSan)** | `-fsanitize=memory` (Clang only) | uninitialized reads |
| **ThreadSanitizer (TSan)** | `-fsanitize=thread` | data races, deadlocks |

You can usually combine `-fsanitize=address,undefined`. TSan and ASan are mutually exclusive (both rewrite memory access patterns).

> **🏭 Industry Note — Trust TSan:**
> A TSan report is a real bug. The program may "work fine" today — but the C++ standard says undefined behavior, the compiler can and will exploit that license eventually (especially across optimizer versions), and the race will eventually fire in production at the worst possible moment. **Treat every TSan warning as P1.** Never `#pragma` it away.

> **🔬 Under the Hood — How TSan detects races:**
> TSan maintains a shadow memory layout: for each byte of program memory, ~8 bytes of "vector clock" tracking which threads have accessed it and when (in terms of synchronization order). On every load/store, instrumentation compares the access's vector clock against the shadow. A pair of accesses where neither is ordered before the other, and at least one is a write, is reported. The cost is real but the false-positive rate is essentially zero.

## 17. Data Parallelism — A Multithreaded SFML Example
*(Ep. Example Data Parallel C++ Program using multiple threads in SFML)*

The synchronization primitives we've covered protect *shared* data. The fastest concurrent code avoids sharing in the first place. That's **data parallelism**: partition the data, give each thread its own chunk, no locks needed.

The classic example is image processing: split a 4K image into 4 quadrants, process each quadrant on a separate thread, combine. Mike's demonstration uses SFML to render a 2×2 grid of circles, each driven by its own worker thread.

```cpp
// Conceptual sketch — the SFML drawing code is omitted for brevity.
#include <atomic>
#include <chrono>
#include <random>
#include <thread>
#include <vector>

constexpr int GRID_W = 2;
constexpr int GRID_H = 2;
std::vector<int> grid(GRID_W * GRID_H, 0);    // each cell holds a color enum
std::atomic<bool> running{true};

void update_grid(int x, int y) {
    std::mt19937 rng{std::random_device{}()};
    while (running.load()) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
        grid[y * GRID_W + x] = rng() % 5;     // pick random color
    }
}

int main() {
    std::vector<std::thread> workers;
    for (int y = 0; y < GRID_H; ++y) {
        for (int x = 0; x < GRID_W; ++x) {
            workers.emplace_back(update_grid, x, y);
        }
    }

    // Main loop reads grid and renders — runs at 60+ FPS independent of workers
    while (/* window open */) {
        // render(grid);
        // poll input → if quit: running.store(false); break;
    }

    for (auto& t : workers) t.join();
}
```

### The key question: do we need a lock on `grid`?

The grid is shared across threads, so the instinct is yes. But look at the access pattern:
- Worker for cell `(0,0)` writes to `grid[0]`.
- Worker for cell `(1,0)` writes to `grid[1]`.
- Worker for cell `(0,1)` writes to `grid[2]`.
- Worker for cell `(1,1)` writes to `grid[3]`.

**Each thread writes to a different cell.** No two threads write to the same location. No two threads even read each other's writes within a worker — they're independent computations. That's the data-parallel pattern: **disjoint output regions**.

The main thread reads everything, but reads don't conflict with writes if you accept "may see slightly stale data" as a non-bug (typical for graphics: you'll render the right colors on the next frame). Strictly, the C++ standard says reading and writing the same `int` concurrently is a race, but each cell is independent — so wrap each in `std::atomic<int>` and you're race-free with zero locking overhead.

```cpp
std::vector<std::atomic<int>> grid(GRID_W * GRID_H);   // each cell is atomic
```

### When data parallelism works

- **Image / video processing** — each pixel/tile is independent.
- **Map / filter / reduce** — `transform` over a vector, summing chunks separately.
- **Particle simulations** — particles only interact with neighbors; partition by region.
- **Monte Carlo simulations** — each trial is independent; sum results at the end.
- **Search problems** — split the search space; first thread to find returns.

### When it doesn't

- **Strongly connected data** — graph algorithms, fluid simulation, anything where every element interacts with many others.
- **Variable work per element** — load imbalance kills speedup. Use work-stealing (TBB's `parallel_for` does this) or finer-grained partitioning.

### `std::execution` parallel algorithms (C++17)

For straightforward map/filter/reduce on STL containers, C++17 gives you parallel algorithms directly. No threads to manage:

```cpp
#include <algorithm>
#include <execution>
#include <vector>

std::vector<int> data(1'000'000);
// ...
std::transform(std::execution::par,
               data.begin(), data.end(), data.begin(),
               [](int x){ return x * 2; });
```

Execution policies:

| Policy | Meaning |
|--------|---------|
| `std::execution::seq` | Sequential (default). |
| `std::execution::par` | Parallel, may run on multiple threads. |
| `std::execution::par_unseq` | Parallel + vectorized (SIMD). Most aggressive. |
| `std::execution::unseq` (C++20) | Vectorized only (single thread). |

For data-parallel problems that map onto STL idioms, this is dramatically less code than spawning threads manually.

> **🎯 Mental Model — Share less, lock less, scale more:**
> Locks are a tax on parallelism. Every microsecond inside a critical section is a microsecond your program is single-threaded. The fastest concurrent designs minimize shared state, then minimize the time it's accessed, then optimize the synchronization primitive. In that order.

> **🏭 Industry Note — False sharing:**
> Even when threads write to *different* variables, they can collide if those variables sit on the same **cache line** (typically 64 bytes). Two atomics, two ints, two flags side-by-side in memory: every write invalidates the line on the other core, causing cache-coherency traffic that looks like serialization. The fix is `alignas(std::hardware_destructive_interference_size)` (C++17) on hot fields, or padding to separate them. This is the #1 cause of "I parallelized this and got *slower*."

---

# Part VI — Closing

## 18. Idioms, Pitfalls & Best Practices Cheat Sheet

### Thread lifecycle

- **Default to `std::jthread` in C++20+.** RAII join + stop_token. Use `std::thread` only when you genuinely need to detach or hand off.
- **Never let a joinable `std::thread` go out of scope without `join` or `detach`.** It calls `std::terminate()`.
- **Avoid `detach()`** unless the thread truly outlives anything that could reference it (a logging thread that runs until `_exit`).
- **Capture-by-value in lambdas you pass to threads** unless you control the captured variable's lifetime.
- **Wrap reference arguments in `std::ref` / `std::cref`** — `std::thread` decays references otherwise.

### Synchronization

- **Use RAII locks (`lock_guard`, `scoped_lock`, `unique_lock`).** Never hand-pair `lock()` / `unlock()`.
- **`scoped_lock` for multi-mutex.** Single-mutex case: either `lock_guard` or `scoped_lock`.
- **`unique_lock` only when you need flexibility** — manual unlock/re-lock, or with `condition_variable`.
- **Keep critical sections small.** Move I/O, allocation, and pure computation out of the lock.
- **Acquire mutexes in a consistent global order** to prevent deadlock — or use `std::scoped_lock`.
- **Use the predicate-taking form of `cv.wait`**, never the bare form. Spurious wakeups are real.
- **Match every `wait` with a `notify`.** Forgetting to notify is a silent deadlock.

### Atomics

- **`std::atomic<T>` for single-word shared state** (counters, flags, single pointers).
- **Use `++a` / `--a` / `a.fetch_add(n)`** — `a = a + 1` is a hidden race.
- **Default to `seq_cst` memory order.** Relaxed orders are a performance optimization, not a default.
- **`std::atomic_flag` for the absolute simplest case** (test-and-set, always lock-free).
- **Don't try to build atomicity across multiple atomics.** Use a mutex (or a struct of trivially-copyable members and `std::atomic<Struct>`).

### Asynchronous tasks

- **Always specify `std::launch::async` explicitly** on `std::async`. Don't rely on the default.
- **The `future` returned by `std::async` blocks in its destructor.** Hold it or use `jthread`.
- **`f.wait_for(0)` to poll; `f.get()` to consume.** Each future is single-use.
- **Exceptions propagate through futures.** Wrap `.get()` in `try/catch`.

### Tooling

- **Compile with `-fsanitize=thread` for CI tests.** Treat every report as a real bug.
- **Add `-fsanitize=address,undefined` to debug builds.** Catches memory bugs that race with threading bugs.
- **Compile with `-Wall -Wextra -Wpedantic`** always. `-Wthread-safety` (Clang) catches some lock misuse statically.
- **Stress tests under load.** Some races only fire when scheduler pressure is high — add a `make stress` target that loops the test suite for 10 minutes.

### Pitfalls to avoid

- **Returning `std::thread` from a function without ensuring `join` at the caller.** Use `std::jthread`.
- **Using `std::cout` from many threads without serialization.** Output will be interleaved at the character level. Wrap with a mutex or use `std::osyncstream` (C++20).
- **Storing iterators/pointers into containers shared across threads** — concurrent insertions invalidate them silently.
- **Acquiring a mutex inside a destructor of an object that other threads might still hold pointers to.**
- **Sharing `std::shared_ptr` across threads expecting the *pointee* to be thread-safe.** The control block is — the object isn't.
- **Allocating inside a critical section** when the allocator might lock its own internal mutex. Pre-allocate or use a thread-local arena.
- **Capturing `this` by reference in a lambda spawned on a thread when `*this` might be destroyed.** Capture `weak_from_this()` or `shared_from_this()`.

---

### Industry essentials cheat sheet

#### Code review red flags

| Flag | Why |
|------|-----|
| Bare `lock()` / `unlock()` calls | Should be a RAII guard |
| `std::thread` member in a class without explicit `join`/`detach` in destructor | `std::terminate` waiting to happen — should be `jthread` |
| `std::async` without launch policy | Behavior is implementation-defined |
| `condition_variable::wait(lock)` with no predicate | Spurious wakeup bug |
| Mutex held across a function call to user code | Re-entrancy / deadlock risk |
| `volatile` used for "thread safety" | Wrong — `volatile` is for memory-mapped I/O; use `atomic` |
| Multiple mutexes acquired without `scoped_lock` and no documented ordering | Deadlock |
| `shared_ptr` + raw `new` for a thread's argument | Use `make_shared` for the atomic refcount + alloc combo |
| Polling `future::wait_for(0)` in a tight loop | Busy wait — use a CV or a real event |
| Atomic counter with `relaxed` order used for synchronization | Misuse — relaxed only orders the *value*, not surrounding code |

#### Common-case performance gotchas

| Pattern | Cost | Fix |
|---------|------|-----|
| Mutex around a tiny critical section | Syscall on contention | `std::atomic<T>` if it fits |
| Two atomics on adjacent fields (false sharing) | Cache-line ping-pong | `alignas(64)` to separate |
| `std::shared_ptr` copied across threads in hot path | Atomic refcount ops | Pass by `const T&` or `T*` for borrow |
| Thread spawned per-task in hot path | Microsecond-scale OS overhead per spawn | Thread pool |
| `std::cout` from multiple threads | Implicit lock on the streambuf | `osyncstream` or a single logger thread |
| `notify_all` when one waiter suffices | Thundering herd, all wake and contest the mutex | `notify_one` |
| `std::shared_mutex` with mostly-writes | Worse than `mutex` | Plain `mutex` |
| `std::async` for short tasks | Each call may spawn a thread | Batch into a single task or use a pool |
| Atomic with `seq_cst` in a counter-only path | Memory barriers on every op | `fetch_add(1, std::memory_order_relaxed)` *if* you've verified relaxed is correct |

#### Testing patterns for concurrent code

- **Stress tests** — loop the suspect interaction tens of thousands of times under load. Many races only fire under scheduler pressure.
- **TSan in CI** — every PR, every test. Catches races deterministically that stress tests catch flakily.
- **Deterministic schedulers** — tools like `rr` (replay debugging), Concuerror, or Coyote let you exhaust thread interleavings systematically.
- **Property tests** — generate random inputs and operations across threads; assert invariants survive.
- **Fault injection** — `std::this_thread::yield()` at random points in tests to surface scheduler-sensitive bugs.

#### Logging / observability for concurrent systems

- **Per-thread log buffers** that flush periodically — avoids the global-log-mutex contention.
- **Thread IDs in every log line** (`std::this_thread::get_id()` or a friendly name set via OS API).
- **Lock-free MPMC queues** (moodycamel::ConcurrentQueue, folly::MPMCQueue) for log shipping from worker threads to an I/O thread.
- **Wait/contention metrics** — Linux `perf lock`, lock-profilers, or self-instrumented histograms of `lock_guard` hold times.
- **Stuck-thread detection** — a watchdog thread that periodically checks whether worker threads have made progress; dump stacks if not.

#### When to break the rules

The defaults in this guide are good defaults — not absolutes. **Senior judgment** is knowing when:
- **Use `std::thread` over `std::jthread`** when you have an old codebase and the cost of converting is high. New code: jthread.
- **Use `detach()`** for a true daemon thread that should run for the whole process lifetime (e.g., a metrics flusher).
- **Skip the predicate on `cv.wait`** if you've genuinely proven (with comments) that the wake can only come from the right notifier and you accept spurious-wakeup risk. (You probably haven't.)
- **Use relaxed memory order** when you've measured the contention cost and verified the algorithm tolerates the weaker guarantee. Document the proof.
- **Roll your own lock-free structure** when a profiling-proven hot path needs it and a well-known design (e.g., MPMC ring buffer) fits. Otherwise: use a library.
- **Use `volatile`** for memory-mapped device registers — never for thread-shared variables.

The reason every rule has exceptions: concurrent programming is the part of C++ where the language gives you the sharpest tools and the bluntest defaults. Knowing the default and knowing when to deviate is the senior-engineer skill.

## 19. Resources & Further Reading

### Books

- **Anthony Williams, *C++ Concurrency in Action*, 2nd ed.** — the canonical book. Threads, atomics, lock-free data structures, parallel algorithms. Updated for C++17/20.
- **Paul McKenney, *Is Parallel Programming Hard, And, If So, What Can You Do About It?*** — free PDF online. Deep dive into memory models, RCU, and hardware-level concurrency. Linux kernel author's perspective.
- **Maurice Herlihy & Nir Shavit, *The Art of Multiprocessor Programming*, 2nd ed.** — academic but accessible. Best resource for lock-free algorithm design.
- **Scott Meyers, *Effective Modern C++*, items 35–42** — `std::thread`, `std::async`, futures, atomics. Concise practical advice.
- **Daniel Anderson, *Concurrent Data Structures in C++* (free online)** — patterns for thread-safe stacks, queues, hash maps.

### Standard reference

- **[cppreference — Thread support library](https://en.cppreference.com/w/cpp/thread)** — exhaustive reference for `<thread>`, `<mutex>`, `<atomic>`, `<future>`, `<condition_variable>`, `<barrier>` (C++20), `<latch>` (C++20), `<semaphore>` (C++20).
- **[cppreference — Atomic operations library](https://en.cppreference.com/w/cpp/atomic)** — every atomic type, memory order, and free function.
- **[Preshing on Programming](https://preshing.com/)** — Jeff Preshing's blog. Best free explanations of memory ordering, lock-free patterns, and the C++11 memory model.

### Tools

- **ThreadSanitizer (Clang/GCC)** — `-fsanitize=thread`. Catches data races and lock-order inversions.
- **Helgrind (Valgrind)** — older race detector. Slower than TSan but works on optimized binaries.
- **`rr`** — record-and-replay debugger for Linux. Catches non-deterministic bugs by replaying the exact thread interleaving.
- **`perf lock`** — Linux performance counters for mutex contention.
- **`gdb` `thread apply all bt`** — when stuck, dump every thread's stack to find deadlocks.
- **Tracy Profiler** — frame-by-frame, per-thread profiling. Excellent for game/real-time work.
- **Intel VTune** — heavyweight profiler with great threading visualizations.

### Libraries beyond the standard

- **Intel oneTBB** — task-based parallelism with work-stealing. `parallel_for`, pipelines, concurrent containers.
- **OpenMP** — pragma-based parallelism. Great for "annotate the loop" workflows.
- **Asio (standalone or via Boost)** — async I/O, executors, coroutines (C++20). De facto standard for networking.
- **folly (Facebook)** — `folly::Executor`, `folly::Future` (richer than `std::future`), MPMCQueue.
- **moodycamel::ConcurrentQueue** — header-only, very fast lock-free queue.
- **libcds** — concurrent data structures library (Michael-Scott queues, hazard pointers).
- **HPX** — distributed C++ parallelism — futures across machines, not just threads.

### Style guides and standards

- **[C++ Core Guidelines — Concurrency section](https://isocpp.org/wiki/faq/cpp-core-guidelines#S-concurrency)** — Stroustrup and Sutter's rules for safe concurrent C++.
- **Google C++ Style Guide — Concurrency** — opinionated but informative.

### Talks worth your time

- **Herb Sutter — "atomic<> Weapons"** (CppCon 2012) — the foundational two-part talk on the C++11 memory model.
- **Fedor Pikus — "Live Lock-Free or Deadlock"** (CppCon 2017) — practical lock-free programming.
- **Bryce Adelstein Lelbach — "The C++20 Synchronization Library"** (CppCon 2020) — `latch`, `barrier`, `semaphore`, `jthread`.
- **Hans Boehm — "Using Weakly Ordered C++ Atomics Correctly"** (CppCon 2016) — when to drop seq_cst.

### Mike Shah's other content

- **Software Design / Design Patterns playlist** — broader concurrency patterns and architecture.
- **Software Engineering with C++ playlist** — build systems, CMake, tooling, larger-scale concerns.

---

### Learning roadmap (60-day plan)

**Days 1–10 — Thread basics (Part I)**
- Write Hello-World threads. Then convert to lambdas, vectors of threads, `jthread`.
- Build a parallel `count_primes` that splits a range across N threads and sums the results. Time it; verify the speedup matches your core count.
- Read every `std::thread` and `std::jthread` method on cppreference.

**Days 11–25 — Mutual exclusion (Part II)**
- Re-implement the counter race in §7 — verify the wrong answer.
- Fix it three ways: `lock_guard`, `scoped_lock`, `std::atomic`. Benchmark each. Note the order of magnitude differences.
- Build a thread-safe bounded queue: vector + mutex + two condition variables (`not_full`, `not_empty`).
- Deliberately introduce a lock-order inversion between two mutexes. Reproduce the deadlock; fix it with `scoped_lock`.

**Days 26–40 — Higher-level primitives (Part III + IV)**
- Build a tiny thread pool: N worker threads + a single `std::queue<std::function<void()>>` + condition variable. Submit tasks via `enqueue(task)`.
- Replace the queue's mutex with an `std::atomic` ring buffer (SPSC first, then MPSC).
- Convert your thread pool's API to return `std::future<T>` from `enqueue`.
- Build the background-loader example end-to-end in your toy thread pool.

**Days 41–55 — Production patterns**
- Run TSan over every concurrent test you've written. Find at least one race you didn't expect.
- Profile contention with `perf lock` on Linux (or Tracy on any platform).
- Add false-sharing pad to a hot atomic; measure the change.
- Write a property test that exercises your bounded queue from N producers and M consumers; assert invariants (no lost items, no duplicates).

**Days 56–60 — Choose your specialization**
- **Networking** — start on Asio's `awaitable<T>` and coroutines.
- **Real-time / games** — Tracy + Tasking systems (TBB, EnTT).
- **Lock-free** — Michael-Scott queue, hazard pointers, RCU.
- **Distributed** — HPX or gRPC C++ with executor integration.

### Industry "what to learn next" by role

| Role | After this guide, focus on |
|------|----------------------------|
| **Backend / services** | Asio coroutines, executors, lock-free queues, request-tracing across threads |
| **Game dev** | Task graphs (Taskflow, EnTT), Tracy profiler, false-sharing analysis, data-oriented design |
| **HFT / finance** | Lock-free MPSC/MPMC queues, branch prediction, cache-line awareness, RDMA |
| **Embedded / RT** | Real-time scheduling, lock-free data structures, deterministic memory, priority inversion |
| **Systems / kernel** | Memory models, RCU, hazard pointers, atomic stamped pointers |
| **ML / HPC** | OpenMP/MPI, CUDA streams, NUMA-aware allocation, parallel STL `<execution>` |

### Final advice from senior engineers

- **Most concurrency bugs are design bugs.** If a piece of code is hard to lock correctly, restructure it so less is shared.
- **Measure, then optimize.** Concurrency intuition is bad. Profile contention; profile false sharing; profile context-switch rates. Then fix the hottest one.
- **Lock-free isn't free.** A correctly-written mutex outperforms an incorrectly-written lock-free queue by a wide margin. Don't reach for atomics until you can write the equivalent mutex version in your sleep.
- **Trust the sanitizer.** A TSan report is real. A heisenbug that won't reproduce is real. Defects don't go away because you didn't see them today.
- **Concurrency is composable when synchronization is hidden.** A thread-safe queue, a thread-safe map, a thread-safe ref-counted pointer — each is locally correct and combines without surprises. Spread-out invariants across multiple shared objects are where every nightmare lives.
- **Read other people's lock-free code before writing your own.** Folly, moodycamel, and the Linux kernel's lockless ring buffers are educational gold mines.
- **Write fewer threads, not more.** Most performance wins come from removing synchronization, not adding parallelism. The fastest concurrent code is the code that doesn't need to synchronize at all.
