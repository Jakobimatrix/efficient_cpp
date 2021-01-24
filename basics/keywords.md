[root](../README.md) / [Basics](basics.md) / keywords.md
# Keywords
The following keywords should be used if possible to help the compiler to optimise the code:

- static
- const
- constexpr [video tutorial](https://www.youtube-nocookie.com/embed/qHgM5UdzPQU?rel=0&end=758) *~12 min.* In a nutshell: If you know things at compile time, do things at compile time


## const
Flagging variables as const helps the compiler to optimize your code.
**Mark as much variables and methods const as possible**

###const raw Pointer
Just a friendly reminder:
```c_cpp
int i = 42;
const int* ptr0 = &i; // Can not change value pointing to. Can change the pointer.
int* const ptr1 = &i; // Can change value via pointer. Can not change the pointer.
const int* const ptr2 = &i; // Can not change value or the pointer.
```

## inline
By using the word inline you suggest that the function can be inlined: You change an interlal threshold value which the compiler computes whether it thinks that it is good or bad to inline the function. The thing is, that whether this is a good or a bad idea also depends on the architecture.
**TODO different opinions on that topic ;(**

- [How inline Might Affect The Optimizer](https://www.youtube-nocookie.com/embed/GldFtXZkgYo?rel=0) *~8 min.*
- [cpp core guidelines about inline](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html#f5-if-a-function-is-very-small-and-time-critical-declare-it-inline) *~2 min.*


## static variable
Static variables are essential global variables which get initialized once, exist only once and have a lifetime from there first call untill the programm is terminated. This has its benefits but static variables are guaranteed to be initialized in a thread save fashion meaning there are "hidden" locks. Also on every access there is always a check if the variable is already initialized.
**If a static variable is accessed a s&ast;&ast;&ast;t-ton of times it might me a good idea to instead have a local reference (local cash) to the static variable instead.**

- [example of cashing and analysis against direct access](https://www.youtube-nocookie.com/embed/B3WWsKFePiM?rel=0) *~20 min.*


## try catch
Use Lippincott Functions to reduce code size and compile time.
[video tutorial](https://www.youtube-nocookie.com/embed/-amJL3AyADI?rel=0) *~8 min.*