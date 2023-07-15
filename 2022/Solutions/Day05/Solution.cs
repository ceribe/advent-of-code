using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day05
{
    public class Solution
    {
        private static (List<string>, Dictionary<string, List<char>>) ParseInput(List<string> input)
        {
            var towersInput = input.TakeWhile(x => x != "").ToList();
            var instructions = input.SkipWhile(x => x != "").Skip(1).ToList();
            int maxHeight = towersInput.Last().Count();
            var towers = new Dictionary<string, List<char>>();

            var index = 0;
            var towerNumber = 1;

            while (index < maxHeight)
            {
                if (towersInput.Last()[index] != ' ')
                {
                    towers[towerNumber.ToString()] = new List<char>();
                    for (int i = towersInput.Count - 2; i >= 0; i--)
                    {
                        if (towersInput[i][index] != ' ')
                        {
                            towers[towerNumber.ToString()].Add(towersInput[i][index]);
                        }
                    }
                    towerNumber++;
                }
                index++;
            }

            return (instructions, towers);
        }

        public static string Part1(List<string> input)
        {
            var (instructions, towers) = ParseInput(input);
            foreach (var instruction in instructions)
            {
                var words = instruction.Split(' ');
                int count = int.Parse(words[1]);
                var fromTower = words[3];
                var toTower = words[5];

                for (int i = 0; i < count; i++)
                {
                    towers[toTower].Add(towers[fromTower].Last());
                    towers[fromTower].RemoveAt(towers[fromTower].Count - 1);
                }
            }
            return string.Join("", towers.Select(x => x.Value.Last()));
        }

        public static string Part2(List<string> input)
        {
            var (instructions, towers) = ParseInput(input);
            foreach (var instruction in instructions)
            {
                var words = instruction.Split(' ');
                int count = int.Parse(words[1]);
                var fromTower = words[3];
                var toTower = words[5];

                towers[toTower] = towers[toTower].Concat(towers[fromTower].TakeLast(count)).ToList();
                towers[fromTower].RemoveRange(towers[fromTower].Count - count, count);
            }
            return string.Join("", towers.Select(x => x.Value.Last()));
        }
    }
}
