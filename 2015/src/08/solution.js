import { check, readInput } from "../utils.js";

function part1(input) {
  let totalSize = 0;
  let totalInMemorySize = 0;
  for (const line of input) {
    totalSize += line.length;
    for (let i = 1; i < line.length - 1; i++) {
      if (line[i] === "\\") {
        if (line[i + 1] === "x") {
          i += 3;
        } else {
          i++;
        }
      }
      totalInMemorySize++;
    }
  }
  return totalSize - totalInMemorySize;
}

function part2(input) {
  let totalSize = 0;
  let totalEncodedSize = 0;
  for (const line of input) {
    totalSize += line.length;
    for (let i = 0; i < line.length; i++) {
      if (line[i] === "\\" || line[i] === '"') {
        totalEncodedSize++;
      }
    }
    totalEncodedSize += line.length + 2;
  }
  return totalEncodedSize - totalSize;
}

const testInput = readInput("08", "input_test.txt");
const input = readInput("08", "input.txt");

check(12, part1(testInput));
console.log("Part 1: " + part1(input)); // 1371

check(19, part2(testInput));
console.log("Part 2: " + part2(input)); // 2117
