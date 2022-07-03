import { check, readInput } from "../utils.js";

function part1(input) {
  function hasAtLeastTreeVowels(string) {
    const vowels = "aeiou";
    return string.split("").filter((char) => vowels.includes(char)).length >= 3;
  }

  function hasDoubledLetter(string) {
    let prevLetter = "";
    for (let char of string) {
      if (char === prevLetter) {
        return true;
      }
      prevLetter = char;
    }
    return false;
  }

  function doesNotContainDisallowedSubstrings(string) {
    return (
      !string.includes("ab") &&
      !string.includes("cd") &&
      !string.includes("pq") &&
      !string.includes("xy")
    );
  }

  return input.filter(
    (line) =>
      hasAtLeastTreeVowels(line) &&
      hasDoubledLetter(line) &&
      doesNotContainDisallowedSubstrings(line)
  ).length;
}

function part2(input) {
  function hasTwoPairs(string) {
    for (let i = 0; i < string.length - 1; i++) {
      for (let j = 0; j < string.length - 1; j++) {
        if (
          string.substr(i, 2) === string.substr(j, 2) &&
          i !== j &&
          i + 1 !== j &&
          i - 1 !== j
        ) {
          return true;
        }
      }
    }
    return false;
  }

  function hasOneSplitPair(string) {
    for (let i = 0; i < string.length - 2; i++) {
      if (string[i] === string[i + 2]) {
        return true;
      }
    }
    return false;
  }

  return input.filter((line) => hasTwoPairs(line) && hasOneSplitPair(line))
    .length;
}

const testInput = readInput("05", "input_test_1.txt");
const testInput2 = readInput("05", "input_test_2.txt");
const input = readInput("05", "input.txt");

check(2, part1(testInput));
console.log("Part 1: " + part1(input)); // 258

check(2, part2(testInput2));
console.log("Part 2: " + part2(input)); // 53
