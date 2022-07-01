At first, I tried to bruteforce part 1, but it worked too slow, so I decided to find all
divisors for each house and basing on that calculate presents.

Part two made that approach useless, but made bruteforce viable. Elves are represented
as a map where key is elf's number and value is number of houses it has left to visit.
For each house I would check all the elves in set and add presents basing in their numbers. When
elf has 0 left it is deleted from set. This solution is extremely slow (it took about 20 minutes
to find the number), but was easy to write. If the given input number was bigger this would not
work because of map's size limit.
