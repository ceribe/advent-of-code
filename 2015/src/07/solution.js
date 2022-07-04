import { check, readInput } from "../utils.js";

class Operation {
  constructor(line) {
    const words = line.split(" ");
    if (
      line.includes("AND") ||
      line.includes("OR") ||
      line.includes("LSHIFT") ||
      line.includes("RSHIFT")
    ) {
      this.arg1 = words[0];
      this.arg2 = words[2];
      this.type = words[1];
      this.result = words[4];
    } else if (line.includes("NOT")) {
      this.arg1 = words[1];
      this.type = words[0];
      this.result = words[3];
    }
    // ASSIGN
    else {
      this.arg1 = words[0];
      this.type = "ASSIGN";
      this.result = words[2];
    }
  }

  isActive(map) {
    switch (this.type) {
      case "AND":
      case "OR":
      case "LSHIFT":
      case "RSHIFT":
        return (
          (!isNaN(this.arg1) || map.has(this.arg1)) &&
          (!isNaN(this.arg2) || map.has(this.arg2))
        );
      case "NOT":
      case "ASSIGN":
        return !isNaN(this.arg1) || map.has(this.arg1);
    }
  }

  perform(map) {
    let arg1, arg2;
    if (map.has(this.arg1)) arg1 = map.get(this.arg1);
    else arg1 = parseInt(this.arg1);

    if (map.has(this.arg2)) arg2 = map.get(this.arg2);
    else arg2 = parseInt(this.arg2);

    switch (this.type) {
      case "AND":
        map.set(this.result, arg1 & arg2);
        break;
      case "OR":
        map.set(this.result, arg1 | arg2);
        break;
      case "LSHIFT":
        map.set(this.result, arg1 << arg2);
        break;
      case "RSHIFT":
        map.set(this.result, arg1 >> arg2);
        break;
      case "NOT":
        map.set(this.result, ~arg1);
        break;
      case "ASSIGN":
        map.set(this.result, arg1);
        break;
    }
  }
}

function part1and2(input) {
  const ops = input.map((line) => new Operation(line));
  const map = new Map();
  while (!map.has("a")) {
    for (let i = 0; i < ops.length; i++) {
      if (ops[i].isActive(map)) {
        ops[i].perform(map);
        ops.splice(i, 1);
        break;
      }
    }
  }
  return map.get("a");
}

const testInput = readInput("07", "input_test.txt");
const input = readInput("07", "input.txt");

check(114, part1and2(testInput));
console.log("Part 1 or 2: " + part1and2(input));
