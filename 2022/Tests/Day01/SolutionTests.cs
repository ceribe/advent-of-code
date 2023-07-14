using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day01;

namespace Tests.Day01
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "01");
            Assert.AreEqual("24000", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "01");
            Assert.AreEqual("70698", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "01");
            Assert.AreEqual("45000", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "01");
            Assert.AreEqual("206643", Solution.Part2(text));
        }
    }
}