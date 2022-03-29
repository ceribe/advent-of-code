import 'dart:io';

// Reads file located at path and returns its content as list of lines
List<String> readFile(String path) {
  return File(path).readAsLinesSync();
}

// Checks if given values are equal
void check(dynamic expected, dynamic actual) {
  if (expected != actual) {
    throw Exception('Expected $expected, but got $actual');
  }
}