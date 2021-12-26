import {check, readInput} from "../Utils.js";
import MD5 from "crypto-js/md5.js";

function part1and2(input, zerosCount) {
    let current = "111111111111"
    let counter = 0
    let secretKey = input[0]
    while(!current.slice(0, zerosCount).split('').every(char => char === '0')) {
        current = MD5(secretKey+counter).toString()
        counter++
    }
    return counter - 1
}

const testInput = readInput("test_input.txt")
const input = readInput("input.txt")

check(part1and2(testInput, 5), 609043)
console.log("Part 1: " + part1and2(input, 5))

check(part1and2(testInput, 6), 6742839)
console.log("Part 2: " + part1and2(input, 6))