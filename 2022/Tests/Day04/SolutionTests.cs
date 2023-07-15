using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day04;

namespace Tests.Day04
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "04");
            Assert.AreEqual("2", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "04");
            Assert.AreEqual("464", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "04");
            Assert.AreEqual("4", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "04");
            Assert.AreEqual("770", Solution.Part2(text));
        }
    }
}