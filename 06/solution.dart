import '../utils.dart';

class Point {
  int x = 0;
  int y = 0;

  Point.line(String line) {
    var parts = line.split(',');
    x = int.parse(parts[0]);
    y = int.parse(parts[1]);
  }

  Point(this.x, this.y);
}

int manhattanDistance(Point p1, Point p2) =>
    (p1.x - p2.x).abs() + (p1.y - p2.y).abs();

List<Point> parseInput(List<String> input) {
  return input.map(Point.line).toList();
}

dynamic part1(List<String> input) {
  var points = parseInput(input);
  var xSize = points.map((point) => point.x).max + 1;
  var ySize = points.map((point) => point.y).max + 1;
  var map = new List<List<List<int>>>.generate(
      xSize, (x) => new List<List<int>>.generate(ySize, (y) => [-1, 99999]));

  // Find closest point for each coordinate.
  // -1 means that there is no closest point
  // (so far or there are two or more with equal distance)
  for (var x = 0; x < map.length; x++) {
    for (var y = 0; y < map[x].length; y++) {
      for (var p = 0; p < points.length; p++) {
        if (map[x][y][1] > manhattanDistance(Point(x, y), points[p])) {
          map[x][y] = [p, manhattanDistance(Point(x, y), points[p])];
        } else if (map[x][y][1] == manhattanDistance(Point(x, y), points[p])) {
          map[x][y][0] = -1;
        }
      }
    }
  }

  // Check which areas are infinite
  var inifinite = <int>{};
  for (var x = 0; x < xSize; x++) {
    inifinite.add(map[x][0][0]);
    inifinite.add(map[x][ySize - 1][0]);
  }
  for (var y = 0; y < ySize; y++) {
    inifinite.add(map[0][y][0]);
    inifinite.add(map[xSize - 1][y][0]);
  }

  // Find the biggest finite area
  var finite = <int, int>{};
  for (var x = 0; x < xSize; x++) {
    for (var y = 0; y < ySize; y++) {
      if (map[x][y][0] != -1 && !inifinite.contains(map[x][y][0])) {
        finite[map[x][y][0]] = (finite[map[x][y][0]] ?? 0) + 1;
      }
    }
  }
  return finite.values.max;
}

dynamic part2(List<String> input, int maxDist) {
  var points = parseInput(input);
  var xSize = points.map((point) => point.x).max + 1;
  var ySize = points.map((point) => point.y).max + 1;
  var count = 0;
  for (var x = 0; x < xSize; x++) {
    for (var y = 0; y < ySize; y++) {
      var sum = 0;
      points.forEach((point) {
        sum += manhattanDistance(Point(x, y), point);
      });
      if (sum < maxDist) {
        count++;
      }
    }
  }
  return count;
}

main() {
  var input = readFile('input.txt');
  var testInput = readFile('test_input.txt');

  check(17, part1(testInput));
  print(part1(input));

  check(16, part2(testInput, 32));
  print(part2(input, 10000));
}
