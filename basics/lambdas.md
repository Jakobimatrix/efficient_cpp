[root](../../README.md) / [basics](../basics.md) / lambdas.md
# Lambdas
Lambdas are awesome.

- [Lambdas: The Key To Understanding C++](https://www.youtube-nocookie.com/embed/CjExHyCVRYg?rel=0) *~9 min.*
- [What Exactly IS A Lambda Anyhow? A dissection of what the compiler is doing.](https://www.youtube-nocookie.com/embed/br4tez2G9eM?rel=0) *~7 min.*

## Inherit from Lambdas
Is possible since lambdas are classes made by the compiler.

Compile time switch for dealing with variant by Jason Turner: [video](https://www.youtube-nocookie.com/embed/EsUmnLgz8QY?rel=0) *~6 min.*
```c_cpp
#include <utilit>
#include <variant>
#include <type_traits>

template<typename ... Base>
struct VariantLambda : Base ...{
    using Base::operator()...;
};

template<typename ... T> VariantLambda(T...) -> VariantLambda<T...>;

int doSomething(){
    constexpr VariantLambda{
        [](Type1 input) -> outputType { /* deal with Type1*/},
        [](Type2 input) -> outputType { /* deal with Type2*/}
    };
    
    constexpr auto v = std::variant<Type1, Type2>{/*your input of TypeX*/};
    constexpr auto result = std::visit(VariantLambda, v);
}
```

## IIFE immediately invoked function expressions
**Use it to initialise const variables instead of declaring it and using if statements to define them.**

* [example const variable initialisation](https://www.youtube-nocookie.com/embed/d4nmNYTM1j8?rel=0) *~5  min.*
* [detailed examples const variable initialisation](https://www.youtube-nocookie.com/embed/9i2ZirXdrVA?rel=0&end=1030) *~17  min.*
    * **Don't use it to construct an object that will be passed to `const &`**
    * Code size might increase dramatically
    * Don use it in (small) functions that can be inlined. Since IIFE might stop the compiler from inlineing these which results in a lower performance.
    
## Lambdas with States
Since lambdas are classes in the background, they can hold mutable states:

* [Stateful Lambdas](https://www.youtube-nocookie.com/embed/_1X9D8Z5huA?rel=0) *~5  min.*