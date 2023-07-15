using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day04
{
    public class Solution
    {
        public static string Part1(List<string> input)
        {
            int count = 0;
            foreach (var line in input)
            {
                var (leftString, rightString, _) = line.Split(",").ToList();
                var leftRange = leftString.Split("-").Select(int.Parse).ToArray();
                var rightRange = rightString.Split("-").Select(int.Parse).ToArray();
                bool isRightContainedInLeft = leftRange[0] <= rightRange[0] && leftRange[1] >= rightRange[1];
                bool isLeftContainedInRight = rightRange[0] <= leftRange[0] && rightRange[1] >= leftRange[1];
                if (isRightContainedInLeft ||  isLeftContainedInRight)
                {
                    count++;
                }
            }
            return count.ToString();
        }

        public static string Part2(List<string> input)
        {
            int count = 0;
            foreach (var line in input)
            {
                var (leftString, rightString, _) = line.Split(",").ToList();
                var leftRange = leftString.Split("-").Select(int.Parse).ToArray();
                var rightRange = rightString.Split("-").Select(int.Parse).ToArray();
                bool rangesOverlap =
                    leftRange[1] >= rightRange[0] && rightRange[1] >= leftRange[0] ||
                    rightRange[1] >= leftRange[0] && leftRange[1] >= rightRange[0];
                if (rangesOverlap) { count++; }
            }
            return count.ToString();
        }
    }
}
