[root](../README.md) / constexpr.md
# constexpr; functions@compiletime
Things you can calculate at compile time. This will probably become just a forest of code snippets. Anyways consider: Everything done at compile time is const at run time and can be optimised by your favourite compiler. BTW.: Templates are Turing complete, so there is more possible than you think. *It's gonna get a little weird, its gonna get a little wild, this is not from around here, this is from another dimension.*


## Dictionary Lookup
The implementation of std::map does not allow to be static constexpr. Instead use this implementation from Jason Turner:
```c_cpp
#include <array>
#include <string_view>
#include <stdexcept>
#include <algorithm>

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
  static constexpr auto map =
      Map<std::string_view, int, color_values.size()>{{color_values}};

  return map.at(sv);
}
```
- [The video explaining the code in depth](https://www.youtube-nocookie.com/embed/INn3xa4pMfg?rel=0) *~25 min.*
- [This example in Compiler Explorer](https://godbolt.org/z/cnrzKr)


## Rand
This should **never** be used for scientific purpose! But random generated terrain maybe? By Jason Turner:
```c_cpp
#include <cstdint>
#include <limits>

constexpr auto seed()
{
  std::uint64_t shifted = 0;

  for( const auto c : __TIME__ )
  {
    shifted <<= 8;
    shifted |= c;
  }

  return shifted;
}

struct PCG
{
  struct pcg32_random_t { std::uint64_t state=0;  std::uint64_t inc=seed(); };
  pcg32_random_t rng;
  typedef std::uint32_t result_type;

  constexpr result_type operator()()
  {
    return pcg32_random_r();
  }

  static result_type constexpr min()
  {
    return std::numeric_limits<result_type>::min();
  }

  static result_type constexpr max()
  {
    return std::numeric_limits<result_type>::min();
  }

  private:
  constexpr std::uint32_t pcg32_random_r()
  {
    std::uint64_t oldstate = rng.state;
    // Advance internal state
    rng.state = oldstate * 6364136223846793005ULL + (rng.inc|1);
    // Calculate output function (XSH RR), uses old state for max ILP
    std::uint32_t xorshifted = ((oldstate >> 18u) ^ oldstate) >> 27u;
    std::uint32_t rot = oldstate >> 59u;
    return (xorshifted >> rot) | (xorshifted << ((-rot) & 31));
  }

};

constexpr auto get_random(int count)
{
  PCG pcg;
  while(count > 0){
    pcg();
    --count;
  }
  
  return pcg();
}

int main()
{

  constexpr auto r = get_random(10);
  return r;
}
```
- [This example in Compiler Explorer](https://godbolt.org/g/zbWvXK)
- [video tutorial](https://www.youtube-nocookie.com/embed/rpn_5Mrrxf8?rel=0) *~6 min.*
- [follow up video: generating a maze and solving it at compiletime](https://www.youtube-nocookie.com/embed/3SXML1-Ty5U?rel=0) *~9 min.*

## Regular Expressions (CTRE)
- [github](https://github.com/hanickadot/compile-time-regular-expressions)
- [a ton of talks](https://compile-time.re/)