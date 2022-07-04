import { check, readInput } from "../utils.js";

/**
 * Generates all possible permutations of given array
 */
function generatePerms(xs) {
  let ret = [];
  for (let i = 0; i < xs.length; i++) {
    let rest = generatePerms(xs.slice(0, i).concat(xs.slice(i + 1)));

    if (!rest.length) {
      ret.push([xs[i]]);
    } else {
      for (let j = 0; j < rest.length; j++) {
        ret.push([xs[i]].concat(rest[j]));
      }
    }
  }
  return ret;
}

/**
 * Parses the input creating  map of happiness for each person
 */
function getHappinessMap(input) {
  const happinessMap = new Map();
  input.forEach((line) => {
    const words = line.split(" ");
    const name = words[0];
    const otherPersonName = words[10].slice(0, -1);
    const happinessUnits = parseInt(words[3]);
    const multiplier = words[2] === "gain" ? 1 : -1;

    if (!happinessMap.has(name)) {
      happinessMap.set(name, new Map());
    }
    happinessMap.get(name).set(otherPersonName, happinessUnits * multiplier);
  });
  return happinessMap;
}

/**
 * Calculates the maximum possible total happiness from given happinessMap by generating all permutations and checking
 * their total happiness.
 */
function calculateMaxTotalHappiness(happinessMap) {
  const namesPermutations = generatePerms([...happinessMap.keys()]);
  let maxTotalHappiness = Number.MIN_VALUE;
  namesPermutations.forEach((names) => {
    const happiness = names
      .map((name, index) => {
        const prevIdx = index - 1 < 0 ? names.length - 1 : index - 1;
        const nextIdx = index + 1 === names.length ? 0 : index + 1;
        return (
          happinessMap.get(name).get(names[prevIdx]) +
          happinessMap.get(name).get(names[nextIdx])
        );
      })
      .sum();
    maxTotalHappiness = Math.max(maxTotalHappiness, happiness);
  });
  return maxTotalHappiness;
}

function part1(input) {
  const happinessMap = getHappinessMap(input);
  return calculateMaxTotalHappiness(happinessMap);
}

/**
 * Adds new person to happinessMap with all values equal to 0
 */
function insertMe(happinessMap) {
  const people = [...happinessMap.keys()];
  happinessMap.set("Me", new Map());
  for (const person of people) {
    happinessMap.get(person).set("Me", 0);
    happinessMap.get("Me").set(person, 0);
  }
  return happinessMap;
}

function part2(input) {
  const happinessMap = getHappinessMap(input);
  insertMe(happinessMap);
  return calculateMaxTotalHappiness(happinessMap);
}

const testInput = readInput("13", "input_test.txt");
const input = readInput("13", "input.txt");

check(330, part1(testInput));
console.log("Part 1: " + part1(input)); // 618

check(286, part2(testInput));
console.log("Part 2: " + part2(input)); // 601
