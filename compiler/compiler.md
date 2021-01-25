[root](../README.md) / compiler.md
# Compiler
To optimise your code you need to understand what the compiler does, how he does and when he does as well as when and what he can and cannot do.
**Most optimisation will be done by the compiler, not by you! The compiler is build by people who are a lot smarter than you! Your task is to a) optimise large algorithms (meaning choosing the right data and the right algorithm for the task) and b) help the compiler doing small optimisations rather than trying to be smart and doing the optimisations by yourself.**

#Assembly
To be able to compare different compilers or the result of different code snippets you need to understand the output of the compiler. It is not necessary to become fluent in Assembly, but it helps if you can recognise specific things.

- [Assembly Crash Course (watch first)](https://www.youtube-nocookie.com/embed/75gBFiFtAb8?rel=0&start=32) *~10 min.*
- [Basics Video part 1 Optimisation -O example](https://www.youtube-nocookie.com/embed/my39Gpt6bvY?rel=0) *~7 min.*
- [Basics Video part 2 Optimisation -O example](https://www.youtube-nocookie.com/embed/R3HZJ1h2BVY?rel=0) *~6 min.*
- [Basics Video part 3 compare compilers example](https://www.youtube-nocookie.com/embed/KpH6ypYfoNs?rel=0) *~7 min.*
- [Fibonacci in Assembly](https://www.youtube-nocookie.com/embed/yOyaJXpAYZQ?rel=0) *~10 min.*

## Compiler flags
Depending on the given flags your compiled result will end up different.

- [see all options with description](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
- **-O0** *"Reduce compilation time and make debugging produce the expected results. This is the default."*
- **-O1** *"reduce code size and execution time, without performing any optimisations."* 
- **-O2** *"GCC performs nearly all supported optimisations that do not involve a space-speed trade off; increases compilation time, increases performance"*
- **-O3** *turns on all optimisations*
- **-Os** *Optimise for size not speed*
- **-Ofast** Do not use for if precise math is needed! *"-Ofast enables all -O3 optimisations. It also enables optimisations that are not valid for all standard-compliant programs. It turns on -ffast-math, -fallow-store-data-races and the Fortran-specific -fstack-arrays, unless -fmax-stack-var-size is specified, and -fno-protect-parens."*
- **-Og** *Best for debugging*
- [comparison of the flags; video](https://www.youtube-nocookie.com/embed/THE14sSDT6A?rel=0&start=227) *~7 min.*
 
The options above bundle single optimisation flags. Here are 3 non standard Flags which might speed up your code even further but you trait the precision of your floating point results against time. Like *-Ofast* this is only recommended if you don't need precise results.

- **-ffast-math** *"Is a shortcut for several options, presenting the least conforming but fastest math mode. It enables -fno-trapping-math, -funsafe-math-optimizations, -ffinite-math-only, -fno-errno-math, -fno-signaling-nans, -fno-rounding-math, -fcx-limited-range and -fno-signed-zeros."*

## Copy Elision

## NRVO (named return value optimisation

## RVO (return value optimisation)

## Special initializer functions
If you define one of the special constructor methods, you have to define all of them, the compiler wont!
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


