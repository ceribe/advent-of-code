using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day02
{
    public class Solution
    {
        public static string Part1(List<string> input)
        {
            var pointsMap = new Dictionary<string, int>
            {
                {"A X", 4},
                {"A Y", 8},
                {"A Z", 3},
                {"B X", 1},
                {"B Y", 5},
                {"B Z", 9},
                {"C X", 7},
                {"C Y", 2},
                {"C Z", 6}
            };

            return input.Select((elem) => pointsMap[elem]).Sum().ToString();
        }

        public static string Part2(List<string> input)
        {
            var pointsMap = new Dictionary<string, int>
            {
                {"A X", 3},
                {"A Y", 4},
                {"A Z", 8},
                {"B X", 1},
                {"B Y", 5},
                {"B Z", 9},
                {"C X", 2},
                {"C Y", 6},
                {"C Z", 7}
            };

            return input.Select((elem) => pointsMap[elem]).Sum().ToString();
        }
    }
}
