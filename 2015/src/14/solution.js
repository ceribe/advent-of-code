import { check, readInput } from "../utils.js";

class Reindeer {
  constructor(line) {
    this.speed = parseInt(line[3]);
    this.maxStamina = parseInt(line[6]);
    this.maxRestTime = parseInt(line[13]);
    this.stamina = this.maxStamina;
    this.restTime = 0;
    this.travelledDistance = 0;
    this.points = 0;
  }
  nextSecond() {
    if (this.stamina > 0) {
      this.travelledDistance += this.speed;
      this.stamina--;
    } else {
      this.restTime++;
      if (this.restTime === this.maxRestTime) {
        this.stamina = this.maxStamina;
        this.restTime = 0;
      }
    }
  }
}

function part1(input) {
  const reindeerList = input.map((value) => new Reindeer(value.split(" ")));
  for (let i = 0; i < 2503; i++) {
    reindeerList.forEach((reindeer) => reindeer.nextSecond());
  }
  return Math.max(
    ...reindeerList.map((reindeer) => reindeer.travelledDistance)
  );
}

function part2(input) {
  const reindeerList = input.map((value) => new Reindeer(value.split(" ")));
  for (let i = 0; i < 2503; i++) {
    reindeerList.forEach((reindeer) => reindeer.nextSecond());
    const currentMax = Math.max(
      ...reindeerList.map((reindeer) => reindeer.travelledDistance)
    );
    reindeerList
      .filter((reindeer) => reindeer.travelledDistance === currentMax)
      .forEach((reindeer) => reindeer.points++);
  }
  return Math.max(...reindeerList.map((reindeer) => reindeer.points));
}

const testInput = readInput("14", "input_test.txt");
const input = readInput("14", "input.txt");

check(part1(testInput), 2660);
console.log("Part 1: " + part1(input)); // 2640

check(part2(testInput), 1564);
console.log("Part 2: " + part2(input)); // 1102
