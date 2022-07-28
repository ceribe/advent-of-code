# [Day 21: Chronal Conversion](https://adventofcode.com/2018/day/21)

I was quite surprised to see another assembly translation challenge.
As usual I translated assembly in steps. First I translated the instructions to pseudocode
then translated jumps to ifs and whiles. Then I translated the pseudocode to python. At this point
I could get solution for part 1. To solve part 2 I slightly optimized the code and added a set
which would check if number was already seen. After having the solution ready I translated
it to Dart. To see the solution for part 2 you need to uncomment a function call, because running
the program for part 2 never terminates it and prints are so fast that it is not possible to see
the output for part 1.
