import {check, readInput} from "../Utils.js";

function part1(input) {
    return input[0].split('').map(a => {
        if (a === '(') return 1; else return -1
    }).sum()
}

function part2(input) {
    let floor = 0
    const chars = input[0].split('')
    for (let idx = 0; idx < chars.length; idx++) {
        if (chars[idx] === '(')
            floor++
        else
            floor--
        if (floor === -1)
            return idx + 1
    }
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1(testInput), -1)
console.log("Part 1: " + part1(input))

check(part2(testInput), 5)
console.log("Part 2: " + part2(input))