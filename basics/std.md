[root](../README.md) / [Basics](basics.md) / std.md
# std
## #include &lt;algorithm&gt;
Ever found yourself writing the 1000st. for loop over an array/vector/list/map performing a very simple operation?
**It is very likely that there already is a suitable algorithm in the [algorithm header](https://en.cppreference.com/w/cpp/algorithm)!**

## std::endl
The endline operation will flush the stream to the console/file. In most cases this is not necessary especially in loops and costs much time.
**Do not use std::endl. Use `... << "\n"` instead. Use `std::flush` at the end once if necessary.**

- [video tutorial](https://www.youtube-nocookie.com/embed/GMqQOEZYVJQ?rel=0&start=0&end=619) *~10 min.*

## std::map at() vs []
[] always tries to insert something.
**Use the `at()` function. It has a const implementation, is slightly faster and generates less code (assembly).**
Don't confuse this with the [] operator of a std::vector! In that case [] is faster.
- [video tutorial](https://www.youtube-nocookie.com/embed/kDqS1xVWGMg?rel=0)  *~12 min.*

## std::list
**Don't use a list!**
// TODO

## std::map as dictionary lookup
The implementation of std::map does not allow to be `static constexpr`. Instead use this implementation from Jason Turner:
```c_cpp
#include <array>
#include <string_view>
#include <stdexcept>
#include <algorithm>
#include <map>

template <typename Key, typename Value, std::size_t Size>
struct Map {
  std::array<std::pair<Key, Value>, Size> data;

  [[nodiscard]] constexpr Value at(const Key &key) const {
    const auto itr =
        std::find_if(begin(data), end(data),
                     [&key](const auto &v) { return v.first == key; });
    if (itr != end(data)) {
      return itr->second;
    } else {
      throw std::range_error("Not Found");
    }
  }
};

using namespace std::literals::string_view_literals;
static constexpr std::array<std::pair<std::string_view, int>, 8> color_values{
    {{"black"sv, 7},
     {"blue"sv, 3},
     {"cyan"sv, 5},
     {"green"sv, 2},
     {"magenta"sv, 6},
     {"red"sv, 1},
     {"white"sv, 8},
     {"yellow"sv, 4}}};

int lookup_value(const std::string_view sv) {
  //static const auto map = std::map<std::string_view, int>{color_values.begin(), color_values.end()};
  static constexpr auto map =
      Map<std::string_view, int, color_values.size()>{{color_values}};

  return map.at(sv);
}
```
- [The video explaining the code in depth](https://www.youtube-nocookie.com/embed/INn3xa4pMfg?rel=0) *~25 min.*
- [This example in Compiler Explorer](https://godbolt.org/z/cnrzKr)

## std::move
std::move can help to avoid deep copies of **temporary** objects:

- [Q: what is stdmove and when should it be used](https://stackoverflow.com/questions/3413470/what-is-stdmove-and-when-should-it-be-used#answer-42340735) *~3 min.*
- [understand rvalue, lvalue and movesemantics, with example](https://stackoverflow.com/questions/3106110/what-is-move-semantics#answer-3109981) *~7 min.*

To be able to use `std::move` with your own classes, you need to implement the move operator. 
**This is only necessary if your class holds (large) chunks of data on the heap.**
In that case you should understand the **rule of five**

- [rule of three/five/zero](https://en.cppreference.com/w/cpp/language/rule_of_three) *~8 min.*
- [RAII and the Rule of zero/three/five](https://www.youtube-nocookie.com/embed/7Qgd9B1KuMQ?rel=0&start=1263&end=2960) *~29 min.*
- [construction/assignment/destruction Core Guidelines](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md#cctor-constructors-assignments-and-destructors) *~2 h.*

However if used wrong it might hinder the compiler to optimise your code or implies a wrong picture of the situation. Let the compiler help you by enabling **-Wredundant-move** and **-Wpessimizing-move**

- [Article: When not to use std::move](https://developers.redhat.com/blog/2019/04/12/understanding-when-not-to-stdmove-in-c/)  *~6 min.*
- [Video: You Cannot Move From Const](https://www.youtube-nocookie.com/embed/ZKaoR3dP9uM?rel=0) *~6 min.*
- [Video: Disabling Move From const](https://www.youtube-nocookie.com/embed/nP3TnWBonlY?rel=0) *~5 min.*

## std::regex
This is the standard library implementation for Regular Expressions. It is not up to date with the newest cpp features, slow to compile and produces vast executables.
**Don't use it, use [CTRE](https://github.com/hanickadot/compile-time-regular-expressions) instead.**

- [video tutorial](https://www.youtube-nocookie.com/embed/8aRfJp1oZGA?rel=0) *~9 min.*
## std::string
Long strings cause heap allocations.
**Do not use long strings**
The length of a short string depends on the compiler version! Check out the maximal numbers of characters (without \0):
```c_cpp
std::cout << "Capacity: " << string().capacity(); << "\n";
```
**Use `std::string_view` instead.**
**Or use `const char&ast; IF` you don't do any string operations further down the line.**

- [video how to return a string optimal](https://www.youtube-nocookie.com/embed/9mWWNYRHAIQ?rel=0) *~13 min.*
- [video short string](https://www.youtube-nocookie.com/embed/S7oVXMzTo4w?rel=0&start=224&end=745) *~10 min.*

## std::vector (dynamic array)
A vector allows you to store data on the heap without having to deal with the allocation and without the need to explicit say how much memory you need (in opposite to an array where you need to know the size at compile time).

A heap allocations of a `std::vector` occurs always if the capacity (the number of elements that can be held in currently allocated storage) equals the numbers of elements in the vector and you `push_back` or `emplace_back` another element. In that case `std::vector` will allocate memory on the heap of twice the current capacity and move all the data from the current heap to the new allocated space since the data in the vector is always one block in memory.

- [optimise usage of std::vector](https://www.youtube-nocookie.com/embed/HcESuwmlHEY?rel=0&start=67&end=540) *~8 min.*

### emplace_back
The operation push_back does a move operation and results in a call of the destructor twice.
**Whenever possible use emplace_back().**
```c_cpp
std::vector<YourClass> v;
v.push_back(YourClass(...)); // BAD
v.emplace_back(...); // GOOD
v.emplace_back(YourClass(...)); // NO!!!
```
- [video tutorial](https://www.youtube-nocookie.com/embed/uwv1uvi1OTU?rel=0) *~5 min.*

### reserve
`std::vector` allocates memory on the heap if necessary like so: 2->4->8->16->...
**Reduce the amount of heap allocations by calculating how many elements you are going to put into the vector. If you don't know exactly how many elements to expect, estimate upwards. If you actually know the amount of data at compile time, use an `std::array`.**

###  shrink_to_fit
If you have large amounts of data and you are not using reserve you might end up in the worst case with 2<sup>n</sup>+1 elements wasting space of 2<sup>n</sup>-1 times the `size_of(yourData)`.
**If you could not reserve the right amount of space before putting in your data, use `shrink_to_fit` to give up any unused free space.**

