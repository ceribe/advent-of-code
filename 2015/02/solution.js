import {check, readInput} from "../Utils.js";

function part1(input) {
    return input.map(dims => {
            let [x, y, z] = dims.split('x').map(num => parseInt(num)).sortNumbers()
            return 2 * (x * y + y * z + z * x) + x * y
        }
    ).sum()
}

function part2(input) {
    return input.map(dims => {
            let [x, y, z] = dims.split('x').map(num => parseInt(num)).sortNumbers()
            return 2 * x + 2 * y + x * y * z
        }
    ).sum()
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1(testInput), 101)
console.log("Part 1: " + part1(input))

check(part2(testInput), 48)
console.log("Part 2: " + part2(input))