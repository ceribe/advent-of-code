using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day02;

namespace Tests.Day02
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "02");
            Assert.AreEqual("15", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "02");
            Assert.AreEqual("9651", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "02");
            Assert.AreEqual("12", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "02");
            Assert.AreEqual("10560", Solution.Part2(text));
        }
    }
}