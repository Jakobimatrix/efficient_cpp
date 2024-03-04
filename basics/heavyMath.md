#programming #cpp
[root](../README.md) / [Basics](basics.md) / heavyMath.md
# Heavy Maths Operations
Some operations need a great amount of clock cycles. Used in loops these can be the reason for a bottle neck. There are ways to trait precision for faster calculation. See:

- [Bit Magic](../bitMagic/bitMagic.md)
- [Compiler](../compiler.md)


## Division
Division performs much slower than multiplication.
**Avoid divisions which can not be optimized by compiler.**
Use [Compiler Explorer](https://godbolt.org/) if unsure.

- [read more](https://stackoverflow.com/questions/4125033/floating-point-division-vs-floating-point-multiplication#answer-45899202) *~15 min. reading time*

## Trigonometric Functions
Trigonometric functions are very slow.

- [execution time comparison](https://latkin.org/blog/2014/11/09/a-simple-benchmark-of-various-math-operations/#results)

**Minimize the usage of sin, asin, cos, acos, tan, atan, atan2, sqrt, exp**



