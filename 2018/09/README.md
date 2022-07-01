This was a very interesting day. At first it looked like a similiar problem to [2016/19](https://adventofcode.com/2016/day/19) so I decided
to treat it the same way. I wrote an ineffective solution to generate the first 1000 steps and tried to analyze it, but no
pattern was emerging. As it turns out there was no pattern and the proper way to solve this task was to just iterate through all the steps, but using
a better data structure than List. During a quick google search I couldn't find whether Dart has a Circular Linked List (which allows rotating) or not, so I decided to implement my own.