import 'dart:io';
import 'dart:math' as math;

// Reads file located at path and returns its content as list of lines
List<String> readFile(String path) {
  return File(path).readAsLinesSync();
}

// Checks if given values are equal
void check<T>(T expected, T actual) {
  if (expected != actual) {
    throw Exception('Expected $expected, but got $actual');
  }
}

extension UtilsIterableExtensions on Iterable<int> {
  int get sum => reduce((a, b) => a + b);
  int get min => reduce(math.min);
  int get max => reduce(math.max);
}
