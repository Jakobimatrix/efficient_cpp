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

### implicit type conversation within loops
If you use an index to access data inside a container, use `size_t` (64 bit unsigned) as the index type not `int` (32 bit signed). Otherwise you force for every element access an implicit conversation.
```c_cpp
for(int i = start; i < end; ++i) {
  data[i].do(); // implicit conversation
}
for(size_t i = start; i < end; ++i) {
  data[i].do(); // OK
}
```
- [C++ Weekly - Ep 277 - Quick Perf Tip: Avoid Integer Conversions](https://www.youtube-nocookie.com/embed/jKpIZ4UcaNw?rel=0) *~10 min.*
