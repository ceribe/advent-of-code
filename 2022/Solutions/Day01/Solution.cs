using System.Collections.Generic;
using System.Linq;

namespace Solutions.Day01
{
    public class Solution
    {
        private static List<List<int>> ParseInput(List<string> input)
        {
            List<List<int>> list = new();
            List<int> tempList = new();
            foreach (var elem in input)
            {
                if (elem == "")
                {
                    list.Add(tempList);
                    tempList = new List<int>();
                }
                else
                    tempList.Add(int.Parse(elem));
            }

            if (tempList.Count > 0)
                list.Add(tempList);

            return list;
        }

        public static string Part1(List<string> input)
        {
            var list = ParseInput(input);
            return list
                .Select((elem, _) => elem.Sum())
                .Max()
                .ToString();
        }

        public static string Part2(List<string> input)
        {
            var list = ParseInput(input);
            return list
                .Select((elem, _) => elem.Sum()).ToList()
                .OrderByDescending(i => i)
                .Take(3)
                .Sum()
                .ToString();
        }
    }
}
