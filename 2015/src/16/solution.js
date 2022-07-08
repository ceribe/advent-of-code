import { readInput } from "../utils.js";

class Sue {
  constructor(line) {
    line = line.replaceAll(/[:,]/g, "").split(" ");
    this.number = parseInt(line[1]);
    this.traits = new Map();
    this.traits.set(line[2], line[3]);
    this.traits.set(line[4], line[5]);
    this.traits.set(line[6], line[7]);
  }
}

function part1(input) {
  let aunts = input.map((line) => new Sue(line));
  for (const aunt of aunts) {
    const children = aunt.traits.get("children");
    if (children !== undefined && children !== "3") {
      continue;
    }
    const cats = aunt.traits.get("cats");
    if (cats !== undefined && cats !== "7") {
      continue;
    }
    const samoyeds = aunt.traits.get("samoyeds");
    if (samoyeds !== undefined && samoyeds !== "2") {
      continue;
    }
    const pomeranians = aunt.traits.get("pomeranians");
    if (pomeranians !== undefined && pomeranians !== "3") {
      continue;
    }
    const akitas = aunt.traits.get("akitas");
    if (akitas !== undefined && akitas !== "0") {
      continue;
    }
    const vizslas = aunt.traits.get("vizslas");
    if (vizslas !== undefined && vizslas !== "0") {
      continue;
    }
    const goldfish = aunt.traits.get("goldfish");
    if (goldfish !== undefined && goldfish !== "5") {
      continue;
    }
    const trees = aunt.traits.get("trees");
    if (trees !== undefined && trees !== "3") {
      continue;
    }
    const cars = aunt.traits.get("cars");
    if (cars !== undefined && cars !== "2") {
      continue;
    }
    const perfumes = aunt.traits.get("perfumes");
    if (perfumes !== undefined && perfumes !== "1") {
      continue;
    }
    return aunt.number;
  }
  return -1;
}

function part2(input) {
  let aunts = input.map((line) => new Sue(line));
  for (const aunt of aunts) {
    const children = aunt.traits.get("children");
    if (children !== undefined && children !== "3") {
      continue;
    }
    const cats = aunt.traits.get("cats");
    if (cats !== undefined && parseInt(cats) <= 7) {
      continue;
    }
    const samoyeds = aunt.traits.get("samoyeds");
    if (samoyeds !== undefined && samoyeds !== "2") {
      continue;
    }
    const pomeranians = aunt.traits.get("pomeranians");
    if (pomeranians !== undefined && parseInt(pomeranians) >= 3) {
      continue;
    }
    const akitas = aunt.traits.get("akitas");
    if (akitas !== undefined && akitas !== "0") {
      continue;
    }
    const vizslas = aunt.traits.get("vizslas");
    if (vizslas !== undefined && vizslas !== "0") {
      continue;
    }
    const goldfish = aunt.traits.get("goldfish");
    if (goldfish !== undefined && parseInt(goldfish) >= 5) {
      continue;
    }
    const trees = aunt.traits.get("trees");
    if (trees !== undefined && parseInt(trees) <= 3) {
      continue;
    }
    const cars = aunt.traits.get("cars");
    if (cars !== undefined && cars !== "2") {
      continue;
    }
    const perfumes = aunt.traits.get("perfumes");
    if (perfumes !== undefined && perfumes !== "1") {
      continue;
    }
    return aunt.number;
  }
  return -1;
}

const input = readInput("16", "input.txt");

console.log("Part 1: " + part1(input)); // 373
console.log("Part 2: " + part2(input)); // 260
