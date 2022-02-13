Once again part 1 was trivial, so I will not write about it.

Part 2 was easier to solve by hand instead of trying to translate instructions to
multiplication. After running the same code as in part 1 and printing each register before
each step I realised that all it is doing is calculating power of 12, but sadly
that was not the answer. As each input is personalized there had to be some additional
code executed after calculating power of 12. After looking at the input these two lines were
standing out:
```
cpy 87 c
jnz 80 d
```
As jnz made no sense here it must have been toggled to cpy. Assuming that was true
I looked at the following input lines
```
inc a
inc d
jnz d -2
inc c
jnz c -5
```
"inc d" and "inc c" made no sense as code would never finish, so I also assumed that they
have been toggled. After making all the assumptions the lines looked like this:
```
cpy 87 c
cpy 80 d
inc a
dec d
jnz d -2
dec c
jnz c -5
```
This code increases "a" by 80 * 87 and then finishes so the answer is 12! + 80 * 87.