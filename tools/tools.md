[root](../README.md) / Tools.md
# Tools
## Introduction
Optimisation from hand is very pain full and inefficient. Especially if you did not write the code. Use tools to 

- see where optimisation is really needed
- see what kind of optimisation is needed
- find possible optimisations automatically


## Clang Tidy

## CPP Check
cppcheck http://cppcheck.sourceforge.net/

## Fast dirty in-code hacks
Sometimes it is just faster to have some small debug functions storing and printing metrics like memory usage or time instead of installing and using third party software. 
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

## Valgind
- [address sanitizer, memory sanitizer, visualise which functions do the most work](https://www.youtube-nocookie.com/embed/3l0BQs2ThTo?rel=0) *~8 min.*

## Visual Studio
- [Semi-Automatic `constexpr` and `noexcept`](https://www.youtube-nocookie.com/embed/1FAcPvb0ZjU?rel=0) *~4 min.*
