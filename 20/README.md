Part 1: Not much to say as it was trivial. Try a number if it is inside some range then
change that number to that range's max + 1 and try again until that number isn't inside any
of the ranges.

Part 2: This task was a nice remainder of [Day 22 from 2021](https://adventofcode.com/2021/day/22), but instead of a 3D reactor
here it was a 2D range. The main idea is to add ranges to a collection one by one and when
a range is added check if any of the ranges have any intersections with this range. If yes
then add those intersections too but with an inverted sign (like in Venn diagram where you have
to subtract shared values). After adding all the ranges to a collection the only thing left
is to calculate their sum by adding all positive ranges and subtracting negative ones.