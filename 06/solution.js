import {check, readInput} from "../Utils.js";

class Instruction {
    constructor(line) {
        let args = line.replace("turn ", "").split(' ')
        this.type = args[0]
        this.x1 = parseInt(args[1].split(',')[0])
        this.y1 = parseInt(args[1].split(',')[1])
        this.x2 = parseInt(args[3].split(',')[0])
        this.y2 = parseInt(args[3].split(',')[1])
    }
}

function part1(input) {
    const instructions = input.map(line => new Instruction(line))
    const lights = new Set()
    for (const instruction of instructions) {
        for (let x = instruction.x1; x <= instruction.x2; x++) {
            for (let y = instruction.y1; y <= instruction.y2; y++) {
                const light = `${x},${y}`
                if (instruction.type === "on") {
                    lights.add(light)
                }
                else if (instruction.type === "off") {
                    lights.delete(light)
                }
                // toggle
                else {
                    if (lights.has(light)) {
                        lights.delete(light)
                    }
                    else {
                        lights.add(light)
                    }
                }
            }
        }
    }
    return lights.size
}

function part2(input) {
    const instructions = input.map(line => new Instruction(line))
    const lights = new Map()
    // Add all possible values as 0.
    // Not really needed or optimal, but thanks to this there will be no need to check if a key is in map.
    for (let x = 0; x < 1000; x++) {
        for (let y = 0; y < 1000; y++) {
            lights.set(`${x},${y}`, 0)
        }
    }
    for (const instruction of instructions) {
        for (let x = instruction.x1; x <= instruction.x2; x++) {
            for (let y = instruction.y1; y <= instruction.y2; y++) {
                const light = `${x},${y}`
                if (instruction.type === "on") {
                    lights.set(light, lights.get(light) + 1)
                }
                else if (instruction.type === "toggle") {
                    lights.set(light, lights.get(light) + 2)
                }
                // off
                else {
                    lights.set(light, Math.max(lights.get(light) - 1, 0))
                }
            }
        }
    }
    return Array.from(lights.values()).sum()
}

const input = readInput("input.txt")

console.log("Part 1: " + part1(input))
console.log("Part 2: " + part2(input))