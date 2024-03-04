#programming #cpp
[root](../README.md) / [Basics](basics.md) / functionsAndMethods.md
# Functions/Methods
This is about calling functions and methods as well a passing and returning variables. Optimizing via keywords can be found in [Basics/keywords.md](keywords.md).

## Default Member Initialization
**Should be done instead of using an initializer list.**

* [faster debug code + clean code](https://www.youtube-nocookie.com/embed/qNNAMH9LHA?rel=0) *~5 min.*

## inline const static Variables
Static variables as explained [here](keywords.md#staticvariable) have a hidden guard lock. But a const static member variable is defined at compile time and thus don't need a lock. Now the downside is, that you need to define the variable outside the class/struct. You can use inline to define it like a default variable definition, but that adds a lock.

-  [video tutorial](https://www.youtube-nocookie.com/embed/m7hwL0gHuP4?rel=0) *~6 min.*

## local Variables
**Keep your variables as local as possible. This also helps the compiler to do optimisation.**

- anonymous namespaces // TODO
- [IF init statement](https://en.cppreference.com/w/cpp/language/if#If_Statements_with_Initializer) - [video tutorial](https://www.youtube-nocookie.com/embed/AiXU5EuLZgc?rel=0&end=500) *~9 min.*


## Passing multiple variables
Depending on the architecture there is a limit of how many variables can be loaded into a function without the need of saving them onto the heap.
**Pass multiple variables inside a struct/object especially if they are always passed together through multiple functions/methods.**

- [example video](https://www.youtube-nocookie.com/embed/FwsO12x8nyM?rel=0) *~8 min.*

## Return
If you have a function with branches which decide what to return, make sure to do it the right way: **Make sure you don't implicit invoke the copy constructor by accident.**

- [std::string](https://www.youtube-nocookie.com/embed/9mWWNYRHAIQ?rel=0) *~13 min.*
- [std::optional (+ extra bit: GCC vs. clang)](https://www.youtube-nocookie.com/embed/Bu1AEze14Ns?rel=0&start=2436&end=2754) *~6 min.*