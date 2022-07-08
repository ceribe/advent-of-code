import { findSubsets, readInput } from "../utils.js";

function part1(input) {
  const containers = input.map((line) => parseInt(line));
  const combinations = findSubsets(containers, 2);
  let sum = 0;
  combinations.forEach((combination) => {
    if (combination.sum() === 150) sum++;
  });
  return sum;
}

function part2(input) {
  const containers = input.map((line) => parseInt(line));
  const combinations = findSubsets(containers, 2);
  let min = Number.MAX_VALUE;
  combinations.forEach((combination) => {
    if (combination.sum() === 150) min = Math.min(combination.length, min);
  });
  let sum = 0;
  combinations.forEach((combination) => {
    if (combination.sum() === 150 && combination.length === min) sum++;
  });
  return sum;
}

const input = readInput("17", "input.txt");
console.log("Part 1: " + part1(input)); // 654
console.log("Part 2: " + part2(input)); // 57
