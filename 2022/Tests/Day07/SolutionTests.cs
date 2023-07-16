using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day07;

namespace Tests.Day07
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "07");
            Assert.AreEqual("95437", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "07");
            Assert.AreEqual("1582412", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "07");
            Assert.AreEqual("24933642", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "07");
            Assert.AreEqual("3696336", Solution.Part2(text));
        }
    }
}