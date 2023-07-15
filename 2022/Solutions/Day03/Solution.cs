using System;
using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day03
{
    public class Solution
    {
        private static int CalculatePriority(char c)
        {
            return c - (char.IsUpper(c) ? 'A' - 27 : 'a' - 1);
        }

        public static string Part1(List<string> input)
        {
            return input.Select((line) =>
            {
                var firstCompartment = line.Take(line.Length / 2);
                var secondCompartment = line.Skip(line.Length / 2);
                return firstCompartment.Intersect(secondCompartment).Select(CalculatePriority).Sum();
            }).Sum().ToString();
        }

        public static string Part2(List<string> input)
        {
            int sum = 0;
            foreach(var line in input.Chunk(3))
            {
                var commonChar = line[0].Intersect(line[1]).Intersect(line[2]).First();
                sum += CalculatePriority(commonChar);
            }
            return sum.ToString();
        }
    }
}
