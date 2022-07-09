const bossStats = { HP: 71, ATK: 10 };
const playerStats = { HP: 50, MP: 500 };
const spells = ["Magic Missile", "Drain", "Shield", "Poison", "Recharge"];

function part1and2(isHard) {
  let currentMinManaUsed = Number.MAX_VALUE;

  function checkBossDead(boss, manaUsed) {
    if (boss.HP <= 0) {
      currentMinManaUsed = Math.min(currentMinManaUsed, manaUsed);
      return true;
    }
    return false;
  }

  function applyEffects(player, boss, effects) {
    if (effects.shieldTimer > 0) {
      effects.shieldTimer--;
    }
    if (effects.poisonTimer > 0) {
      effects.poisonTimer--;
      boss.HP -= 3;
    }
    if (effects.rechargeTimer > 0) {
      effects.rechargeTimer--;
      player.MP += 101;
    }
  }

  function castSpell(spell, player, boss, effects) {
    switch (spell) {
      case "Magic Missile":
        if (player.MP < 53) {
          return 0;
        }
        player.MP -= 53;
        boss.HP -= 4;
        return 53;
      case "Drain":
        if (player.MP < 73) {
          return 0;
        }
        player.MP -= 73;
        boss.HP -= 2;
        player.HP += 2;
        return 73;
      case "Shield":
        if (player.MP < 113 || effects.shieldTimer > 0) {
          return 0;
        }
        player.MP -= 113;
        effects.shieldTimer = 6;
        return 113;
      case "Poison":
        if (player.MP < 173 || effects.poisonTimer > 0) {
          return 0;
        }
        player.MP -= 173;
        effects.poisonTimer = 6;
        return 173;
      case "Recharge":
        if (player.MP < 229 || effects.rechargeTimer > 0) {
          return 0;
        }
        player.MP -= 229;
        effects.rechargeTimer = 5;
        return 229;
    }
  }

  function go(playerPrev, bossPrev, effectsPrev, manaUsedPrev) {
    if (manaUsedPrev > currentMinManaUsed) {
      return;
    }
    for (const spell of spells) {
      // This objects will be passed to a recurrent function, so they need to be copied
      const boss = Object.assign({}, bossPrev);
      const player = Object.assign({}, playerPrev);
      const effects = Object.assign({}, effectsPrev);
      let manaUsed = manaUsedPrev;

      // Player turn
      if (isHard) {
        player.HP -= 1;
        if (player.HP === 0) {
          return;
        }
      }
      applyEffects(player, boss, effects);
      if (checkBossDead(boss, manaUsed)) {
        return;
      }
      const cost = castSpell(spell, player, boss, effects);
      if (cost === 0) {
        continue;
      }
      manaUsed += cost;
      if (checkBossDead(boss, manaUsed)) {
        continue;
      }

      // Boss turn
      applyEffects(player, boss, effects);
      if (checkBossDead(boss, manaUsed)) {
        continue;
      }
      const def = effects.shieldTimer > 0 ? 7 : 0;
      player.HP -= boss.ATK - def;
      if (player.HP > 0) {
        go(player, boss, effects, manaUsed);
      }
    }
  }

  go(
    playerStats,
    bossStats,
    { shieldTimer: 0, poisonTimer: 0, rechargeTimer: 0 },
    0
  );
  return currentMinManaUsed;
}

console.log("Part 1: " + part1and2(false));
console.log("Part 2: " + part1and2(true));
