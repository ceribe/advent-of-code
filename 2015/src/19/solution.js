import { readInput } from "../utils.js";

function parseInput(input) {
  const replacements = [];
  let molecule;
  for (const line of input) {
    if (line.match(/ /g) === null) {
      molecule = line;
    } else {
      const split = line.split(" ");
      replacements.push([split[0], split[2]]);
    }
  }
  return [replacements, molecule];
}

function part1(input) {
  const [replacements, molecule] = parseInput(input);

  const molecules = new Set();
  for (const replacement of replacements) {
    let startPos = -1;
    do {
      startPos = molecule.indexOf(replacement[0], startPos + 1);
      if (startPos === -1) break;
      const newMolecule =
        molecule.substring(0, startPos) +
        replacement[1] +
        molecule.substring(startPos + replacement[0].length);
      molecules.add(newMolecule);
    } while (true);
  }
  return molecules.size;
}

function part2(input) {
  const [replacements, wantedMolecule] = parseInput(input);

  let currMinIters = Number.MAX_VALUE;
  let counter = 10000;

  function go(molecule, iters) {
    if (iters > currMinIters) {
      return;
    }
    if (molecule === "e") {
      currMinIters = Math.min(currMinIters, iters);
      counter--;
      return;
    }
    if (counter === 0) return;
    for (const replacement of replacements) {
      let startPos = -1;
      do {
        startPos = molecule.indexOf(replacement[1], startPos + 1);
        if (startPos === -1) break;
        const newMolecule =
          molecule.substring(0, startPos) +
          replacement[0] +
          molecule.substring(startPos + replacement[1].length);
        go(newMolecule, iters + 1);
      } while (true);
    }
  }

  go(wantedMolecule, 0);

  return currMinIters;
}

const input = readInput("19", "input.txt");
console.log("Part 1: " + part1(input)); // 535
console.log("Part 2: " + part2(input)); // 212
