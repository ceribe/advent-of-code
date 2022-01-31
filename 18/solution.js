import {check, readInput} from "../Utils.js";

function part1and2(input, size, areStuck) {
    if (areStuck) {
        input[0] = '#' + input[0].substring(1, 99) + '#'
        input[99] = '#' + input[99].substring(1, 99) + '#'
    }
    let lights = input.map(line => line.split('').map(char => {
        if (char === '#') return 1; else return 0
    }))
    for (let i = 0; i < size; i++) {
        const newLights = new Array(size)
        for (let j = 0; j < size; j++) {
            newLights[j] = Array(size).fill(0)
        }
        for (let x = 0; x < size; x++) {
            for (let y = 0; y < size; y++) {
                let neighCount = 0

                function check(nX, nY) {
                    if (nX >= 0 && nY >= 0 && nX < size && nY < size && lights[nX][nY] === 1) neighCount++
                }

                check(x - 1, y - 1)
                check(x - 1, y)
                check(x - 1, y + 1)
                check(x, y - 1)
                check(x, y + 1)
                check(x + 1, y - 1)
                check(x + 1, y)
                check(x + 1, y + 1)

                if (lights[x][y] === 1) {
                    newLights[x][y] = neighCount === 2 || neighCount === 3 ? 1 : 0
                } else {
                    newLights[x][y] = neighCount === 3 ? 1 : 0
                }
            }
        }
        lights = newLights
        if (areStuck) {
            lights[0][0] = 1
            lights[0][99] = 1
            lights[99][0] = 1
            lights[99][99] = 1
        }
    }
    return lights.map(row => row.sum()).sum()
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1and2(testInput, 6), 4, false)
console.log("Part 1: " + part1and2(input, 100, false))
console.log("Part 2: " + part1and2(input, 100, true))
