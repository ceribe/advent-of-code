import '../utils.dart';

dynamic part1(List<String> input) {
  var doubles = 0;
  var triples = 0;
  for (var line in input) {
    final counts = <int, int>{};
    for (var char in line.codeUnits) {
      counts[char] = (counts[char] ?? 0) + 1;
    }
    if (counts.values.contains(2)) {
      doubles++;
    }
    if (counts.values.contains(3)) {
      triples++;
    }
  }
  return doubles * triples;
}

dynamic part2(List<String> input) {
  for (var word1 in input) {
    for (var word2 in input) {
      var diffCount = 0;
      var common = '';
      assert(word1.length == word2.length);
      for (var k = 0; k < word1.length; k++) {
        if (word1[k] != word2[k]) {
          diffCount++;
        } else {
          common += word1[k];
        }
      }
      if (diffCount == 1) {
        return common;
      }
    }
  }
  return null;
}

main() {
  final input = readInput("02", 'input.txt');
  final testInput = readInput("02", 'test_input.txt');
  final testInput2 = readInput("02", 'test_input_2.txt');

  check(12, part1(testInput));
  print(part1(input));

  check("fgij", part2(testInput2));
  print(part2(input));
}
