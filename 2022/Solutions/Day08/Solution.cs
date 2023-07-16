using System.Collections.Generic;

namespace Solutions.Day08
{
    public class Solution
    {
        static int[][] ParseInput(List<string> input)
        {
            int[][] result = new int[input.Count][];

            for (int i = 0; i < input.Count; i++)
            {
                result[i] = new int[input[i].Length];

                for (int j = 0; j < input[i].Length; j++)
                {
                    result[i][j] = int.Parse(input[i][j].ToString());
                }
            }
            return result;
        }

        public static string Part1(List<string> input)
        {
            var trees = ParseInput(input);
            var visibleTrees = new HashSet<string>();
            var height = input.Count;
            var width = input[0].Length;

            // Yeah I know this is ugly and breaks DRY but i'm too lazy to make it better. It's not production code anyway.
            // Best way would be to make it a function and apply some kind of transformation so the 4 for loop can be generalised.
            for (int y = 0; y < height; y++)
            {
                var currentMaxTreeHeight = -1;
                for (int x = 0; x < width; x++)
                {
                    var treeHeight = trees[y][x];
                    if (treeHeight > currentMaxTreeHeight)
                    {
                        visibleTrees.Add($"{x},{y}");
                        currentMaxTreeHeight = treeHeight;
                    }
                }
            }

            for (int y = 0;y < height; y++)
            {
                var currentMaxTreeHeight = -1;
                for (int x = width - 1; x >=0; x--)
                {
                    var treeHeight = trees[y][x];
                    if (treeHeight > currentMaxTreeHeight)
                    {
                        visibleTrees.Add($"{x},{y}");
                        currentMaxTreeHeight = treeHeight;
                    }
                }
            }

            for (int x = 0; x < width; x++)
            {
                var currentMaxTreeHeight = -1;
                for (int y = 0; y < height; y++)
                {
                    var treeHeight = trees[y][x];
                    if (treeHeight > currentMaxTreeHeight)
                    {
                        visibleTrees.Add($"{x},{y}");
                        currentMaxTreeHeight = treeHeight;
                    }
                }
            }

            for (int x = 0; x < width; x++)
            {
                var currentMaxTreeHeight = -1;
                for (int y = height - 1; y >= 0; y--)
                {
                    var treeHeight = trees[y][x];
                    if (treeHeight > currentMaxTreeHeight)
                    {
                        visibleTrees.Add($"{x},{y}");
                        currentMaxTreeHeight = treeHeight;
                    }
                }
            }

            return visibleTrees.Count.ToString();
        }

        public static string Part2(List<string> input)
        {
            var trees = ParseInput(input);
            var height = input.Count;
            var width = input[0].Length;

            int CalculateScenicScore(int treeX, int treeY)
            {
                var mainTreeHeight = trees[treeY][treeX];
                var totalScenicScore = 1;

                var numberOfSeenTrees = 0;
                for (int y = treeY - 1; y >= 0; y--)
                {
                    var treeHeight = trees[y][treeX];
                    numberOfSeenTrees++;
                    if (treeHeight >= mainTreeHeight)
                        break;
                }
                totalScenicScore *= numberOfSeenTrees;

                numberOfSeenTrees = 0;
                for (int y = treeY + 1; y < height; y++)
                {
                    var treeHeight = trees[y][treeX];
                    numberOfSeenTrees++;
                    if (treeHeight >= mainTreeHeight)
                        break;
                }
                totalScenicScore *= numberOfSeenTrees;

                numberOfSeenTrees = 0;
                for (int x = treeX - 1; x >= 0; x--)
                {
                    var treeHeight = trees[treeY][x];
                    numberOfSeenTrees++;
                    if (treeHeight >= mainTreeHeight)
                        break;
                }
                totalScenicScore *= numberOfSeenTrees;

                numberOfSeenTrees = 0;
                for (int x = treeX + 1; x < width; x++)
                {
                    var treeHeight = trees[treeY][x];
                    numberOfSeenTrees++;
                    if (treeHeight >= mainTreeHeight)
                        break;
                }
                totalScenicScore *= numberOfSeenTrees;

                return totalScenicScore;
            }

            var maxScenicScore = 0;

            for (int y = 1; y < height - 1; y++)
            {
                for (int x = 1; x < width - 1; x++)
                {
                    var scenicScore = CalculateScenicScore(x, y);
                    if (scenicScore > maxScenicScore)
                        maxScenicScore = scenicScore;
                }
            }

            return maxScenicScore.ToString();
        }
    }
}
