import fs from "fs";

Array.prototype.sortNumbers = function sortNumbers() {
    return [...this].sort((a, b) => a - b)
}

String.prototype.lines = function lines() {
    return this.match(/[^\r\n]+/g)
}

Array.prototype.sum = function sum() {
    return this.map(Number).reduce(
        function (prev, curr) {
            return prev+curr
        }, 0
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

export function findSubsets(a, min, max = a.length) {
    function fn(n, src, got, all) {
        if (n === 0) {
            if (got.length > 0) {
                all[all.length] = got
            }
            return
        }
        for (let j = 0; j < src.length; j++) {
            fn(n - 1, src.slice(j + 1), got.concat([src[j]]), all)
        }
    }
    let all = []
    for (let i = min; i <= max; i++) {
        fn(i, a, [], all)
    }
    if (a.length === max) {
        all.push(a)
    }
    return all
}

export function getDivisors(num) {
    const divisors = []
    const sqrt = Math.sqrt(num)
    for (let i = 2; i <= sqrt; i++) {
        if (num % i === 0) {
            divisors.push(i)
            if (i !== num / i) {
                divisors.push(num / i)
            }
        }
    }
    return divisors
}
