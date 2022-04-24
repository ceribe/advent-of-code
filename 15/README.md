I have read about this day long time before even starting Advent 2018 and it lived up to it's fame.
It was a really interesting task, but at the end it was a bit tedious. There was so many small details that
had to be done perfectly or the whole thing didn't work. Part 1 took me about 3h + 2 more to find
why the test inputs work, but the real one does not. As it turns out using A* was a mistake and a simple BFS
would be sufficient. A* was problematic, because I used the wrong heurestic. Due to this mistake A* was sometimes
not finding the most optimal solution. Part 2 was trivial as the only thing i needed to do was to contiuously
increase elves damage and check if none of the elves died.