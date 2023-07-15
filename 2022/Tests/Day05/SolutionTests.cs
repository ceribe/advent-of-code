using Microsoft.VisualStudio.TestTools.UnitTesting;
using Solutions.Day05;

namespace Tests.Day05
{
    [TestClass()]
    public class SolutionTests
    {
        [TestMethod()]
        public void Part1Test1()
        {
            var text = Utils.ReadInput("input_test", "05");
            Assert.AreEqual("CMZ", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part1Test2()
        {
            var text = Utils.ReadInput("input", "05");
            Assert.AreEqual("TLNGFGMFN", Solution.Part1(text));
        }

        [TestMethod()]
        public void Part2Test1()
        {
            var text = Utils.ReadInput("input_test", "05");
            Assert.AreEqual("MCD", Solution.Part2(text));
        }

        [TestMethod()]
        public void Part2Test2()
        {
            var text = Utils.ReadInput("input", "05");
            Assert.AreEqual("FGLQJCMBD", Solution.Part2(text));
        }
    }
}