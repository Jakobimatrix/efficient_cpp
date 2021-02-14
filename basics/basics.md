[root](../README.md) / basics.md
# Basics
These are small  optimisations which are very easy to do with no or very little drawbacks and thus should be done automatically.

## Chapter

- [Heavy Maths](heavyMath.md)
- [Keywords](keywords.md)
- [Lambdas](lambdas.md)
- [Memory](memory.md)
- [std](std.md)
- [Functions and Methods](functionsAndMethods.md)

## Loops
Inside a loop:
- avoid heavy (slow) operations
- avoid complex loop-bodies
- avoid if/else/switch --> branchless programming
- avoid using different memory blocks

** For simple cases the compiler might be able to optimise the loop, but in complex situations the compiler is lost.**

- [See also this 51 Slides with assembly examples](https://www.slideshare.net/MarinaKolpakova/pragmatic-optimization-in-modern-programming-mastering-compiler-optimizations) *~1h*