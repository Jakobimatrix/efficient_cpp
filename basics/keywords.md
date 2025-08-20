# C++ Keywords 

1. **Type deduction and initialization**
2. **Constness and immutability**
3. **Compile-time evaluation**
4. **Optimization hints**
5. **Memory / linkage / lifetime**

---

## 1. Type deduction and initialization

### `auto`

- Compiler deduces type from initializer or return type.
- Preserves `const` and `volatile`, but **does not deduce references by default** (need `auto&`).
- Will not perform type conversion; deduced type is exact.
- Avoid `auto` when the type is not obvious from the initializer (Clean Code principle).
    
- With libraries like **Eigen**, (most)always use `auto` because expressions are _lazy evaluators_ (not actual types).

- [Understanding `auto`](https://www.youtube-nocookie.com/embed/tn69TCMdYbQ?rel=0&start=116) *~9 min.*
- [prefer auto](https://www.youtube-nocookie.com/embed/PJ-byW33-Hs?rel=0&start=169) *~7 min.* 

If you use the Eigen Library, use auto instead of Eigen::Vector/Eigen::Matrix/Eigen::Array. Eigen returns not the actual type but a template expression that the compiler is able to optimize!
```c_cpp
Eigen::Vector3d a, b;
const auto matrix = a.transpose() * b; // result is an expression template, not a Eigen::Matrix3d
return matrix.trace(); // compiler sees only diagonal elements are used.
```

---
### `explicit`

- Prevents _implicit conversions_ for constructors and conversion operators.
- Helps avoid accidental performance costs or bugs due to silent conversions.
- Since C++20, `explicit(bool)` allows conditional explicitness.

```c_cpp
struct A {
    explicit A(int x) {}
};
struct B {
    B(int x) {}
};

A a1 = 1;     // error
A a2(1);      // okay
A a3(1.0);    // error
B a1 = 1;     // okay ?
B a2(1);      // okay
B a3(1.0);    // okay !! but probably not what you wanted -> silent conversation
```

---
## 2. Constness and immutability

### `const` (variable)

- Value cannot change after initialization.
- Still runtime-initialized (unlike `constexpr`).
- **Mark all variables `const` which do not change value throughout their lifetime.**

### `const` (method)

- Guarantees object state is not modified.
- Allows calling on `const` objects.
- **Mark all methods `const` which do not change the object; `Getters` for example.**

### `const` (function)

- This does **not exist** in C++.
- What you probably meant is “functions that don’t modify global state” → that’s **`pure`** (not a C++ keyword, just concept).
## `pure` function
A `pure` function does not use any global state.
**Mark all functions pure which do not use global values.**
This helps the compiler to optimize your code and can be combined with `const`. A `pure` function also easier to parallelize.

- [video tutorial](https://www.youtube-nocookie.com/embed/8ZxGABHcu40?rel=0) *~5 min.*
---
### Const raw pointers
```c_cpp
int i = 42;
const int* p1 = &i;   // pointer to const → can’t modify *p1
int* const p2 = &i;   // const pointer   → can’t reassign p2
const int* const p3 = &i; // neither reassigned nor modified
```

---
### `mutable`

- Allows modification of a member in a `const` method.
- Use case: caches, synchronization primitives.
```c_cpp
class C {
    mutable std::mutex m;
    void f() const { m.lock(); /* ... */ m.unlock(); }  // actually bad code!
    void g() const { std::lock_guard(m.lock()); /* ... */}  // using lock guard is cleaner!
};
```

---
## 3. Compile-time evaluation

### `constexpr` function

- Function _can_ be evaluated at compile time, but may also run at runtime.
- Implicitly `inline`.
- Restrictions apply (no dynamic allocation except with `constexpr`-friendly types, etc.).
- **Mark all functions `constexpr` which could be called during compile time.**
- If a function is `constexpr`, it is also `pure` and `const`
* [Is it ever bad to mark a C++ function constexpr? **A: Yes**](https://softwareengineering.stackexchange.com/questions/346993/is-it-ever-bad-to-mark-a-c-function-constexpr)
       1.  You cannot remove this qualifier without an incompatible change to your API
       2. You might want to use a different (maybe slower) way at compile time than on runtime.
 * [solution to ii.: `std::is_const_evaluated`](https://www.youtube-nocookie.com/embed/nkhhV5uSSLk?rel=0) *~6 min.*

### `constexpr` variable

- The value of a `constexpr` variable is known at compile time and does not change throughout the runtime of the program.
- **Mark all variables `constexpr` which do not change value throughout their lifetime and are known at compile time.**
- Class members which do not change are `static constexpr`.

### `consteval` (C++20)

- Function _must_ be evaluated at compile time.
- Cannot be called at runtime.
- **Use this instead of `constexpr` if you write a function which should calculate things at compile time but would be not very efficient for runtime calculation.**

```c_cpp
consteval int square(int x) { return x * x; }
constexpr int n = square(3);  // compile time
int x = 5;
square(x); // error
};
```

---
### `constinit` (C++20)

- Ensures a variable is initialized at compile time (but not necessarily `constexpr`).
- Useful for static/global variables to guarantee initialization order.

---

### `if constexpr`

- Compile-time conditional branching.
- Eliminates unused branches entirely → no invalid code in skipped branch.
```c_cpp
template <typename T>
void f(T x) {
    if constexpr (std::is_integral_v<T>)
        std::cout << "int\n";
    else
        std::cout << "other\n";
}
};
```

- [video tutorial](https://www.youtube-nocookie.com/embed/qHgM5UdzPQU?rel=0&end=758) *~12 min.* In a nutshell: If you know things at compile time, do things at compile time
---

## 4. Optimization hints

### `inline`

- Suggests inlining a function (but compiler is free to ignore).
- More importantly: allows definitions in multiple TUs without ODR violations.

- [How inline Might Affect The Optimizer](https://www.youtube-nocookie.com/embed/GldFtXZkgYo?rel=0) *~8 min.*
- [cpp core guidelines about inline](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#f5-if-a-function-is-very-small-and-time-critical-declare-it-inline) *~2 min.*

---
### `[[likely]]` / `[[unlikely]]` (C++20)

- Branch prediction _hints_ to compiler.
- Helps layout code for cache efficiency, not hardware branch predictor.
```c_cpp
if (x > 0) [[likely]] { ... }
else [[unlikely]] { ... }
};
```
- [example usage + Benchmark](https://en.cppreference.com/w/cpp/language/attributes/likely) *~ 5 min. reading time*
* This is a c++ 20 feature. But you can write a macro for this:
* [`__builtin_expect`](https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-g_t_005f_005fbuiltin_005fexpect-4159)
```c_cpp
#define UNLIKELY(x) __builtin_expect(static_cast<bool>(x), false)
#define LIKELY(x) __builtin_expect(static_cast<bool>(x),true)
```

---
### `[[nodiscard]]`

- Warns if return value is ignored.
- Good for functions where ignoring result is almost always a bug.
- -[Start Using [[nodiscard]]!](https://www.youtube-nocookie.com/embed/nhsahjY5jdE?rel=0) *~6 min.*

---
### `noexcept`

- Function is guaranteed not to throw exceptions.
- Compiler may generate faster code (esp. in move constructors).
- [When noexcept Really Matters](https://www.youtube-nocookie.com/embed/AG_63_edgUg?rel=0) *~5 min.*

---
### `restrict` (non-standard in C++)

- is only defined in the [standard, page 123](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf) of **C**, not in the [standard](https://isocpp.org/std/the-standard) of **C++**. 
- Supported by GCC/Clang/MSVC as extension (`__restrict`).
- Promise that pointer is the _only reference_ to the object → enables optimizations.
- **Dangerous** if violated → UB.
- [video tutorial](https://www.youtube-nocookie.com/embed/TBGu3NNpF1Q?rel=0) *~13 min.*

---

## 5. Memory / linkage / lifetime

### `static` (variable inside function)

- Created once, persists between calls.
- Initialized in a thread-safe manner (since C++11).
- Hidden synchronization may be costly if accessed often → cache via reference if needed.
	- [example of cashing and analysis against direct access](https://www.youtube-nocookie.com/embed/B3WWsKFePiM?rel=0) *~20 min.*

### `static` (global or namespace scope)

- Internal linkage: each TU gets its own copy.

### `static` (class member)

- Belongs to class, not the single objects created from the class.
- Exists once per class, not per instance.
---
### `inline` (global variables, C++17+)

- Allows defining globals in headers without ODR violations.
- Prefer over `static` globals.
- No copy! All TU share the same memory
```c_cpp
// If you define NON TRIVIAL globals, always force initialisation of that global in the same header file to make sure it is initialised properly.

#include <string>
// cpp17 and later
inline std::string my_string = "123"; // Global value, might be changed!
inline constexpr double pi = 3.14; // unchangable global value
```
---
### `static` vs `inline` vs `constexpr` vs `consteval` (functions)

|Keyword|Scope effect|Compile-time?|
|---|---|---|
|`static`|Internal linkage|runtime only|
|`inline`|Multiple TUs allowed|runtime only|
|`constexpr`|Inline + maybe compiletime|optional|
|`consteval`|Inline + must compiletime|required|

| Location    | Keyword(s)                                                                          | Why / When                                                                                                                                                                                                                                                 |
| ----------- | ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Header-only | `constexpr` / `consteval` / `inline`                                                | Needed to avoid ODR violations. `constexpr` if it’s evaluatable at compile time. `consteval` if you want to force calculation at compile time. ⚠️ Don’t use `static` here → each TU would get its own copy, leading to code bloat and potential surprises. |
| Header+cpp  | none (declaration in header, definition in cpp)                                     | Standard function split.<br><br> - Don’t use `inline` here (unless you want to allow multiple weak definitions).<br>    <br>- Don’t use `static` here (function wouldn’t be visible to other TUs).                                                         |
| .cpp only   | `namespace { }` or `static` <br>both can be combined with `constexpr` / `consteval` | TU-local helpers. Prefer anonymous namespace over `static`.                                                                                                                                                                                                |
| Static lib  | same as header+cpp                                                                  | Public API in headers, definitions in cpp. Internal helpers TU-local.                                                                                                                                                                                      |
| Dynamic lib | same as static lib + export attributes                                              | Manage visibility explicitly.                                                                                                                                                                                                                              |

---
### `static` vs `inline` vs `constexpr` vs `constinit` (variables)

| Keyword                  | Meaning                                                                                                                                                                         |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `static` (local)         | persists between calls, created once on first use                                                                                                                               |
| `static` (global)        | internal linkage, TU-local copy                                                                                                                                                 |
| `inline` (global, C++17) | one shared instance across TUs                                                                                                                                                  |
| `constexpr`              | compile-time constant, implicitly const (initializes data in the current stack)                                                                                                 |
| `static constexpr`       | TU-local constant (not shared)                                                                                                                                                  |
| `constinit`              | must be initialized at compile time, but not necessarily a constant expr                                                                                                        |
| static constexpr         | >> use inside function for BIG DATA (initializes data globaly in the static storage) [constexpr vs. static constexpr](https://www.youtube-nocookie.com/embed/IDQ0ng8RIqs?rel=0) |
| constexpr inline         | >> use in global scope for BIG DATA [static constexpr vs. inline constexpr](https://www.youtube-nocookie.com/embed/QVHwOOrSh3w?rel=0)                                           |
## 6. Error handling

### `try` / `catch`

- Standard exception handling.
- For large projects, use **Lippincott function** (single central error handler).
	- [video tutorial](https://www.youtube-nocookie.com/embed/-amJL3AyADI?rel=0) *~8 min.*