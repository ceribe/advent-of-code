import { check } from "../utils.js";

function transform(sequence) {
  return sequence
    .match(/(.)\1*/g)
    .reduce((acc, curr) => acc + curr.length + curr[0], "");
}

function part1and2(input, times) {
  for (let i = 0; i < times; i++) {
    input = transform(input);
  }
  return input.length;
}

const testInput = "1";
const input = "1113222113";

check(6, part1and2(testInput, 5));
console.log("Part 1: " + part1and2(input, 40)); // 252594
console.log("Part 2: " + part1and2(input, 50)); // 3579328
