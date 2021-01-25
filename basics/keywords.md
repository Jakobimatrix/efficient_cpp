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
A `const` variable does not change its value but is defined at runtime.
**Mark all variables `const` which do not change there value through there lifetime.**
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

- [Is it ever bad to mark a C++ function constexpr? **A: Yes**](https://softwareengineering.stackexchange.com/questions/346993/is-it-ever-bad-to-mark-a-c-function-constexpr)


## constexpr Variable
The value of a `constexpr` variable is known at compile time and does not change throughout the runtime of the program.
**Mark all variables `constexpr` which do not change there value through there lifetime and are known at compile time.**
If a variable is `constexpr`, it is also const.

## constinit static variable
A variable declared `constinit static` is assured to be calculated at compile time. If it is not, the compiler will throw an error.

###const raw Pointer
Just a friendly reminder:
```c_cpp
int i = 42;
const int* ptr0 = &i; // Can not change value pointing to. Can change the pointer.
int* const ptr1 = &i; // Can change value via pointer. Can not change the pointer.
const int* const ptr2 = &i; // Can not change value or the pointer.
```

## inline
By using the word inline you suggest that the function can be inlined: You change an internal threshold value which the compiler computes whether it thinks that it is good or bad to inline the function. The thing is, that whether this is a good or a bad idea also depends on the architecture.
**TODO different opinions on that topic ;(**

- [How inline Might Affect The Optimizer](https://www.youtube-nocookie.com/embed/GldFtXZkgYo?rel=0) *~8 min.*
- [cpp core guidelines about inline](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#f5-if-a-function-is-very-small-and-time-critical-declare-it-inline) *~2 min.*

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
Declaring a function `[[nodiscard]]` means that you cannot use the function without using its return value. Though this is mainly to prevent and find bugs this also might help you to optimise code after you found that you use empty() instead of clear().

- [Start Using [[nodiscard]]!](https://www.youtube-nocookie.com/embed/nhsahjY5jdE?rel=0) *~6 min.*

## noexept
Flagging a function/method with the `noexept` keyword tells the compiler that no exceptions will happen will no exceptions happen, when this function/method is called. This allows the compiler to optimise things.
**Do mark functions and methods `noexept` if you know that they cannot throw an exception.**

- [When noexcept Really Matters](https://www.youtube-nocookie.com/embed/AG_63_edgUg?rel=0) *~5 min.*

## pure function
A `pure` function does not use any global state.
**Mark all functions pure which do not use global values.**
This helps the compiler to optimise your code and can be combined with `const`. They are also easier to parallelize.

- [video tutorial](https://www.youtube-nocookie.com/embed/8ZxGABHcu40?rel=0) *~5 min.*

## static variable
`Static` variables are essential global variables which get initialised once, exist only once and have a lifetime from there first call until the program is terminated. This has its benefits but `static` variables are guaranteed to be initialised in a thread save fashion meaning there are "hidden" locks. Also on every access there is always a check if the variable is already initialised.
**If a `static variable` is accessed a s&ast;&ast;&ast;t-ton of times it might me a good idea to instead have a local `reference` (local cash) to the `static variable` instead.**

- [example of cashing and analysis against direct access](https://www.youtube-nocookie.com/embed/B3WWsKFePiM?rel=0) *~20 min.*


## try catch
Use Lippincott Functions to reduce code size and compile time.
[video tutorial](https://www.youtube-nocookie.com/embed/-amJL3AyADI?rel=0) *~8 min.*
