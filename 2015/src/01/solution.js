import { check, readFirstLine } from "../utils.js";

function part1(input) {
  return input
    .split("")
    .map((char) => (char === "(" ? 1 : -1))
    .sum();
}

function part2(input) {
  let floor = 0;
  const chars = input.split("");
  for (let idx = 0; idx < chars.length; idx++) {
    chars[idx] === "(" ? floor++ : floor--;
    if (floor === -1) return idx + 1;
  }
}

const input = readFirstLine("01", "input.txt");

check(0, part1("(())"));
check(0, part1("()()"));
check(3, part1("((("));
check(3, part1("(()(()("));
check(3, part1("))((((("));
check(-1, part1("())"));
check(-1, part1("))("));
check(-3, part1(")))"));
check(-3, part1(")())())"));
console.log("Part 1: " + part1(input)); // 280

check(1, part2(")"));
check(5, part2("()())"));
console.log("Part 2: " + part2(input)); // 1797
