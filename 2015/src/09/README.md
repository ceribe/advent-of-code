# [Day 9: All in a Single Night](https://adventofcode.com/2015/day/9)

To solved part 1 I created a map of all possible connections with their costs.
Then for each city (map keys) recursively tried each route starting in that city.
During each recursive call function checks to which city can santa go and if that city was
not yet visited then santa goes there. When size of list of visited cities is equal to the number
of cities that means each city was visited. If the cost was lower than current lowest cost
that cost becomes the current lowest.

Part 2 required only to change min to max.
