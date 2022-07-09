# [Day 19: Medicine for Rudolph](https://adventofcode.com/2015/day/19)

First part was quite straightforward. Check all possible replacements and count the number
of unique molecules.

Part two is where it got interesting. Creating a molecule from "e" was not realistic,
because of the number of possible replacements along the way. To deal with this I went the other
way. Instead of creating a molecule I used replacements in the inverse direction to get "e".
This drastically reduced search space, but sadly not enough. I decided to add a counter. If
recursive search finds a way to get to "e" 10000 times then it would most likely have found the shortest
solution already. It's not guaranteed that it will, but if it won't then increasing the counter
will help. It is by no way an optimal or even a good solution, but it works well enough.
