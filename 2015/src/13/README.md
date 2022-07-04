# [Day 13: Knights of the Dinner Table](https://adventofcode.com/2015/day/13)

Once again part 1 was divided into two problems:

- Parsing the given file
- Calculating max total happiness

I decided to parse the file and store data as a map of happiness for each person.
`map.get("Bob").get("Alice)` would return the happiness Bob would gain when sitting next to Alice.
Then using map's keys I generated all possible permutations and counted total happiness for all of them.

Part 2 required little to no change. I only had to insert new person with values 0 and calculate
total happiness using functions written for part 1.
