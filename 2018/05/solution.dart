import '../utils.dart';

/// Checks if given letters are the same, but of different cases.
bool shouldBeDestroyed(String unit1, String unit2) {
  return unit1.toLowerCase() == unit2.toLowerCase() && unit1 != unit2;
}

List<String> getFullyReactedPolymer(List<String> polymer) {
  var pos = 0;
  // This could be done more efficiently if instead of removing elements from
  // array, we just marked them as removed. And while iterating, we could
  // just check if they are marked as removed and ignore them. Code would be
  // more complex, but it would be more efficient. That being said this solution
  // is more readable.
  while (pos < polymer.length - 1) {
    if (shouldBeDestroyed(polymer[pos], polymer[pos + 1])) {
      polymer.removeAt(pos);
      polymer.removeAt(pos);
      if (pos > 0) {
        pos--;
      }
    } else {
      pos++;
    }
  }
  return polymer;
}

dynamic part1(String input) {
  final polymer = input.split("");
  return getFullyReactedPolymer(polymer).length;
}

dynamic part2(String input) {
  final shortenedPolymer = getFullyReactedPolymer(input.split(""));
  return Iterable<int>.generate(26).toList().map((i) {
    final lLetter = String.fromCharCode(97 + i);
    final uLetter = lLetter.toUpperCase();
    final polymer = shortenedPolymer
        .where((unit) => unit != lLetter && unit != uLetter)
        .toList();
    return getFullyReactedPolymer(polymer).length;
  }).min;
}

main() {
  final input = readFirstLine("05", 'input.txt');
  final testInput = readFirstLine("05", 'test_input.txt');

  check(10, part1(testInput));
  print(part1(input));

  check(4, part2(testInput));
  print(part2(input));
}
