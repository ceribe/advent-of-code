using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day08;

namespace Tests.Day08
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "08");
            Assert.AreEqual("21", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "08");
            Assert.AreEqual("1845", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "08");
            Assert.AreEqual("8", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "08");
            Assert.AreEqual("230112", Solution.Part2(text));
        }
    }
}