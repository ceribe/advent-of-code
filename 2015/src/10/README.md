# [Day 10: Elves Look, Elves Say](https://adventofcode.com/2015/day/10)

This day was surprisingly easy.
To solve both parts I wrote a transform function (e.g. "21" => "1211") and applied it
X times. Transform function has two parts. First split sequence into an array
of strings of repeating characters ("112322" => ["11", "2", "3", "22"]) and then reduce that
array creating a new sequence.
