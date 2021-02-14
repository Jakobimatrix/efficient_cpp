[root](../README.md) / Tools.md
# Tools
## Introduction
Optimisation from hand is very pain full and inefficient. Especially if you did not write the code. Use tools to 

- see where optimisation is really needed
- see what kind of optimisation is needed
- find possible optimisations automatically

## CppCon 2015: Chandler Carruth "Tuning C++: Benchmarks, and CPU's, and Compilers! Oh My!"
* [link; it's mostly a live performance ](https://www.youtube-nocookie.com/embed/nXaxk27zwlk?rel=0) *~1 h. 15 min. + Questions*
* *'Measure first, tune what matters.'* (A fun anecdote.)
* live performance:
	* Problems with benchmarks (Googles Micro benchmark)
	* Understand your measurement
	* profilers (perf) and problems (with the compiler)
	* explains the code below under **Turn off the optimiser (Compiler)**

## Benchmarking tools
### Googles Micro benchmark library
* [GitHub](https://github.com/google/benchmark)
* use for measuring the performance of simple functions.

## Clang Tidy

## CPP Check
cppcheck http://cppcheck.sourceforge.net/

## Fast dirty in-code hacks
Sometimes it is just faster for you to have some small debug functions storing and printing metrics like memory usage or time instead of installing and using third party software. 

### Track heap allocations
```c_cpp
// define global
struct AllocationMetrics{
	bool print = false;
	uint32_t total_allocated = 0;
	uint32_t total_freed = 0;
	uint32_t currentUsage(){
	    return total_allocated - total_freed;
	}
};
static AllocationMetrics ALLOC_METRIC;
 
void* operator new(size_t size){
    ALLOC_METRIC.total_allocated += size;
    return malloc(size);
}
void operator delete(void *memory, size_t size){
    ALLOC_METRIC.total_freed += size;
    free(memory);
}
```
- [The video explaining the code](https://www.youtube-nocookie.com/embed/sLlGEUO_EGE?rel=0&start=230&end=782) *~9 min.*

### Turn off the optimiser (Compiler)
* does not work on Microsoft compiler
```c_cpp
// Tell the compiler that the given data might be written into a global variable
static void escape(void *p) {
	// asm: https://en.cppreference.com/w/cpp/language/asm
	// volatile: Tell the compiler, that this code has an unknowable side effect and mustn't be optimised away.
	// but we lied, it doesn't
	asm volatile("" : : "g"(p) : "memory");
}

// Tell the compiler that we might have written every bit of data in the memory
static void clobber() {
	asm volatile("" : : : "memory");
}

// assuming we do some benchmarking
static void bench_create(benchmark::State &state) {
	while (state.KeepRunning()) {
		std::vector<int> v;
		// Lie: we need to write the data into somewhere else.
		escape(&v);
	}
}
BENCHMARK(bench_create);

static void bench_reserve(benchmark::State &state) {
	while (state.KeepRunning()) {
		std::vector<int> v;
		v.reserve(1);
		// Lie: we need to write the data into somewhere else.
		escape(v.data());
	}
}
BENCHMARK(bench_reserve);

static void bench_push_back(benchmark::State &state) {
	while (state.KeepRunning()) {
		std::vector<int> v;
		v.reserve(1);
		// Lie: we need to write the data into somewhere else.
		escape(v.data());
		v.push_back(42);
		// Lie: We need to read the data
		clobber();
	}
}
BENCHMARK(bench_push_back);
```

## perf (performance event counter)
// TODO
* you need to build your code with the flag `-fno-omit-frame-pointer` to have the function stack available for perf
* `perf record -g ./yourProgram`
* `perf report -g 'graph,0.5,caller'`

## quick-bench.com
This site allows you to compare different versions of your algorithm.
- [IIFE example with std::string](https://www.youtube-nocookie.com/embed/d4nmNYTM1j8?rel=0) *~5 min.*

## Valgind
- [address sanitizer, memory sanitizer, visualise which functions do the most work](https://www.youtube-nocookie.com/embed/3l0BQs2ThTo?rel=0) *~8 min.*

## Visual Studio
- [Semi-Automatic `constexpr` and `noexcept`](https://www.youtube-nocookie.com/embed/1FAcPvb0ZjU?rel=0) *~4 min.*
