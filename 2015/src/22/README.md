# [Day 22: Wizard Simulator 20XX](https://adventofcode.com/2015/day/22)

Solution is quite long, but was easy to write. Recurrent function is called for all possible
ways the battle could go and each one is checked to find the best one. If fight was longer
(eg. boss has more HP) this solution would not be viable, because search space would be too big.
