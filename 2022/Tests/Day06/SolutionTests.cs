using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day06;
using System;
using System.Collections.Generic;
using static System.Net.Mime.MediaTypeNames;

namespace Tests.Day06
{
    [TestClass()]
    public class SolutionTests
    {
        private readonly Dictionary<string, (string, string)> testInputs = new()
        {
            {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", ("7", "19")},
            {"bvwbjplbgvbhsrlpgdmjqwftvncz", ("5", "23")},
            {"nppdvjthqldpwncqszvftbrmjlhg", ("6", "23")},
            {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", ("10", "29")},
            {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", ("11", "26")}
        };

        [TestMethod()]
        public void Part1Test1()
        {
            foreach (var (text, (output, _)) in testInputs)
            {
                Assert.AreEqual(output, Solution.Part1And2(text, 4));
            }
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadFirstLine("input", "06");
            Assert.AreEqual("1766", Solution.Part1And2(text, 4));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            foreach (var (text, (_, output)) in testInputs)
            {
                Assert.AreEqual(output, Solution.Part1And2(text, 14));
            }
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadFirstLine("input", "06");
            Assert.AreEqual("2383", Solution.Part1And2(text, 14));
        }
    }
}