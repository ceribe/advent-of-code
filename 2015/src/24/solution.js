import { findSubsets, readInput } from "../utils.js";

function part1and2(input, numberOfGroups) {
  const presents = input.map((line) => parseInt(line));
  const groupWeight = presents.sum() / numberOfGroups;
  let smallestQuantumEntanglement = Number.MAX_VALUE;
  let currSize = 2;
  while (true) {
    const combos = findSubsets(presents, currSize, currSize);
    smallestQuantumEntanglement = Number.MAX_VALUE;
    for (const combo of combos) {
      if (combo.sum() === groupWeight) {
        const quantumEntanglement = combo.reduce(function (prev, curr) {
          return prev * curr;
        }, 1);
        smallestQuantumEntanglement = Math.min(
          smallestQuantumEntanglement,
          quantumEntanglement
        );
      }
    }
    if (smallestQuantumEntanglement !== Number.MAX_VALUE)
      return smallestQuantumEntanglement;
    currSize++;
  }
}

const input = readInput("24", "input.txt");
console.log("Part 1: " + part1and2(input, 3)); // 11846773891
console.log("Part 2: " + part1and2(input, 4)); // 80393059
