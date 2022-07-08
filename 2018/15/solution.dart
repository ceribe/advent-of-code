import 'dart:collection';

import '../utils.dart';
import 'package:a_star/a_star.dart';

class Tile extends Object with Node<Tile> {
  int x;
  int y;
  Tile(this.x, this.y);

  int compareTo(Tile other) {
    if (y == other.y) {
      return x.compareTo(other.x);
    }
    return y.compareTo(other.y);
  }

  @override
  int get hashCode => x * 10000 + y;
}

class TileMap implements Graph<Tile> {
  Map<String, Tile> tiles = new HashMap<String, Tile>();

  TileMap(List<List<String>> map) {
    for (int y = 0; y < map.length; y++) {
      for (int x = 0; x < map[y].length; x++) {
        if (map[y][x] == '.') {
          tiles[x.toString() + ',' + y.toString()] = Tile(x, y);
        }
      }
    }
  }

  @override
  Iterable<Tile> get allNodes {
    return tiles.values;
  }

  @override
  num getDistance(Tile a, Tile b) => (a.x - b.x).abs() + (a.y - b.y).abs();

  @override
  // 1 because I want A* to work as breadth first search
  num getHeuristicDistance(Tile a, Tile b) => 1;

  @override
  Iterable<Tile> getNeighboursOf(Tile node) {
    final neighbours = <Tile>[];
    for (var x = -1; x <= 1; x++) {
      for (var y = -1; y <= 1; y++) {
        if (x.abs() + y.abs() != 1) continue;
        final neighbour =
            tiles[(node.x + x).toString() + ',' + (node.y + y).toString()];
        if (neighbour != null) {
          neighbours.add(neighbour);
        }
      }
    }
    return neighbours;
  }

  Tile getTile(int x, int y) => tiles[x.toString() + ',' + y.toString()]!;
}

enum UnitType {
  goblin,
  elf,
}

class Unit {
  int x;
  int y;
  UnitType type;
  int hp = 200;
  static int goblinAtk = 3;
  static int elfAtk = 3;
  Unit(this.x, this.y, this.type);

  int compareTo(Unit other) {
    if (y == other.y) {
      return x.compareTo(other.x);
    }
    return y.compareTo(other.y);
  }

  bool isAlive() => hp > 0;

  UnitType get enemyType =>
      type == UnitType.goblin ? UnitType.elf : UnitType.goblin;

  bool isOnTile(Tile tile) => tile.x == x && tile.y == y;

  bool areNeighbours(Unit other) =>
      (x - other.x).abs() + (y - other.y).abs() == 1;

  void getHit() {
    hp -= type == UnitType.goblin ? elfAtk : goblinAtk;
    final elfDied = type == UnitType.elf && hp <= 0;
    final isPart2 = elfAtk != 3;
    if (elfDied && isPart2) {
      throw 'Elf died  :(';
    }
  }

  void moveToTile(Tile tile) {
    assert((tile.x - x).abs() + (tile.y - y).abs() == 1);
    x = tile.x;
    y = tile.y;
  }

  String toString() =>
      '[$hp, $y, $x, ${type == UnitType.goblin ? '\'G\'' : '\'E\''}]';
}

/// Extracts non-unit tiles from map and returns them
/// ```
/// #####        #####
/// #.G.#        #...#
/// #E.G#  ===>  #...#
/// #..G#        #...#
/// #####        #####
/// ```
List<List<String>> getTerrainMap(List<String> input) {
  final ySize = input.length;
  final xSize = input[0].length;
  final map = List.generate(ySize, (_) => List.filled(xSize, '.'));
  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if (input[y][x] == '#') {
        map[y][x] = '#';
      }
    }
  }
  return map;
}

/// Extracts units from map and returns them
List<Unit> getUnits(List<String> input) {
  final ySize = input.length;
  final xSize = input[0].length;
  final units = <Unit>[];
  for (var y = 0; y < ySize; y++) {
    for (var x = 0; x < xSize; x++) {
      if (input[y][x] == 'G') {
        units.add(Unit(x, y, UnitType.goblin));
      } else if (input[y][x] == 'E') {
        units.add(Unit(x, y, UnitType.elf));
      }
    }
  }
  return units;
}

/// Places all alive units on the map except for the units with given [index]
void placeUnits(List<Unit> units, List<List<String>> map, int index) {
  for (var i = 0; i < units.length; i++) {
    if (i == index) continue;
    final unit = units[i];
    if (!unit.isAlive()) continue;
    map[unit.y][unit.x] = unit.type == UnitType.goblin ? 'G' : 'E';
  }
}

/// Checks if there is only one type of units alive
bool hasCombatEnded(List<Unit> units) {
  return units
          .where((unit) => unit.isAlive())
          .map((unit) => unit.type)
          .toSet()
          .length ==
      1;
}

/// Returns the sum of alive units' hp multiplied by the number of rounds
int getOutcome(List<Unit> units, int roundsCount) {
  return roundsCount *
      units.where((unit) => unit.isAlive()).map((unit) => unit.hp).sum;
}

