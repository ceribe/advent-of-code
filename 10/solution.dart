import 'dart:io';

import '../utils.dart';

class Point {
  int x = 0;
  int y = 0;
  int xSpeed = 0;
  int ySpeed = 0;
  Point(String line) {
    final match = RegExp(
            r'^position=<\s*(-?\d+),\s*(-?\d+)> velocity=<\s*(-?\d+),\s*(-?\d+)>$')
        .firstMatch(line);
    if (match != null) {
      x = int.parse(match[1]!);
      y = int.parse(match[2]!);
      xSpeed = int.parse(match[3]!);
      ySpeed = int.parse(match[4]!);
    }
  }

  void move() {
    x += xSpeed;
    y += ySpeed;
  }
}

bool moreThan80PercentOfPointsHaveNeighbours(List<Point> points) {
  var neighboursCount = 0;
  // This could be reduced from 0(n^2) to 0(n) by using a 2D matrix or a set and marking points there so checking for
  // neightbours would be O(1), but since the input is small (about 300 points) it's not worth it
  for (var point in points) {
    for (var otherPoint in points) {
      if (point == otherPoint) continue;
      if (point.x == otherPoint.x) {
        if (point.y == otherPoint.y + 1 || point.y == otherPoint.y - 1) {
          neighboursCount++;
          break;
        }
      } else if (point.y == otherPoint.y) {
        if (point.x == otherPoint.x + 1 || point.x == otherPoint.x - 1) {
          neighboursCount++;
          break;
        }
      }
    }
  }
  return neighboursCount > points.length * 0.8;
}

void printMessage(List<Point> points) {
  final minX = points.map((point) => point.x).min;
  final maxX = points.map((point) => point.x).max;
  final minY = points.map((point) => point.y).min;
  final maxY = points.map((point) => point.y).max;

  final lightMap = Set<int>();
  points.forEach((point) {
    lightMap.add(point.x * 1000 + point.y);
  });

  for (var y = minY; y <= maxY; y++) {
    for (var x = minX; x <= maxX; x++) {
      if (lightMap.contains(x * 1000 + y)) {
        stdout.write('#');
      } else {
        stdout.write('.');
      }
    }
    stdout.writeln();
  }
}

dynamic part1and2(List<String> input) {
  final points = input.map(Point.new).toList();
  var seconds = 0;
  while (!moreThan80PercentOfPointsHaveNeighbours(points)) {
    points.forEach((point) => point.move());
    seconds++;
  }
  printMessage(points);
  return seconds;
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');

  check(3, part1and2(testInput));
  print(part1and2(input));
}
