import { check, readFirstLine } from "../utils.js";

function part1(input) {
  return input
    .match(/[-0-9]+/g)
    .map((value) => parseInt(value))
    .sum();
}

function part2(input) {
  let sum = 0;
  const parsed = JSON.parse(input);

  function go(node) {
    if (Array.isArray(node)) {
      for (const elem of node) {
        go(elem);
      }
    } else if (typeof node === "number") {
      sum += node;
    } else if (typeof node === "object") {
      // If any of values is red then skip this object
      for (const [, value] of Object.entries(node)) {
        if (value === "red") {
          return;
        }
      }
      for (const [, value] of Object.entries(node)) {
        go(value);
      }
    }
  }

  go(parsed);
  return sum;
}

const testInput1 = '{"d":"red","e":[1,2,3,4],"f":5}';
const testInput2 = '[1,{"c":"red","b":2},3]';
const testInput3 = '[1,"red",5]';
const input = readFirstLine("12", "input.txt");

check(15, part1(testInput1));
check(6, part1(testInput2));
check(6, part1(testInput3));
console.log("Part 1: " + part1(input)); // 191164

check(0, part2(testInput1));
check(4, part2(testInput2));
check(6, part2(testInput3));
console.log("Part 2: " + part2(input)); // 87842
