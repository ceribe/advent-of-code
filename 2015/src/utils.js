import fs from "fs";

Array.prototype.sortNumbers = function sortNumbers() {
  return [...this].sort((a, b) => a - b);
};

String.prototype.lines = function lines() {
  return this.match(/[^\r\n]+/g);
};

Array.prototype.sum = function sum() {
  return this.map(Number).reduce(function (prev, curr) {
    return prev + curr;
  }, 0);
};

Array.prototype.last = function () {
  return this[this.length - 1];
};

/**
 * Reads lines from the given input txt file.
 * @param {String} day
 * @param {String} filename
 * @returns {String[]} file divided into lines
 */
export function readInput(day, filename) {
  return fs.readFileSync(`src/${day}/${filename}`, "utf8").toString().lines();
}

/**
 * Reads first line from the given input txt file.
 * @param {String} day
 * @param {String} filename
 * @returns {String} first line of the file
 */
export function readFirstLine(day, filename) {
  return readInput(day, filename)[0];
}

/**
 * Checks if given parameters are equal. If not throws an exception.
 * @param {any} expected
 * @param {any} actual
 */
export function check(expected, actual) {
  if (expected !== actual)
    throw new Error(`Expected ${expected}, got ${actual}`);
}

/**
 * Returns an array of all subsets of the given array.
 * @param {any[]} a array of elements
 * @param {number} min minimum size of subsets
 * @param {number} max maximum size of subsets
 */
export function findSubsets(a, min, max = a.length) {
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
  for (let i = min; i <= max; i++) {
    fn(i, a, [], all);
  }
  if (a.length === max) {
    all.push(a);
  }
  return all;
}
