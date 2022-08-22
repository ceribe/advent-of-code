# [Day 11: Radioisotope Thermoelectric Generators](https://adventofcode.com/2016/day/11)

Finally, a hard and exciting day. I decided to go the semi-bruteforce way as it was
the first thing that I thought of. My solution recursively searches the possible states and remembers them in a set,
so it will not loop infinitely. From each state recursive function tries to do all possible
moves. Then, if a move is not possible, was visited before or number of steps is higher
than current min this state is ignored. Eventually the whole space is searched and optimal
solution found. Most likely even more states could be discarded so search space would grow
more slowly, but since this solution worked fast enough (part 1: 1s, part 2: 20s) there was no need
to improve it.