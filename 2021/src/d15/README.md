# [Day 15: Chiton](https://adventofcode.com/2021/day/15)

At first this day appeared to be a bit of a challenge, but after a while
it became much easier. My initial solution was pure bruteforce and would
solve the problem in about 20s which was not that bad, but it could have
been much faster. Then I tried to change it to BFS/DFS, but both worked
way slower than the brute force solution and required me to use a 
DeepRecursiveFunction. After that I decided to try a priority queue.
As it turns out it was the correct solution, because now the answer
is calculated almost instantly.