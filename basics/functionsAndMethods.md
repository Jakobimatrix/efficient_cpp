[root](../README.md) / [Basics](basics.md) / functionsAndMethods.md
# Functions/Methods
This is about calling functions and methods as well a passing and returning variables. Optimising via keywords can be found in [Basics/keywords.md](keywords.md).

## Default Member Initialisation
**Should be done instead of using an initializer list.**

* [faster debug code + clean code](https://www.youtube-nocookie.com/embed/qNNAMH9LHA?rel=0) *~5 min.*

## local Variables
**Keep your variables as local as possible. This also helps the compiler to do optimisation.**

- anonymous namespaces // TODO
- [IF init statement](https://en.cppreference.com/w/cpp/language/if#If_Statements_with_Initializer) - [video tutorial](https://www.youtube-nocookie.com/embed/AiXU5EuLZgc?rel=0&end=500) *~9 min.*


## Passing multiple variables
Depending on the architecture there is a limit of how many variables can be loaded into a function without the need of saving them onto the heap.
**Pass multiple variables inside a struct/object especially if they are always passed together through multiple functions/methods.**

- [example video](https://www.youtube-nocookie.com/embed/FwsO12x8nyM?rel=0) *~8 min.*