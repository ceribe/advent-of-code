import '../utils.dart';

dynamic part1(List<String> input) {
  return input.map(int.parse).sum;
}

dynamic part2(List<String> input) {
  final freqs = input.map(int.parse);
  final seen = {0};
  var current = 0;
  while (true) {
    for (var freq in freqs) {
      current += freq;
      if (seen.contains(current)) {
        return current;
      }
      seen.add(current);
    }
  }
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');

  check(3, part1(testInput));
  print(part1(input));

  check(2, part2(testInput));
  print(part2(input));
}
