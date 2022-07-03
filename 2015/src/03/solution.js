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

const input = readFirstLine("03", "input.txt");

check(2, part1(">"));
check(4, part1("^>v<"));
check(2, part1("^v^v^v^v^v"));
console.log("Part 1: " + part1(input)); // 2592

check(3, part2("^v"));
check(3, part2("^>v<"));
check(11, part2("^v^v^v^v^v"));
console.log("Part 2: " + part2(input)); // 2360
