import 'dart:io';
import 'dart:math' as math;

/// Reads file located at [path] and returns its content as a list of lines
List<String> readInput(String day, String path) {
  return File("${day}/${path}").readAsLinesSync();
}

/// Reads first line of file located at [path] and returns its content as a string
String readFirstLine(String day, String path) {
  return readInput(day, path).first;
}

/// Checks if given values are equal
void check<T>(T expected, T actual) {
  if (expected != actual) {
    throw Exception('Expected $expected, but got $actual');
  }
}

extension UtilsIterableExtensions on Iterable<int> {
  int get sum => fold(0, (a, b) => a + b);
  int get min => reduce(math.min);
  int get max => reduce(math.max);
}

/// Parsers given [line] and returns a list of found integers
List<int> getIntegersFromLine(String line) {
  return line
      .replaceAll(RegExp(r'[^0-9\-]'), " ")
      .split(RegExp(r'\s+'))
      .where((x) => x.isNotEmpty)
      .map(int.parse)
      .toList();
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  Point get left => Point(x - 1, y);
  Point get right => Point(x + 1, y);
  Point get up => Point(x, y - 1);
  Point get down => Point(x, y + 1);

  @override
  int get hashCode => x.hashCode * 100000 + y.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  Point operator +(Point other) => Point(x + other.x, y + other.y);

  static getOffsetFromChar(String char) {
    switch (char) {
      case 'N':
        return Point(0, -1);
      case 'E':
        return Point(-1, 0);
      case 'S':
        return Point(0, 1);
      case 'W':
        return Point(1, 0);
      default:
        throw Exception('Unknown direction: $char');
    }
  }
}
