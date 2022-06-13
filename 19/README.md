Another year, another assembly translation task.
Part 1 was trivial, use the previously written code for day 16 and get the result.
Part 2 as expected would never finish when run. So as always, I
decided to translate the assembly to pseudocode and iteratively make
it more readable by changing stuff like jumps to loops/ifs.
After reading the pseudocode it was easy to see that the program
just sums all the factors of the number at register 5 (including 1 and
that number). Because solution for part 2 was calulated by hand, 
if you run the program for your input it won't give the correct answer.
To see the correct answer check what value is at register 5 after about 30 iterations
and just add up factors of that value.