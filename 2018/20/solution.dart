import 'dart:math';

import '../utils.dart';

Map<Point, int> getDistances(String input) {
  final positions = <Point>[];
  var currentPosition = Point(0, 0);
  var previousPosition = Point(0, 0);
  final distances = <Point, int>{};
  final cleanedInput = input.substring(1, input.length - 1).split("");
  for (var char in cleanedInput) {
    switch (char) {
      case '(':
        positions.add(currentPosition);
        break;
      case ')':
        currentPosition = positions.removeLast();
        break;
      case '|':
        currentPosition = positions.last;
        break;
      default:
        final offset = Point.getOffsetFromChar(char);
        currentPosition += offset;

        distances[currentPosition] ??= 0;
        distances[previousPosition] ??= 0;

        if (distances[currentPosition] != 0) {
          distances[currentPosition] = min(
              distances[currentPosition]!, distances[previousPosition]! + 1);
        } else {
          distances[currentPosition] = distances[previousPosition]! + 1;
        }
    }
    previousPosition = currentPosition;
  }
  return distances;
}

dynamic part1(String input) {
  final distances = getDistances(input);
  return distances.values.max;
}

dynamic part2(String input) {
  final distances = getDistances(input);
  return distances.values.where((x) => x >= 1000).length;
}

main() {
  final input = readFirstLine('input.txt');

  final testInput1 = readFirstLine('test_input_1.txt');
  final testInput2 = readFirstLine('test_input_2.txt');
  final testInput3 = readFirstLine('test_input_3.txt');
  final testInput4 = readFirstLine('test_input_4.txt');
  final testInput5 = readFirstLine('test_input_5.txt');

  check(3, part1(testInput1));
  check(10, part1(testInput2));
  check(18, part1(testInput3));
  check(23, part1(testInput4));
  check(31, part1(testInput5));

  print(part1(input));
  print(part2(input));
}
