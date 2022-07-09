import { findSubsets } from "../utils.js";

const weapons = [
  { cost: 8, ATK: 4, DEF: 0 },
  { cost: 10, ATK: 5, DEF: 0 },
  { cost: 25, ATK: 6, DEF: 0 },
  { cost: 40, ATK: 7, DEF: 0 },
  { cost: 74, ATK: 8, DEF: 0 },
];
const armorList = [
  { cost: 13, ATK: 0, DEF: 1 },
  { cost: 31, ATK: 0, DEF: 2 },
  { cost: 53, ATK: 0, DEF: 3 },
  { cost: 75, ATK: 0, DEF: 4 },
  { cost: 102, ATK: 0, DEF: 5 },
  { cost: 0, ATK: 0, DEF: 0 },
];
const rings = [
  { cost: 25, ATK: 1, DEF: 0 },
  { cost: 50, ATK: 2, DEF: 0 },
  { cost: 100, ATK: 3, DEF: 0 },
  { cost: 20, ATK: 0, DEF: 1 },
  { cost: 40, ATK: 0, DEF: 2 },
  { cost: 80, ATK: 0, DEF: 3 },
];
const bossInitialStats = { HP: 104, ATK: 8, DEF: 1 };

function simulate(player) {
  const boss = Object.assign({}, bossInitialStats);
  let isPlayerTurn = true;
  while (boss.HP > 0 && player.HP > 0) {
    if (isPlayerTurn) {
      const dif = player.ATK - boss.DEF;
      boss.HP -= dif > 0 ? dif : 1;
      isPlayerTurn = false;
    } else {
      const dif = boss.ATK - player.DEF;
      player.HP -= dif > 0 ? dif : 1;
      isPlayerTurn = true;
    }
  }
  return player.HP > 0;
}

function part1() {
  const ringCombos = [[], ...findSubsets(rings, 1, 2)];
  let currentMinGoldSpent = Number.MAX_VALUE;
  for (const weapon of weapons) {
    for (const armor of armorList) {
      for (const ringCombo of ringCombos) {
        let goldTotal =
          weapon.cost + armor.cost + ringCombo.map((ring) => ring.cost).sum();
        let playerATK = weapon.ATK + ringCombo.map((ring) => ring.ATK).sum();
        let playerDEF = armor.DEF + ringCombo.map((ring) => ring.DEF).sum();
        if (simulate({ HP: 100, ATK: playerATK, DEF: playerDEF })) {
          currentMinGoldSpent = Math.min(currentMinGoldSpent, goldTotal);
        }
      }
    }
  }
  return currentMinGoldSpent;
}

function part2() {
  const ringCombos = [[], ...findSubsets(rings, 1, 2)];
  let currentMaxGoldSpent = Number.MIN_VALUE;
  for (const weapon of weapons) {
    for (const armor of armorList) {
      for (const ringCombo of ringCombos) {
        let goldTotal =
          weapon.cost + armor.cost + ringCombo.map((ring) => ring.cost).sum();
        let playerATK = weapon.ATK + ringCombo.map((ring) => ring.ATK).sum();
        let playerDEF = armor.DEF + ringCombo.map((ring) => ring.DEF).sum();
        if (!simulate({ HP: 100, ATK: playerATK, DEF: playerDEF })) {
          currentMaxGoldSpent = Math.max(currentMaxGoldSpent, goldTotal);
        }
      }
    }
  }
  return currentMaxGoldSpent;
}

console.log("Part 1: " + part1()); // 74
console.log("Part 2: " + part2()); // 148
