import {check, readInput} from "../Utils.js";

function part1(input) {
    function hasAtLeastTreeVowels(string) {
        const vowels = "aeiou"
        return string.split('').map(char => {
            if (vowels.includes(char))
                return 1
            else
                return 0
        }).sum() >= 3
    }

    function hasDoubledLetter(string) {
        let prevLetter = ""
        for (let char of string) {
            if (char === prevLetter) {
                return true
            }
            prevLetter = char
        }
        return false
    }

    function doesNotContainDisallowedSubstrings(string) {
        return !string.includes("ab") &&
            !string.includes("cd") &&
            !string.includes("pq") &&
            !string.includes("xy")
    }

    return input.map(line => {
        if (hasAtLeastTreeVowels(line) && hasDoubledLetter(line) && doesNotContainDisallowedSubstrings(line))
            return 1
        else
            return 0
    }).sum()
}

function part2(input) {
    function hasTwoPairs(string) {
        for (let i = 0; i < string.length - 1; i++) {
            for (let j = 0; j < string.length - 1; j++) {
                if (string.substr(i, 2) === string.substr(j, 2) && i !== j && i + 1 !== j && i - 1 !== j) {
                    return true
                }
            }
        }
        return false
    }

    function hasOneSplitPair(string) {
        for (let i = 0; i < string.length - 2; i++) {
            if (string[i] === string[i + 2]) {
                return true
            }
        }
        return false
    }

    return input.map(line => {
        if (hasTwoPairs(line) && hasOneSplitPair(line))
            return 1
        else
            return 0
    }).sum()
}

const testInput = readInput("test_input.txt")
const testInput2 = readInput("test_input_2.txt")
const input = readInput("input.txt")

check(part1(testInput), 2)
console.log("Part 1: " + part1(input))

check(part2(testInput2), 2)
console.log("Part 2: " + part2(input))