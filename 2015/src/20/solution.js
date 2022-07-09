import { getDivisors } from "../Utils.js";

function part1(input) {
  let houseNumber = 1;
  while (true) {
    let presents = 0;
    const elves = getDivisors(houseNumber);
    elves.forEach((elf) => (presents += elf * 10));
    presents += houseNumber * 10 + 10;
    if (presents >= input) return houseNumber;
    houseNumber++;
  }
}

function part2(input) {
  let houseNumber = 1;
  const elves = new Map();
  elves.set(1, 50);
  while (true) {
    let presents = 0;
    for (const [key, value] of elves.entries()) {
      if (houseNumber % key === 0) {
        if (value > 0) {
          presents += key * 11;
          elves.set(key, value - 1);
        } else {
          elves.delete(key);
        }
      }
    }
    if (presents >= input) return houseNumber;
    houseNumber++;
    elves.set(houseNumber, 50);
  }
}

const input = 34_000_000;
console.log("Part 1: " + part1(input)); // 786240
console.log("Part 2: " + part2(input)); // 831600
