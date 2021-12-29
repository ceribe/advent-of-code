import fs from "fs";

Array.prototype.sortNumbers = function sortNumbers() {
    return this.sort((a, b) => a - b)
}

Array.prototype.sortNumbersDesc = function sortNumbersDesc() {
    return this.sort((a, b) => b - a)
}

String.prototype.lines = function lines() {
    return this.match(/[^\r\n]+/g)
}

Array.prototype.sum = function sum() {
    return this.map(Number).reduce(
        function (prev, curr) {
            return prev+curr
        }
    )
}

Array.prototype.last = function() {
    return this[this.length - 1];
}

export function readInput(filename) {
    return fs.readFileSync(filename, 'utf8').toString().lines()
}

export function check(real, expected) {
    console.assert(expected === real, 'Expected %s, got %s', expected, real)
}