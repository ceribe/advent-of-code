import {check, readInput} from "../Utils.js";

function part1(input) {
    const visited = new Set()
    visited.add("0,0")
    let currentX = 0
    let currentY = 0
    input[0].split('').forEach(direction => {
        switch (direction) {
            case '>': currentX++; break
            case '<': currentX--; break
            case 'v': currentY--; break
            case '^': currentY++; break
        }
        visited.add("" + currentX + "," + currentY)
    })
    return visited.size
}

function part2(input) {
    const visited = new Set()
    visited.add("0,0")
    const currentX = [0, 0]
    const currentY = [0, 0]
    let turn = 0
    input[0].split('').forEach(direction => {
        switch (direction) {
            case '>': currentX[turn]++; break
            case '<': currentX[turn]--; break
            case 'v': currentY[turn]--; break
            case '^': currentY[turn]++; break
        }
        visited.add("" + currentX[turn] + "," + currentY[turn])
        turn = (turn + 1) % 2
    })
    return visited.size
}

const testInput1 = readInput("test_input_1.txt")
const testInput2 = readInput("test_input_2.txt")
const testInput3 = readInput("test_input_3.txt")
const input = readInput("input.txt")

check(part1(testInput1), 2)
check(part1(testInput2), 4)
check(part1(testInput3), 2)
console.log("Part 1: " + part1(input))

check(part2(testInput1), 2)
check(part2(testInput2), 3)
check(part2(testInput3), 11)
console.log("Part 2: " + part2(input))