import 'dart:math';

import '../utils.dart';

class Point3 {
  final int x;
  final int y;
  final int z;

  Point3(this.x, this.y, this.z);

  int manhattanDistanceTo(Point3 other) {
    return (x - other.x).abs() + (y - other.y).abs() + (z - other.z).abs();
  }

  Point3 operator +(Point3 other) =>
      Point3(x + other.x, y + other.y, z + other.z);

  Point3 operator *(int factor) => Point3(x * factor, y * factor, z * factor);
}

class Nanobot {
  late Point3 position;
  final int radius;

  Nanobot(x, y, z, this.radius) {
    position = Point3(x, y, z);
  }

  bool isInRange(Nanobot other) {
    return position.manhattanDistanceTo(other.position) <= radius;
  }

  bool isInRangeOfPosition(Point3 point) {
    return position.manhattanDistanceTo(point) <= radius;
  }
}

List<Nanobot> parseInput(List<String> input) {
  return input
      .map((line) => getIntegersFromLine(line))
      .map((line) => Nanobot(line[0], line[1], line[2], line[3]))
      .toList();
}

dynamic part1(List<String> input) {
  final nanobots = parseInput(input);
  final strongestNanobot =
      nanobots.reduce((a, b) => a.radius > b.radius ? a : b);
  return nanobots.where(strongestNanobot.isInRange).length;
}

int calculateNumberOfNanobotsInRange(Point3 position, List<Nanobot> nanobots) {
  final nanobotsInRange = nanobots
      .where((nanobot) => nanobot.isInRangeOfPosition(position))
      .toList();
  return nanobotsInRange.length;
}

List<Point3> getPossibleOffsets() {
  final possibleOffsets = <Point3>[];
  for (var x = -1; x <= 1; x++) {
    for (var y = -1; y <= 1; y++) {
      for (var z = -1; z <= 1; z++) {
        if (x == 0 && y == 0 && z == 0) {
          continue;
        }
        possibleOffsets.add(Point3(x, y, z));
      }
    }
  }
  return possibleOffsets;
}

dynamic part2(List<String> input) {
  final nanobots = parseInput(input);
  final offsets = getPossibleOffsets();
  var bestPosition = Point3(0, 0, 0);
  var bestScore = 0; // Number of nanobots in range of bestPosition
  var bestDistance = 0; // Distance from bestPosition to the origin
  // ! If the optimal position is not found uncomment the loop below
  // for (var _ = 0; _ < 5; _++) {
  for (var zoomExponent = 30; zoomExponent >= 0; zoomExponent--) {
    for (final offset in offsets) {
      final zoom = pow(2, zoomExponent).toInt();
      final position = bestPosition + offset * zoom;
      final distToOrigin = position.manhattanDistanceTo(Point3(0, 0, 0));
      final score = calculateNumberOfNanobotsInRange(position, nanobots);
      if (score > bestScore ||
          (score == bestScore && bestDistance > distToOrigin)) {
        bestScore = score;
        bestDistance = distToOrigin;
        bestPosition = position;
      }
    }
  }
  // }
  return bestDistance;
}

main() {
  final input = readInput("23", 'input.txt');
  final testInput = readInput("23", 'test_input.txt');
  final testInput2 = readInput("23", 'test_input_2.txt');

  check(7, part1(testInput));
  print(part1(input)); // 935

  check(36, part2(testInput2));
  print(part2(input)); // 138697281
}
