#programming #cpp
[root](../README.md) / libraries.md
# Libraries
Some libraries you might need or you should have a look at before reinventing the wheel.

## CTRE: Compile Time Regular Expressions
- [github](https://github.com/hanickadot/compile-time-regular-expressions)
- [a ton of talks](https://compile-time.re/)

## GSL GNU Scientific Library
A numerical library with over 1000 functions you probably tried to code on your own.

- [Function areas in GSL](https://www.gnu.org/software/gsl/#subjects)

## Eigen
is a library for vector geometry.
It implements very efficient vector/matrix operations as well as providing solvers for linear equations. Some highlights:

* vector geometry
* dynamic matrices
* affine transformation, quaternionen
* matrix transpose / inverse / pseudo-inverse
* Eigenvalues and Eigenvector calculation
* Linear equation solver for b = A*x
* SVD decomposition, QR decomposition

Sub page: [>> eigen.md](eigen.md)

## PMR
To avoid heap allocations PMR uses a monotonic buffer on the stack which one has to reserve beforehand. This requires knowledge about when in the program how much memory is needed and when you can give up resources again. You also need to write your own allocator functions to manage the data inside the monotonic buffer. It works nicely with all the std::container.
**Keep in mind: PMR doesn't free on its own!**

* [first introduction](https://www.youtube-nocookie.com/embed/q6A7cKFXjY0?rel=0) *~11 min.*
* [Threads](https://www.youtube-nocookie.com/embed/vXJ1dwJ9QkI?rel=0&start=173&end=619) *~16 min.*
* [about memory storage](https://www.youtube-nocookie.com/embed/vXJ1dwJ9QkI?rel=0) *~23 min.*
  * know how and if your memory is growing
  * choose the correct allocator for your case
  * properly nest your allocators
  * know which std::types are allocator aware
* [there are more videos in that playlist](https://www.youtube.com/playlist?list=PLs3KjaCtOwSYX3X0L36NgwK0pxZZavDSF) *~ 2h. 17min.*
