At first, I wanted to use bruteforce by generating all possible combinations and finding the best one
but, I quickly realised that it extremely slow (about O(n!)). This solution assumes that if
I find a combination of presents which sum is equal to total/number_of_groups then it is
a valid group 1 (eg finding group 2 and 3 is possible). With this assumption task got a 
lot easier. Algorithm finds combinations of presents with length x (2 to infinity) and when it finds a possible
length it calculates quantum entanglement of all those combinations and returns the best one.
