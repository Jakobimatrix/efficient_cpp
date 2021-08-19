[root](../README.md) / talks.md
# Talks
A list of long talks which fit multiple criteria. I summarised each talk so you can see, if you are interested in listening to the full version. In general every talk in this list is not a waste of time to listen to multiple times.

## CppCon 2014: Chandler Carruth "Efficiency with Algorithms, Performance with Data Structures"

* [link](https://www.youtube-nocookie.com/embed/fHNmRkzxHWs?rel=0) *~55 min. + Questions*
* It is supposed to be a intro talk.
* Why should you care about good performance?
	* Software is getting slower.
	* Run the software faster to safe energy (by sending the CPU to sleep faster and for longer)
	* *'C++ Doesn't give you performance. It gives you control over performance.'*
	* *'Efficiency through Algorithms'*
		* Let the work for the CPU to be minimal
		* Put the most effort (working time) into these algorithms
		* Know existing [algorithms](../algorithms/algorithms.md) (std, boost, ...)
		* Know the [basics](../basics/basics.md)
	* *'Performance through Data Structures'*
		* Do things faster (make the most of the given hardware)
* Data structures
	* Don't use discontinuous data structures (std::list)
	* claim: std::map is even worse than std::list
		* is just a linked list, oriented as a binary tree.
		* insert/remove/rebalanceing needs traversal
		* The same goes for unordered_map
* Data structures and Algorithms are intertwined
	* keep in mind that a fast algorithm using a bad data structure might be slower than a slow algorithm using a fast structure
	* *'worse is better'*

## CppCon 2016: Chandler Carruth “High Performance Code 201: Hybrid Data Structures"
* [link](https://www.youtube-nocookie.com/embed/vElZc6zSIXM?rel=0) *~38 min.*
* LLVM (Low Level Virtual Machine)
* [GitHub](https://github.com/llvm/llvm-project//)
* [Doku](https://llvm.org/docs/ProgrammersManual.html)
* its about vector, sets and maps
* llvm::SmallVector, * llvm::smallSet
	* `llvm::SmallVector<std::unique_ptr<BigObject>, 4> Objects;`
	* [Doku](https://llvm.org/docs/ProgrammersManual.html#llvm-adt-smallvector-h)
	* [BOOST has an implementation too](https://www.boost.org/doc/libs/1_72_0/doc/html/container/non_standard_containers.html#container.non_standard_containers.small_vector)
* use tight bit packing
	* honestly that part was to high for my brain
		* use pointers as Identity?
* use bit-fields