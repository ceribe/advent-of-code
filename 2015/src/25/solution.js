function generateNextCode(code) {
  return (code * 252533) % 33554393;
}

function part1(row, column) {
  let code = 20151125;
  let currRow = 1;
  let currCol = 1;
  while (true) {
    if (currRow === 1) {
      currRow = currCol + 1;
      currCol = 1;
    } else {
      currRow--;
      currCol++;
    }
    code = generateNextCode(code);
    if (currRow === row && currCol === column) {
      break;
    }
  }
  return code;
}

console.log("Part 1: " + part1(3010, 3019)); // 8997277
