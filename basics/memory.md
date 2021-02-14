[root](../../README.md) / [basics](../basics.md) / memory.md
# Memory
To write fast executing code, you must understand how memory works.
**In a nutshell: Keep your current used Data continuous packed and small, such that it fits in L1 Cache.** 

But first, a table:
* [source](http://norvig.com/21-days.html#answers)

| Process | time | reference |
| :---        |    ----:   |          :--- |
|L1 cache reference                                               |   0.5 ns||
|Branch mispredict                                                |    5   ns||
|L2 cache reference                                               |    7   ns |         14x L1 cache|
|Mutex lock/unlock                                                |    25   ns|
|Main memory reference                                       |    100   ns |          20x L2 cache, 200x L1 cache|
|Compress 1K bytes with Zippy                            |     3,000   ns    ||
|Send 1K bytes over 1 Gbps network                     |   10,000   ns   ||
|Read 4K randomly from SSD*                               |   150,000   ns  |    ~1GB/sec SSD|
|Read 1 MB sequentially from memory                 |   250,000   ns  ||
|Round trip within same datacenter                      |    500,000   ns   ||
|Read 1 MB sequentially from SSD*                       |  1,000,000   ns   |  ~1GB/sec SSD, 4X memory|
|Disk seek                                                               |   10,000,000   ns  |  20x datacenter roundtrip|
|Read 1 MB sequentially from disk                         |  20,000,000   ns  |  80x memory, 20X SSD|
|Send packet send packet US to Europe and back |  150,000,000   ns  ||

# Cache
// TODO


# Ram
// TODO