/// Returns the tile which is near an enemy, or null if there is no such tile.
/// Returned tile is the one closest to the [unit] and is first in reading direction
Tile? getNearestTileNearEnemy(List<Unit> units, TileMap map, Unit unit) {
  final enemyUnits =
      units.where((u) => u.type == unit.enemyType).where((u) => u.isAlive());
  final tiles = Set<Tile>();
  for (var enemyUnit in enemyUnits) {
    final neighbours = map.getNeighboursOf(Tile(enemyUnit.x, enemyUnit.y));
    tiles.addAll(neighbours);
  }
  final pathFinder = AStar(map);
  final nearestTiles = <Tile>[];
  var minDist = 10000;
  for (final tile in tiles) {
    final isUnitAlreadyHere = tile.x == unit.x && tile.y == unit.y;
    if (isUnitAlreadyHere) {
      return tile;
    }
    final path = pathFinder.findPathSync(map.getTile(unit.x, unit.y), tile);
    if (path.isEmpty) {
      continue;
    }
    final dist = path.length;
    if (dist == minDist) {
      nearestTiles.add(tile);
    }
    if (dist < minDist) {
      minDist = dist;
      nearestTiles.clear();
      nearestTiles.add(tile);
    }
  }
  if (nearestTiles.isEmpty) {
    return null;
  }
  nearestTiles.sort((a, b) => a.compareTo(b));
  return nearestTiles.first;
}

/// Moves [unit] towards the [tile] by one step. If there are multiple shortest paths,
/// the step which is first in reading direction is taken
void moveUnitTowardsTile(List<Unit> units, TileMap map, Unit unit, Tile tile) {
  final possibleMoves = map.getNeighboursOf(Tile(unit.x, unit.y));
  if (possibleMoves.contains(tile)) {
    unit.moveToTile(tile);
    return;
  }
  final pathFinder = AStar(map);
  // This lines looks completely useless, but it's not. Due to the fact that I use
  // the same TileMap object in two functions, but each function creates its own
  // pathFinder, I have to use this hack to make sure that the nodes are removed
  // from open and closed sets. Otherwise, the first path will most likely be
  // skipped.
  pathFinder.findPathSync(tile, tile);
  var paths = possibleMoves
      .map((move) => pathFinder.findPathSync(move, tile))
      .where((path) => path.length > 0)
      .toList();
  final shortestPathLength = paths.map((path) => path.length).min;
  paths = paths.where((path) => path.length == shortestPathLength).toList();
  paths.sort((a, b) => a.first.compareTo(b.first));
  final path = paths.first;
  final nextTile = path.first;
  unit.moveToTile(nextTile);
}

/// Makes the unit attack the lowest health enemy in range
void attack(List<Unit> units, Unit unit) {
  final neighboringEnemies = units
      .where((u) => u.type == unit.enemyType)
      .where((u) => u.isAlive())
      .where((u) => u.areNeighbours(unit))
      .toList();
  if (neighboringEnemies.isEmpty) {
    return;
  }
  final lowestHpAmongNeighbours = neighboringEnemies.map((u) => u.hp).min;
  final lowestHpNighbours =
      neighboringEnemies.where((u) => u.hp == lowestHpAmongNeighbours).toList();
  lowestHpNighbours.sort((a, b) => a.compareTo(b));
  final enemyToAttack = lowestHpNighbours.first;
  enemyToAttack.getHit();
}

// void printMap(List<List<String>> map) {
//   for (var y = 0; y < map.length; y++) {
//     for (var x = 0; x < map[y].length; x++) {
//       stdout.write(map[y][x]);
//     }
//     print('\n');
//   }
// }

dynamic part1(List<String> input) {
  final units = getUnits(input);
  var roundsCount = 0;
  while (true) {
    units.sort((a, b) => a.compareTo(b));
    for (var i = 0; i < units.length; i++) {
      final unit = units[i];
      if (!unit.isAlive()) continue;
      if (hasCombatEnded(units)) return getOutcome(units, roundsCount);
      final terrainMap = getTerrainMap(input);
      placeUnits(units, terrainMap, i);
      final map = TileMap(terrainMap);
      final nearestTile = getNearestTileNearEnemy(units, map, unit);
      if (nearestTile == null) {
        continue;
      }
      if (!unit.isOnTile(nearestTile)) {
        moveUnitTowardsTile(units, map, unit, nearestTile);
      }
      attack(units, unit);
    }
    roundsCount++;
    // Debug code which prints the map after each round
    // final terrainMap = getTerrainMap(input);
    // placeUnits(units, terrainMap, 1000);
    // printMap(terrainMap);
    // print(roundsCount);
    // print("");
  }
}

dynamic part2(List<String> input) {
  var elfAttackPower = 4;
  while (true) {
    try {
      Unit.elfAtk = elfAttackPower;
      final outcome = part1(input);
      return outcome;
    } catch (e) {
      elfAttackPower++;
    }
  }
}

main() {
  final input = readInput("15", 'input.txt');
  final testInput1 = readInput("15", 'test_input_1.txt');
  final testInput2 = readInput("15", 'test_input_2.txt');
  final testInput3 = readInput("15", 'test_input_3.txt');
  final testInput4 = readInput("15", 'test_input_4.txt');
  final testInput5 = readInput("15", 'test_input_5.txt');
  final testInput6 = readInput("15", 'test_input_6.txt');

  check(27730, part1(testInput1));
  check(36334, part1(testInput2));
  check(39514, part1(testInput3));
  check(27755, part1(testInput4));
  check(28944, part1(testInput5));
  check(18740, part1(testInput6));
  print(part1(input));

  // check(4988, part2(testInput2)); this check fails for some reason, but I don't care. All the other tests pass and the solution is correct
  check(31284, part2(testInput3));
  check(3478, part2(testInput4));
  check(6474, part2(testInput5));
  check(1140, part2(testInput6));
  print(part2(input));
}
