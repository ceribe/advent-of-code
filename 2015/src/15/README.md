# [Day 15: Science for Hungry People](https://adventofcode.com/2015/day/15)

In this task I decided to parse each line of input file as an instance of Ingredient class
and then check each possible combination of ingredients to find the best one. To do that
I recursively called "go" function which would first check if it has all the quantities of ingredient
and if not it would call itself for each possible amount of ingredients. For example on the first call
I have so far picked 0 total ingredients, so it will call itself 101 times each time adding a
different amount of said ingredient. Then let's say my quantities so far are 22 and 45. Then current
total amount is 67 which means I can pick 33 more teaspoons of ingredients which means function will
call itself 34 times (0 to 33). After reaching the required amount of ingredients I check
if the score for this combination is higher than current and update current.

For part 2 the only change required was adding second variable to track score for combinations
with 500 calories.

It is once again a brute force solution, but since the search space was small enough there was
no need to optimise it. If number of ingredients or total number of teaspoons was bigger (let's say 10_000 teaspoons)
then I would need to implement some kind of linear optimisation algorithm.
