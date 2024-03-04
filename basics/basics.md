#programming #cpp
[root](../README.md) / basics.md
# Basics
These are small  optimizations which are very easy to do with no or very little drawbacks and thus should be done automatically.

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

** For simple cases the compiler might be able to optimize the loop, but in complex situations the compiler is lost.**

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

### Iterator based loops
You should always prefer the range based for loop which is the fastest implementation of a for loop over all elements. If you iterate manually make sure to do the right comparison to check for the end of the container.
```c_cpp
// bad since the comparison < is slower than !=
for(auto it = container.start(); it < container.end(); it++) {...}

// good
for(auto it = container.start(); it != container.end(); it++) {...}

// even better
for(const auto &data : container) {...}
```
- [C++ Weekly - Ep 279 - Quick Perf Tip: Use The Right Iterator Comparison](https://www.youtube-nocookie.com/embed/oelQ4uAw2WQ?rel=0) *~8 min.*