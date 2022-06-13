import 'dart:io';
import 'dart:math' as math;

/// Reads file located at [path] and returns its content as a list of lines
List<String> readFile(String path) {
  return File(path).readAsLinesSync();
}

/// Reads first line of file located at [path] and returns its content as a string
String readFirstLine(String path) {
  return File(path).readAsStringSync().split('\n').first;
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
      .replaceAll(RegExp(r'[^0-9]'), " ")
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
}
