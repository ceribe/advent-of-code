# [Day 23: Experimental Emergency Teleportation](https://adventofcode.com/2018/day/23)

After reading part 2 I thought that it is insanely difficult and I couldn't find a way to solve it.
As it turns out, I was wrong and it was quite easy after coming up with the solution. There is probably
a better way to do this since mine is not guaranteed to find the optimum. My solution is based on binary
search. In each iteration best position is moved by gradually smaller distances. I'm almost sure that
this would not work for all inputs, but I was lucky enough that it worked for mine.
