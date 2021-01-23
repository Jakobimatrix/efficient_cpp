[root](../README.md) / [Basics](basics.md) / keywords.md
# Keywords
The following keywords should be used if possible to help the compiler to optimise the code:

- static
- const
- constexpr [video tutorial](https://www.youtube-nocookie.com/embed/qHgM5UdzPQU?rel=0&end=758) *~12 min.* In a nutshell: If you know things at compile time, do things at compile time.
- inline

## local Variables
**Keep your variables as local as possible. This also helps the compiler to do optimisation.**

- [Init statement example](https://en.cppreference.com/w/cpp/language/if#If_Statements_with_Initializer) - [video tutorial](https://www.youtube-nocookie.com/embed/AiXU5EuLZgc?rel=0&end=500) *~9 min.*

## raw Pointer
Just a friendly reminder:
```c_cpp
int i = 42;
const int* ptr0 = &i; // Can not change value pointing to. Can change the pointer.
int* const ptr1 = &i; // Can change value via pointer. Can not change the pointer.
const int* const ptr2 = &i; // Can not change value or the pointer.
```
## try catch
Use Lippincott Functions to reduce code size and compile time.
[video tutorial](https://www.youtube-nocookie.com/embed/-amJL3AyADI?rel=0) *~8 min.*