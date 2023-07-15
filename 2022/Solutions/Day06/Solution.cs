using System.Linq;

namespace Solutions.Day06
{
    public class Solution
    {

        private static bool IsUnique(string text)
        {
            return text.ToHashSet().Count == text.Length;
        }

        public static string Part1And2(string input, int numberOfChars)
        {
            for (int i = 0; i < input.Length - numberOfChars + 1; i++)
            {
                if (IsUnique(input.Substring(i, numberOfChars)))
                {
                    return (i + numberOfChars).ToString();
                }
            }
            return "Impossible";
        }
    }
}
