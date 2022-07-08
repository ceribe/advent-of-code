import { check, readInput } from "../utils.js";

function part1and2(input, size, areStuck) {
  if (areStuck) {
    input[0] = "#" + input[0].substring(1, 99) + "#";
    input[99] = "#" + input[99].substring(1, 99) + "#";
  }
  let lights = input.map((line) =>
    line.split("").map((char) => (char === "#" ? 1 : 0))
  );
  for (let i = 0; i < size; i++) {
    const newLights = new Array(size);
    for (let j = 0; j < size; j++) {
      newLights[j] = Array(size).fill(0);
    }

    for (let x = 0; x < size; x++) {
      for (let y = 0; y < size; y++) {
        let neighCount = 0;

        for (let k = -1; k <= 1; k++) {
          for (let l = -1; l <= 1; l++) {
            if (k === 0 && l === 0) continue;
            const newX = x + k;
            const newY = y + l;
            if (
              newX >= 0 &&
              newY >= 0 &&
              newX < size &&
              newY < size &&
              lights[newX][newY] === 1
            )
              neighCount++;
          }
        }

        if (lights[x][y] === 1) {
          newLights[x][y] = neighCount === 2 || neighCount === 3 ? 1 : 0;
        } else {
          newLights[x][y] = neighCount === 3 ? 1 : 0;
        }
      }
    }
    lights = newLights;
    if (areStuck) {
      lights[0][0] = 1;
      lights[0][99] = 1;
      lights[99][0] = 1;
      lights[99][99] = 1;
    }
  }
  return lights.map((row) => row.sum()).sum();
}

const testInput = readInput("18", "input_test.txt");
const input = readInput("18", "input.txt");

check(part1and2(testInput, 6), 4, false);
console.log("Part 1: " + part1and2(input, 100, false)); // 768
console.log("Part 2: " + part1and2(input, 100, true)); // 781
