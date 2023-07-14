using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day01;

namespace Tests.Day00
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "00");
            Assert.AreEqual(0, Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "00");
            Assert.AreEqual(0, Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "00");
            Assert.AreEqual(0, Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "00");
            Assert.AreEqual(0, Solution.Part2(text));
        }
    }
}