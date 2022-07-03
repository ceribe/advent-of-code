import {check, readInput} from "../Utils.js";

function part1(input) {
    return input[0].match(/[-0-9]+/g).map(value => parseInt(value)).sum()
}

function part2(input) {
    let sum = 0
    const parsed = JSON.parse(input[0])

    function go(json) {
        if (Array.isArray(json)) {
            for (const elem of json) {
                go(elem)
            }
        } else if (typeof json === 'number') {
            sum += json
        } else if (typeof json === 'object') {
            // If any of values is red then skip this object
            for (const [, value] of Object.entries(json)) {
                if (value === "red") {
                    return
                }
            }
            for (const [, value] of Object.entries(json)) {
                go(value)
            }
        }
    }

    go(parsed)
    return sum
}

const testInput = ["{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}"]
const testInput2 = ["[1,{\"c\":\"red\",\"b\":2},3]"]
const testInput3 = ["[1,\"red\",5]"]
const input = readInput("input.txt")

check(part1(testInput), 15)
console.log("Part 1: " + part1(input))

check(part2(testInput), 0)
check(part2(testInput2), 4)
check(part2(testInput3), 6)
console.log("Part 2: " + part2(input))