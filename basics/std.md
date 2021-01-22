[root](../README.md) / [Basics](basics.md) / std.md
# std
## #include &lt;algorithm&gt;
Ever found yourself writeing the 1000st. for loop over an array/vector/list/map performing a very simple operation?
**It is very likely that there already is a suitable algorithm in the [algorithm header](https://en.cppreference.com/w/cpp/algorithm)!**

## emplace_back
The operation push_back does a move operation and results in a call of the destructor twice.
**Whenever possible use emplace_back().**
```c_cpp
std::vector<YourClass> v;
v.push_back(YourClass(...)); // BAD
v.emplace_back(...); // GOOD
v.emplace_back(YourClass(...)); // NO!!!
```
- [video tutorial](https://www.youtube-nocookie.com/embed/uwv1uvi1OTU?rel=0) *~5 min.*

## std::endl
The endline operation will flush the stream to the console/file. In most cases this is not neccessary especially in loops and costs much time.
**Do not use std::endl. Use ... << "\n" instead. Use std::flush at the end once if necessary.**

- [video tutorial](https://www.youtube-nocookie.com/embed/GMqQOEZYVJQ?rel=0&start=0&end=619) *~10 min.*

##std::map at() vs []
[] always tries to insert somthing.
**Use the at() function. It has a const implementation, is slightly faster and generates less code (assembly).**
Dont confuse this with the [] operator of a std::vector! In that case [] is faster.
- [video tutorial](https://www.youtube-nocookie.com/embed/kDqS1xVWGMg?rel=0)  *~12 min.*

##std::map as dictionary lookup
The implementation of std::map does not allow to be static constexpr. Instead use this implementation from Jason Turner:
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
- [The video explaning the code in depth](https://www.youtube-nocookie.com/embed/INn3xa4pMfg?rel=0) *~25 min.*
- [This example in Compiler Explorer](https://godbolt.org/z/cnrzKr)

## std::regex
This is the standard library implementation for Regular Expressions. It is not up to date with the newest cpp features, slow to compile and produces vast executables.
**Dont use it, use [CTRE](https://github.com/hanickadot/compile-time-regular-expressions) instead.**

- [video tutorial](https://www.youtube-nocookie.com/embed/8aRfJp1oZGA?rel=0) *~9 min.*
## std::string
Long strings cause heap allocations.
**Do not use long strings**
The length of a short string depends on the compiler version! Check out the maximal numbers of characters (without \0):
```c_cpp
std::cout << "Capacity: " << string().capacity(); << "\n";
```
**Use std::string_view instread.**
**Or use const char* IF you dont do any string operations further down the line.**

- [video how to return a string optimal](https://www.youtube-nocookie.com/embed/9mWWNYRHAIQ?rel=0) *~13 min.*
- [video short string](https://www.youtube-nocookie.com/embed/S7oVXMzTo4w?rel=0&start=224&end=745) *~10 min.*

