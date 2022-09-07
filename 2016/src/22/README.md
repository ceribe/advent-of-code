# [Day 22: Grid Computing](https://adventofcode.com/2016/day/22)

Part 2 looked quite complicated, but turned out to be not that hard after some thinking. Task consists of
two parts. Moving empty node to (maxX, 0) and then moving data towards (0, 0). Each move
costs 5 (blank node needs to be placed in front of data after every move). Additionally,
big nodes (bigger than blank node's capacity) seem to always form a wall. So to move 
blank node it needs to go around the wall.
Formula calculating how many steps are needed looks like this:\
``y + height - x - 1 + (x-(height-wallsCount)+1)*2 + 5 * (height - 2)``

x, y - blank node's position\
height - maximum X of nodes + 1 (because of zero-indexing)\
wallsCount - number of nodes which are bigger than blank node's capacity

Formula splits into three parts:
- Part 1\
``y + height - x - 1`` - how many steps are needed to move blank to data (not counting the wall)
- Part 2\
``(x-(height-wallsCount)+1)*2`` - how many steps are needed to move blank node around the wall
- Part 3\
``5 * (height - 2)`` - how many steps are needed to move data to (0, 0)

This solution makes a lot of assumptions. Mainly that big nodes are always forming a wall
and that there is no walls on data node's path.