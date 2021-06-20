[root](../README.md) / [Basics](basics.md) / keywords.md
# Keywords
The following keywords should be used if possible to help the compiler to optimise the code.


## const Function
A `const` function does not change any global state.
**Mark all functions `const` which do not change global values.**
This helps the compiler to optimise your code and can be combined with `pure`.

## const Method
Flagging a method `const` signals that a call to this method won't change the object.
**Mark all methods `const` which do not change the object; `Getters` for example.**


## const Variable
A `const` variable does not change its value and is defined at runtime.
**Mark all variables `const` which do not change value throughout their lifetime.**
This helps the compiler to optimise your code.

## consteval Function
A call to a function flagged `consteval` must be direct or indirect result in an compile time known expression. So it can not be called during runtime.
**Use this instead of `constexpr` if you write a function which should calculate things at compile time but would be not very efficient for runtime calculation.**

## constexpr if
**If the statement inside the if is known at compile time, use `constexpr if(...)` to let the compiler ignore the other paths entirely.**

- [video tutorial](https://www.youtube-nocookie.com/embed/qHgM5UdzPQU?rel=0&end=758) *~12 min.* In a nutshell: If you know things at compile time, do things at compile time

## constexpr Function
A `constexpr function` can be executed at compile time.
**Mark all functions `constexpr` which could be called during compile time.**
If a function is `constexpr`, it is also `pure` and `const`.

* [Is it ever bad to mark a C++ function constexpr? **A: Yes**](https://softwareengineering.stackexchange.com/questions/346993/is-it-ever-bad-to-mark-a-c-function-constexpr)
       1.  You cannot remove this qualifier without an incompatible change to your API
       2. You might want to use a different (maybe slower) way at compile time than on runtime.
 * [solution to ii.: `std::is_const_evaluated`](https://www.youtube-nocookie.com/embed/nkhhV5uSSLk?rel=0) *~6 min.*

## constexpr Variable
The value of a `constexpr` variable is known at compile time and does not change throughout the runtime of the program.
**Mark all variables `constexpr` which do not change value throughout their lifetime and are known at compile time.**
If a variable is `constexpr`, it is also const. Class members which do not change are `static constexpr`.

## constinit static variable
A variable declared `constinit static` is assured to be calculated at compile time. If it is not, the compiler will throw an error.

### const raw Pointer
Just a friendly reminder:
```c_cpp
int i = 42;
const int* ptr0 = &i; // Can not change value pointing to. Can change the pointer.
int* const ptr1 = &i; // Can change value via pointer. Can not change the pointer.
const int* const ptr2 = &i; // Can not change value or the pointer.
```

## explicit
A function or method declared `explicit` does not allow to be called with variables which could be converted into the defined parameter types. This helps avoiding unexpected and potentially heavy conversations or even hidden bugs:
```c_cpp
void setName1(std::string& name);
void explicit setName2(std::string& name);

setName1("Lukas der Lokomotivführer"); // silent conversation from c_string into std::string, dynamic allocation for long strings
setName2("Lukas der Lokomotivführer"); // compile time error

...

template <class T>
explicit (!std::is_trivial_v<T>) setData(T); // only explicit for trivial data like int, double

...

void removeMember1(unsigned int member_id);
explicit void removeMember2(unsigned int member_id);

int member_x = ...;
removeMember1(member_x); // silent conversation from int to unsigned int (even if its negative)
removeMember2(member_x); // compile time error
if(member_x >= 0){
	removeMember2(static_cast<unsigned int>(member_x)); // OK dear compiler, I know what I do.
}
```

## inline
By using inline you suggest that the function can be inlined: You change an internal threshold value which the compiler computes whether it thinks that it is good or bad to inline the function. The thing is, that whether this is a good or a bad idea also depends on the architecture.
**TODO different opinions on that topic ;(**

- [How inline Might Affect The Optimizer](https://www.youtube-nocookie.com/embed/GldFtXZkgYo?rel=0) *~8 min.*
- [cpp core guidelines about inline](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#f5-if-a-function-is-very-small-and-time-critical-declare-it-inline) *~2 min.*

### inline (globals)
Since c++17 you can ensure that a global variable/function is only initialised once using the `inline` keyword. Prior c++17 you will need to make globals static which comes with its own problems see [keyword static](keywords.md#static-variable) so:

```c_cpp
// If you define NON TRIVIAL globals, always force initialisation of that global in the same header file to make sure it is initialised properly.

#include <string>
// cpp17 and later
inline std::string my_string = "123";

// pre cpp17
namespace global {
std::string& my_string() {
	static std::string s = "123";
	return s;
}
}
// but because of static --> atomic, this is slow
// so define a static reference to it to avoid mutex check
static auto& my_string = global::my_string();

// even faster access (only do this if that access is bottleneck of your application)
namespace global {
template <class=void>
struct my_globals{
	static std::string my_string;
};
template <>
std::string my_globals<>::my_string = "123";
}
static auto& m_string = global::my_globals<>::my_string;
```

## [[likely]] [[unlikely]]
If you have a condition branch (`if`, `while`, `for`) you can give the compiler a hint which branch/condition is more likely to be hit through out the runtime. This helps the compiler to optimise. This has nothing to do with branch prediction, but with optimal cache usage for the likely case. E.g. it is unlikely to hit the base case of an recursive function. Or it is unlikely to not find an element in a vector which stores elements you want to find.

- [example usage + Benchmark](https://en.cppreference.com/w/cpp/language/attributes/likely) *~ 5 min. reading time*
* This is a c++ 20 feature. But you can write a macro for this:
* [`__builtin_expect`](https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-g_t_005f_005fbuiltin_005fexpect-4159)
```c_cpp
#define UNLIKELY(x) __builtin_expect(static_cast<bool>(x), false)
#define LIKELY(x) __builtin_expect(static_cast<bool>(x),true)
```

## mutable member Variable
A mutable member variable is allowed to change in the context of a `const method`.
```c_cpp
#include <mutex>
class C{
    mutable std::mutex mut;
    
    void doSomethingThreadsave() const{
        mut.lock();
        // something const
        mut.unlock();
    }
};
```
## [[nodiscard]]
Declaring a function `[[nodiscard]]` means that you cannot use the function without using its return value. Though this is mainly to prevent and find bugs this also might help you to optimise code after you found that you used empty() instead of clear().

- [Start Using [[nodiscard]]!](https://www.youtube-nocookie.com/embed/nhsahjY5jdE?rel=0) *~6 min.*

## noexept
Flagging a function/method with the `noexept` keyword tells the compiler that no exceptions will happen when this function/method is called. This allows the compiler to optimise things.
**Do mark functions and methods `noexept` if you know that they cannot throw an exception.**

- [When noexcept Really Matters](https://www.youtube-nocookie.com/embed/AG_63_edgUg?rel=0) *~5 min.*

## pure function
A `pure` function does not use any global state.
**Mark all functions pure which do not use global values.**
This helps the compiler to optimise your code and can be combined with `const`. A `pure` function also easier to parallelize.

- [video tutorial](https://www.youtube-nocookie.com/embed/8ZxGABHcu40?rel=0) *~5 min.*

## static variable
`Static` variables are essential global variables which get initialised once, exist only once and have a lifetime from their first call until the program is terminated. This has its benefits but `static` variables are guaranteed to be initialised in a thread save fashion meaning there are "hidden" locks. Also on every access there is always a check if the variable is already initialised.
**If a `static variable` is accessed a s&ast;&ast;&ast;t-ton of times it might me a good idea to instead have a local `reference` (local cash) to the `static variable` instead.**

- [example of cashing and analysis against direct access](https://www.youtube-nocookie.com/embed/B3WWsKFePiM?rel=0) *~20 min.*


## try catch
Use Lippincott Functions to reduce code size and compile time.
[video tutorial](https://www.youtube-nocookie.com/embed/-amJL3AyADI?rel=0) *~8 min.*
