#programming #cpp
[root](../README.md) / statistics.md

## median
- it is not necessary to (completely) std::sort your range!
- see [Evolution of a Median Algorithm in C++ - Pete Isensee - CppCon 2023](https://www.youtube-nocookie.com/embed/izxuLq_HZHA?rel=0&start=32) ~ 28 min.
- The following is how I implementation (c++20) reduces the computation from O(N log(N)) to O(N)
```c++
template<std::ranges::random_access_range Range,
typename Comp = std::ranges::less,
typename ExecPolicy = std::decay_t<decltype(std::execution::seq)>,
typename InputType = std::ranges::range_value_t<Range>>
requires std::sortable<std::ranges::iterator_t<Range>, Comp> && std::is_arithmetic_v<InputType>
auto median(Range&& nonEmptyNumConstRange, Comp comp = {}, ExecPolicy execPolicy = std::execution::seq)
{
using ReturnType = typename std::conditional<(std::is_integral_v<InputType>), double, InputType>::type;
assert(!std::empty(nonEmptyNumConstRange));
if (std::empty(nonEmptyNumConstRange))
{
  return ReturnType{};
}

const auto begin = std::begin(nonEmptyNumConstRange);
const auto end = std::end(nonEmptyNumConstRange);
const auto mid = begin + (std::size(nonEmptyNumConstRange) / 2);

std::nth_element(execPolicy, begin, mid, end, comp);
if (std::size(nonEmptyNumConstRange) % 2)
  return static_cast<ReturnType>(*mid);

const auto midNeighbor = std::max_element(execPolicy, begin, mid, comp);
return std::midpoint<ReturnType>(*midNeighbor, *mid);
}
```