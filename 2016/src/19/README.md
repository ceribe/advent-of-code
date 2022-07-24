Part 1 is explained in this video: https://www.youtube.com/watch?v=uCsD3ZGzMgE

Part 2 works in a similar way. To solve it I wrote an ineffective O(n²) solution and
run it for values from 2 to 100 to find a pattern. After looking at the results the pattern
is quite obvious. Winning elf's number for given n is always n - smaller_than_n_power_of_3.
This can be observed for values 3, 9, 27 and 81. After those values the result number restarts.
For example for n=45 the answer is 18 because 45 - 27 = 45 - 3³ = 18, and it goes all they way
up to 81 where result is 54 (85 - 27 = 54). For 82 the result is 1 because now the
smaller_than_n_power_of_3 is equal to 81.