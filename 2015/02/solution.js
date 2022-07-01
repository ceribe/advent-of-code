import { check, readInput } from "../utils.js";

function part1(input) {
  return input
    .map((dims) => {
      let [x, y, z] = dims
        .split("x")
        .map((a) => parseInt(a))
        .sortNumbers();
      return 2 * (x * y + y * z + z * x) + x * y;
    })
    .sum();
}

function part2(input) {
  return input
    .map((dims) => {
      let [x, y, z] = dims
        .split("x")
        .map((a) => parseInt(a))
        .sortNumbers();
      return 2 * x + 2 * y + x * y * z;
    })
    .sum();
}

const testInput = readInput("02", "input_test.txt");
const input = readInput("02", "input.txt");

check(101, part1(testInput));
console.log("Part 1: " + part1(input)); // 1588178

check(48, part2(testInput));
console.log("Part 2: " + part2(input)); // 3783758
