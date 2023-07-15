using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day03;

namespace Tests.Day03
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "03");
            Assert.AreEqual("157", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "03");
            Assert.AreEqual("7824", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "03");
            Assert.AreEqual("70", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "03");
            Assert.AreEqual("2798", Solution.Part2(text));
        }
    }
}