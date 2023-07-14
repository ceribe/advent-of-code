using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Tests
{
    internal class Utils
    {
        public static List<string> ReadInput(string filename, string day)
        {
            return File.ReadLines($"../../../Day{day}/{filename}.txt").ToList();
        }

        public static string ReadFirstLine(string filename, string day)
        {
            return File.ReadLines($"../../../Day{day}/{filename}.txt").First();
        }
    }
}
