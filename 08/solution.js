import {check, readInput} from "../Utils.js";

function part1(input) {
    let totalSize = 0
    let totalInMemorySize = 0
    for (const line of input) {
        totalSize += line.length
        for (let i = 1; i < line.length - 1; i++) {
            if(line[i] === '\\') {
                if(line[i+1] === 'x') { i += 3}
                else { i++ }
            }
            totalInMemorySize++
        }
    }
    return totalSize - totalInMemorySize
}

function part2(input) {
    let totalSize = 0
    let totalEncodedSize = 0
    for (const line of input) {
        totalSize += line.length
        for (let i = 0; i < line.length; i++) {
            if(line[i] === '\\' || line[i] === '\"') {
                totalEncodedSize++
            }
        }
        totalEncodedSize += line.length + 2
    }
    return totalEncodedSize - totalSize
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1(testInput), 12)
console.log("Part 1: " + part1(input))

check(part2(testInput), 19)
console.log("Part 2: " + part2(input))