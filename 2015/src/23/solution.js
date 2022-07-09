import { readInput } from "../utils.js";

class Instruction {
  constructor(line) {
    line = line.replaceAll(/[,\+]/g, "").split(" ");
    this.name = line[0];
    this.arg1 = line[1];
    if (this.name === "jmp") {
      this.arg1 = parseInt(this.arg1);
    }
    if (this.name === "jio" || this.name === "jie") {
      this.arg2 = parseInt(line[2]);
    }
  }
}

function part1and2(input, initialA) {
  const instructions = input.map((line) => new Instruction(line));
  let pointer = 0;
  let a = initialA;
  let b = 0;
  while (true) {
    if (pointer >= instructions.length) {
      break;
    }
    const instruction = instructions[pointer];
    switch (instruction.name) {
      case "hlf":
        if (instruction.arg1 === "a") a = a / 2;
        else b = b / 2;
        pointer++;
        break;
      case "tpl":
        if (instruction.arg1 === "a") a = a * 3;
        else b = b * 3;
        pointer++;
        break;
      case "inc":
        if (instruction.arg1 === "a") a++;
        else b++;
        pointer++;
        break;
      case "jmp":
        pointer += instruction.arg1;
        break;
      case "jie":
        if ((instruction.arg1 === "a" ? a : b) % 2 === 0) {
          pointer += instruction.arg2;
        } else {
          pointer++;
        }
        break;
      case "jio":
        if ((instruction.arg1 === "a" ? a : b) === 1) {
          pointer += instruction.arg2;
        } else {
          pointer++;
        }
        break;
    }
  }
  return b;
}

const input = readInput("23", "input.txt");
console.log("Part 1: " + part1and2(input, 0)); // 307
console.log("Part 2: " + part1and2(input, 1)); // 160
