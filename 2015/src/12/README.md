# [Day 12: JSAbacusFramework.io](https://adventofcode.com/2015/day/12)

Part 1 made it easy to just skip all the JSON stuff and instead pick all the numbers from
string adding them, so that's what I did.

Part 2 sadly required to actually parse the string and discard all objects where any value
is equal to "red". I decided to write a recursive function which would first check the type
of argument and proceed accordingly. If it was an Array then call itself recursively, if it was
a number, then add this number to total sum. If argument was an object function would first
check if any of its values are "red" and if not then call itself recursively for each value.
