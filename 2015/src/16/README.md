# [Day 16: Aunt Sue](https://adventofcode.com/2015/day/16)

In this task I decided to parse each line of input file as an instance of Sue class.
Then each aunt object was checked against known traits. Trait checking could be done better
for example by reading known traits from a file and then checking them all
in a loop instead of copy pasting.

Part two required only to change inequality check to a greater/fewer than or equal check.
