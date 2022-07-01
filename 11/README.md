It was an interesting day. Part one was trivial, write a function calculating the power level
and iterate over the grid to find the power level of the cell with the highest power level.
Simple and quick O(n^2) solution. I was fully expecting that this solution will not work for part 2
and I was not disappointed. After adding the nessesary changes I realised that if I would let it run for all sizes (1 to 300)
it would never finish as it's O(n^5) so I needed a different strategy. After printing out the grid I realised that most of the values
were negative so there is no way that bigger cells would have a higher power level. I decided to cap
the size on some arbitrary value and just run it. Not long after I got the result and it was a correct
answer.