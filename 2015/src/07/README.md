# [Day 7: Some Assembly Required](https://adventofcode.com/2015/day/7)

Solution for part 1 is to create an array of operations from input file.
Each variable's value is stored in map (a -> 1, b -> 2, etc...). Then as long as 'a' is not yet in map check which operation can be performed and perform it by adding its result to map and removing used operation from array.
Thanks to JS's type system arg1 and arg2 of operation can be either a numeric value or a variable.
Operation is active if all of its arguments are numbers or variables which values are already in map.

There was no need to write any code for part 2. Simply change "14146 -> b" located on line 90 of input.txt to "956 -> b" and run program again.
