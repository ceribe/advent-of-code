import '../utils.dart';

dynamic part1(List<String> input) {
  var doubles = 0;
  var triples = 0;
  for (var line in input) {
    var chars = line.codeUnits;
    var counts = <int, int>{};
    for (var char in chars) {
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
  var input = readFile('input.txt');
  var testInput = readFile('test_input.txt');
  var testInput2 = readFile('test_input_2.txt');

  check(12, part1(testInput));
  print(part1(input));

  check("fgij", part2(testInput2));
  print(part2(input));
}
