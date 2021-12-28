Solution for part 1 is to create an array of instructions from input file.
Then for each instruction and for each light of this instruction perform said instruction.
Information about which lights are 'on' are stored in a set. Thanks to the fact that set is unique
the only step left is to get number of elements in set. Solution is in no way optimal, but works
fast anyway so there is no need to improve it. If there were significantly more than 1 000 000 possible lights then
information about which lights are 'on' would need to be stored as ranges.

Solution for part 2 is almost the same, but set was replaced by map which stores the light level.
I decided to initialize the map with all possible light, so I don't have to check if a light is already in map
or not when processing instructions. This step could be skipped, but since it has almost no impact on performance
there is no need.
