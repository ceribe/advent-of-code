import 'dart:io';

import '../utils.dart';

/// Parses [input] and returns map containing a spring of water and clay
Map<Point, String> getInitialMap(List<String> input) {
  final map = <Point, String>{};
  map[Point(500, 0)] = "|";
  for (final line in input) {
    final numbers = getIntegersFromLine(line);
    if (line[0] == "x") {
      final x = numbers[0];
      final y1 = numbers[1];
      final y2 = numbers[2];
      for (var y = y1; y <= y2; y++) {
        map[Point(x, y)] = "#";
      }
    } else {
      final y = numbers[0];
      final x1 = numbers[1];
      final x2 = numbers[2];
      for (var x = x1; x <= x2; x++) {
        map[Point(x, y)] = "#";
      }
    }
  }
  return map;
}

void printMap(Map<Point, String> map) {
  final minX = map.keys.map((point) => point.x).min;
  final maxX = map.keys.map((point) => point.x).max;
  final minY = map.keys.map((point) => point.y).min;
  final maxY = map.keys.map((point) => point.y).max;

  for (var y = minY; y <= maxY; y++) {
    for (var x = minX; x <= maxX; x++) {
      stdout.write(map[Point(x, y)] ?? ".");
    }
    print("");
  }
  print("");
}

/// A [tile] is supported if it is over a clay tile or still water
bool isTileSupported(Point tile, Map<Point, String> map) {
  final tileBelow = tile.down;
  return map[tileBelow] == "#" || map[tileBelow] == "~";
}

dynamic part1and2(List<String> input) {
  final map = getInitialMap(input);

  bool isClay(Point point) => map[point] == "#";
  final lowestClayY = map.keys.map((point) => point.y).max;
  final highestClayY = map.keys.where(isClay).map((point) => point.y).min;

  final openSet = <Point>{Point(500, 0)};

  void placeFlowingWaterIfEmpty(Point point) {
    if (map[point] == null) {
      map[point] = "|";
      openSet.add(point);
    }
  }

  void spreadWaterHorizontally(Point point) {
    var isFullySupported = true;
    placeFlowingWaterIfEmpty(point);

    // Spread moving water to the left until it hits clay or is no longer supported
    var leftNeighbor = point.left;
    while (map[leftNeighbor] != "#") {
      placeFlowingWaterIfEmpty(leftNeighbor);
      if (!isTileSupported(leftNeighbor, map)) {
        isFullySupported = false;
        break;
      }
      leftNeighbor = leftNeighbor.left;
    }

    // Spread moving water to the right until it hits clay or is no longer supported
    var rightNeighbor = point.right;
    while (map[rightNeighbor] != "#") {
      placeFlowingWaterIfEmpty(rightNeighbor);
      if (!isTileSupported(rightNeighbor, map)) {
        isFullySupported = false;
        break;
      }
      rightNeighbor = rightNeighbor.right;
    }

    // If every placed tile was supported then all tiles have to be changed to still water
    // and open set updated
    if (isFullySupported) {
      // First non-clay tile to the left
      leftNeighbor = leftNeighbor.right;
      while (leftNeighbor != rightNeighbor) {
        // Add all flowing water tiles from higher level to open set
        // so they can be spread horizontally
        if (map[leftNeighbor.up] == "|") {
          openSet.add(leftNeighbor.up);
        }
        // Override all tiles to still water
        map[leftNeighbor] = "~";
        openSet.remove(leftNeighbor);

        leftNeighbor = leftNeighbor.right;
      }
    }
  }

  while (openSet.isNotEmpty) {
    final point = openSet.first;
    openSet.remove(point);

    final isPointAboveLowestClay = point.y < lowestClayY;
    if (!isPointAboveLowestClay) {
      continue;
    }

    final pointBelow = point.down;
    final type = map[pointBelow];
    // Move water downwards if possible, if not spread it horizontally
    if (type == null) {
      placeFlowingWaterIfEmpty(pointBelow);
    } else if (type == "#" || type == "~") {
      spreadWaterHorizontally(point);
    }
  }

  var waterCount = 0;
  var stillWaterCount = 0;
  for (final point in map.keys) {
    final type = map[point];
    final isMovingWater = type == "|";
    final isStillWater = type == "~";
    final isWater = isMovingWater || isStillWater;
    final isInBounds = point.y <= lowestClayY && point.y >= highestClayY;
    if (isWater && isInBounds) {
      waterCount++;
      if (isStillWater) {
        stillWaterCount++;
      }
    }
  }

  return "$waterCount, $stillWaterCount";
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');

  check("57, 29", part1and2(testInput));
  print(part1and2(input));
}
