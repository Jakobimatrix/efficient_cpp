# efficient_cpp

## Description
The main argument to program in cpp is:
*Its close to the hardware so it must be fast.*
The thing is, this is only true if you do it *right*, whatever that means...

I use cpp since 2013 and am now on a point where I cannot remember every fancy detail so I thought about creating something where I can fast search for a specific thing I have learned. But I don't want to create tutorials, there are already enough out there done by people far more competent. Instead this should be a glossary linking every *problem* (I encountered) to the a tutorial site. Here I try to find tutorials which are **on point**:
Problem --> Solution
does/dont’s  --> Example
Much like the [CppCoreGuidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html) I will try to summarise with as little words as possible.
That being said if one has the time and endurance to digest the details good reading material or talks will be separately liked too. I try to add a tldr in those cases.

**Disclaimer**
Most things will **not** be based on my experience but rather on the trust that who ever told me do that and this knows his cpp. I am not an expert (yet).

Contributions are welcome!

## Todos
- Find a reliable way to check if links are working.
- Should the good stuff be downloaded in case of take downs etc.?

## I am not the only one
- [AwesomePerfCpp](https://github.com/fenbf/AwesomePerfCpp) 
- [CPP_Optimizations_Diary](https://github.com/facontidavide/CPP_Optimizations_Diary) 


## Before you throw every optimisation onto your code base
1. There are some things you can and should always do. These are covered in **basics**. 
2. Don't reinvent the wheel: Use well established existing **libraries**. These are already optimised by people who know probably better.
3. **First** write clean code<sup>[1](#footnote_clean_code)</sup> **Second** write good tests **Third** validate if optimisation is needed **Forth** profile the program, don't do blind optimisation **Fifth** optimise. **Sixth** Check if Tests still work.

<a name="footnote_clean_code">1</a>: *clean code* is a topic on its own with a lot of discussion and different opinions. Not tackled here.

## Table of contents

- [Basics](basics/basics.md)
- [Algorithms](algorithms/algorithms.md)
- [Bit Magic](bitMagic/bitMagic.md)
- [Compiler](compiler/compiler.md)
- [constexpr; functions@compiletime](constexpr/constexpr.md)
- [Intrinsic Functions](intrinsicFunctions/intrinsicFunctions.md)
- [Multithreading](multithreading/multithreading.md)
- [Microcontroller](microcontroller/microcontroller.md)
- [Profiling](profiling/profiling.md)
- [std](std/std.md)
- [Tools](/tools/tools.md)

## Credits
If I shamelessly copy pasted from another tutorial (more than a few lines) I credited the author direct there.
