[root](../README.md) / compiler.md
# Compiler
To optimise your code you need to understand what the compiler does, how he does and when he does as well as when and what he can and cannot do.
**Most optimisation will be done by the compiler, not by you! The compiler is build by people who are a lot smarter than you! Your task is to a) optimise large algorithms (meaning choosing the right data and the right algorithm for the task) and b) help the compiler doing small optimisations rather than trying to be smart and doing the optimisations by yourself.**

# Assembly
To be able to compare different compilers or the result of different code snippets you need to understand the output of the compiler. It is not necessary to become fluent in Assembly, but it helps if you can recognise specific things.

- [Assembly Crash Course (watch first)](https://www.youtube-nocookie.com/embed/75gBFiFtAb8?rel=0&start=32) *~10 min.*
- [Basics Video part 1 Optimisation -O example](https://www.youtube-nocookie.com/embed/my39Gpt6bvY?rel=0) *~7 min.*
- [Basics Video part 2 Optimisation -O example](https://www.youtube-nocookie.com/embed/R3HZJ1h2BVY?rel=0) *~6 min.*
- [Basics Video part 3 compare compilers example](https://www.youtube-nocookie.com/embed/KpH6ypYfoNs?rel=0) *~7 min.*
- [Fibonacci in Assembly; example](https://www.youtube-nocookie.com/embed/yOyaJXpAYZQ?rel=0) *~10 min.*
- [Algebraic optimisation done for you; example](https://www.youtube-nocookie.com/embed/yRKRqzekLU4?rel=0) *~8 min.*

## Compiler flags
Depending on the given flags your compiled result will end up different.
These flags are compatible with `GCC` and `clang`. If you use `msvc` (the visual studio compiler), there are [similar flags](https://docs.microsoft.com/de-de/cpp/build/reference/compiler-options-listed-by-category?view=msvc-160).

- [see all options with description](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
- **-O0** *"Reduce compilation time and make debugging produce the expected results. This is the default."*
- **-O1** *"reduce code size and execution time, without performing any optimisations."* 
- **-O2** *"GCC performs nearly all supported optimisations that do not involve a space-speed trade off; increases compilation time, increases performance"*
- **-O3** *turns on all optimisations*
- **-Os** *Optimise for size not speed*
- **-Ofast** Do not use if precise math is needed! *"-Ofast enables all -O3 optimisations. It also enables optimisations that are not valid for all standard-compliant programs. It turns on -ffast-math, -fallow-store-data-races and the Fortran-specific -fstack-arrays, unless -fmax-stack-var-size is specified, and -fno-protect-parens."*
- **-Og** *Best for debugging*
- [comparison of the flags; video](https://www.youtube-nocookie.com/embed/THE14sSDT6A?rel=0&start=227) *~7 min.*
- **-ffast-math** *"Is a shortcut for several options (included in -Ofast), presenting the least conforming but fastest math mode. It enables -fno-trapping-math, -funsafe-math-optimizations, -ffinite-math-only, -fno-errno-math, -fno-signaling-nans, -fno-rounding-math, -fcx-limited-range and -fno-signed-zeros."*
- **-march=native** Enables vectorisation (multiple instruction at once on CPU)
      * see [SSE, AVX](../intrinsicFunctions/intrinsicFunctions.md#avx)
      * But this strongly depends on the architecture!
      * [system specific build code](https://www.youtube-nocookie.com/embed/_4D1y_KyEzA?rel=0) *~7 min.*
      * [Build your function optimised for different targets](https://godbolt.org/z/voKZhf) *~1 min.*

## NRVO (named return value optimisation

## RVO (return value optimisation)

## Special initializer functions
If you define one of the special constructor methods, you have to define all of them, the compiler wont do it fore you otherwise!
```c_cpp
struct S{
    S() = default; // constructor
    
    // special constructors:
    S(const S &) = default; // copy constructor
    S(S &&) = default; // move constructor
    S& operator=(const S &) = default; // copy assignment
    S& operator=(S&&) = default; // move assignment
    ~S() = default; // destructor
};
```
- compare [std::move](../basics/std.md#stdmove)


## Types of automatic optimisation
Beginning at optimisation level O1 the compiler tries to optimise different things:

### Cache hit optimisation
The cach is the fastest way to access memory. But is also very small. The compiler tries to load the next instructions and data optimal into the small cache to minimise the need to reload data or instructions:

- [Slide 1 - 11](http://www.math.utk.edu/~msaum/papers/FPOPT2.pdf) *~10 min.*
- [2D array (manual) example](http://www-h.eng.cam.ac.uk/help/tpl/languages/C++/fasterC++.html#Cachefriendliness) *~2 min.*

### Elisions
Reduce the number of necessary Assembly. Here are some examples:

* [unused Array parts](https://www.youtube-nocookie.com/embed/5e3m2cppQ6M?rel=0) *~5 min.*
* [unused Pointers](https://www.youtube-nocookie.com/embed/FWD1msG8YU4?rel=0) *~5 min.*

