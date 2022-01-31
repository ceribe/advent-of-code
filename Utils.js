import fs from "fs";

Array.prototype.sortNumbers = function sortNumbers() {
    return [...this].sort((a, b) => a - b)
}

Array.prototype.sortNumbersDesc = function sortNumbersDesc() {
    return [...this].sort((a, b) => b - a)
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

export function findSubsets(a, min) {
    function fn(n, src, got, all) {
        if (n === 0) {
            if (got.length > 0) {
                all[all.length] = got;
            }
            return;
        }
        for (let j = 0; j < src.length; j++) {
            fn(n - 1, src.slice(j + 1), got.concat([src[j]]), all);
        }
    }
    let all = [];
    for (let i = min; i < a.length; i++) {
        fn(i, a, [], all);
    }
    all.push(a);
    return all;
}
