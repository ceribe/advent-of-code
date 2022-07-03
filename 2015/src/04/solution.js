import { check } from "../utils.js";
import MD5 from "crypto-js/md5.js";

function part1and2(input, zerosCount) {
  let [current, counter, secretKey] = ["1", 0, input];
  while (
    !current
      .slice(0, zerosCount)
      .split("")
      .every((char) => char === "0")
  ) {
    current = MD5(secretKey + counter++).toString();
  }
  return counter - 1;
}

const testInput1 = "abcdef";
const testInput2 = "pqrstuv";
const input = "bgvyzdsv";

check(609043, part1and2(testInput1, 5));
check(1048970, part1and2(testInput2, 5));
console.log("Part 1: " + part1and2(input, 5)); // 254575

check(6742839, part1and2(testInput1, 6));
console.log("Part 2: " + part1and2(input, 6)); // 1038736
