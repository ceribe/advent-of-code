import { check, readFirstLine } from "../utils.js";

function part1(input) {
  const visited = new Set([0]);
  let currentX = 0;
  let currentY = 0;
  input.split("").forEach((direction) => {
    switch (direction) {
      case ">":
        currentX++;
        break;
      case "<":
        currentX--;
        break;
      case "v":
        currentY--;
        break;
      case "^":
        currentY++;
        break;
    }
    visited.add(currentX * 1000000 + currentY);
  });
  return visited.size;
}

function part2(input) {
  const visited = new Set([0]);
  const currentX = [0, 0];
  const currentY = [0, 0];
  let turn = 0;
  input.split("").forEach((direction) => {
    switch (direction) {
      case ">":
        currentX[turn]++;
        break;
      case "<":
        currentX[turn]--;
        break;
      case "v":
        currentY[turn]--;
        break;
      case "^":
        currentY[turn]++;
        break;
    }
    visited.add(currentX[turn] * 1000000 + currentY[turn]);
    turn = (turn + 1) % 2;
  });
  return visited.size;
}

const testInput1 = readFirstLine("03", "input_test_1.txt");
const testInput2 = readFirstLine("03", "input_test_2.txt");
const testInput3 = readFirstLine("03", "input_test_3.txt");
const input = readFirstLine("03", "input.txt");

check(2, part1(testInput1));
check(4, part1(testInput2));
check(2, part1(testInput3));
console.log("Part 1: " + part1(input)); // 2592

check(2, part2(testInput1));
check(3, part2(testInput2));
check(11, part2(testInput3));
console.log("Part 2: " + part2(input)); // 2360
