# efficient_cpp

## Description
The main argument to program in cpp is:
*Its close to the hardware so it must be fast.*
The thing is, this is only true if you do it *right*, whatever that means...

I use cpp since 2013 and am now on a point where I cannot remember every fancy detail so I thought about creating something where I can fast search for a specific thing I have learned. But I don't want to create tutorials, there are already enough out there done by people far more competent. Instead this should be a glossary linking every *problem* (I encountered) to the a tutorial site. Here I try to find tutorials which are **on point**:
Problem --> Solution
does/dont’s  --> Example
Much like the [CppCoreGuidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html) I will try to summarize with as little words as possible.
That being said if one has the time and endurance to digest the details good reading material or talks will be separately liked too. I try to add a tldr in those cases.

**Disclaimer**
Most things will **not** be based on my experience but rather on the trust that who ever told me do that and this knows his cpp. I am not an expert (yet).

Also this is **not** a guide for *Best Practice*. Actually some things you read here are in opposite to *Best Practice* or are in conflict with them. *Best Practice aims for clean, maintainable, readable code and tries to introduces structures/idioms that will guide you around possible pitfalls of cpp.* If you are interested in that topic; I recommend you have a look at the [CppCoreGuidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines.html) and [Jason Turner's (lefticus) cppbestpractices](https://github.com/lefticus/cppbestpractices).

Contributions are welcome!
Also: As the standard changes and the compiler are changing some things might be not up-to-date anymore or even wrong. Make sure the things you read here still apply before applying them, and if you find they don't, consider opening a pull request.
AlsoAlso: I was too lazy to add for every point at which c++ version that point is valid. Check it yourself before applying it to your project ;) If your compiler is too old consider an upgrade? The longer you wait the harder it will be to do a upgrade.

## Todos
- Find a reliable way to check if links are working.
- Should the good stuff be downloaded in case of take downs etc.?

## I am not the only one
- [AwesomePerfCpp](https://github.com/fenbf/AwesomePerfCpp) 
- [CPP_Optimizations_Diary](https://github.com/facontidavide/CPP_Optimizations_Diary) 


## Before you throw every optimisation onto your code base
1. There are some things you can and should always do. These are covered in **basics**. 
2. Don't reinvent the wheel: Use well established existing **libraries**. These are already optimized by people who know probably better.
3. **First** write clean code<sup>[1](#footnote_clean_code)</sup> **Second** write good tests **Third** validate if optimisation is needed **Forth** profile the program, don't do blind optimisation **Fifth** optimize. **Sixth** Check if Tests still work.
    * A funny story about [blind optimization](https://www.youtube-nocookie.com/embed/nXaxk27zwlk?rel=0&start=209&end=614) you should listen to ~7 minutes.

Or to quote from [Cambridge; Faster C++](http://www-h.eng.cam.ac.uk/help/tpl/languages/C++/fasterC++.html#Basics):

- A very common piece of advice is "Delay optimisation as much as possible, and don't do it if you can avoid it.", Donald Knuth said, "premature optimisation is the root of all evil."
- A very common piece of advice is "Measure to find out where the bottleneck is, and optimize that."
- Select appropriate data structures.
- Pick sensible algorithms - if you're sorting or searching, don't just use the first routine you come across.
- I/O is slow


<a name="footnote_clean_code">1</a>: *clean code* is a topic on its own with a lot of discussion and different opinions. Not tackled here.

## Table of contents

- [Basics](basics/basics.md)
- [Algorithms](algorithms/algorithms.md)
- [Bit Magic](bitMagic/bitMagic.md)
- [Compiler](compiler/compiler.md)
- [constexpr; functions@compiletime](constexpr/constexpr.md)
- [Intrinsic Functions](intrinsicFunctions/intrinsicFunctions.md)
- [Libraries](libraries/libraries.md)
- [Multithreading](multithreading/multithreading.md)
- [Microcontroller](microcontroller/microcontroller.md)
- [Tools](/tools/tools.md)
- [Talks](talks/talks.md)

## NFAQ
**Q:** Did you watch all the linked video footage and read all the linked articles?
**A:** Yes, sometimes at x1.75 speed though.

**Q:** Do you remember all that stuff?
**A:** No, hence this repository.

**Q:** Can I take everything here for granted?
**A:** No, I do make mistakes. Please also use your brain.


## Credits
If I shamelessly copy pasted from another tutorial (more than a few lines) I credited the author direct there.
