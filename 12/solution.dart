import '../utils.dart';

/// Returns a map of pots. The key is the index of the pot,
/// and the value is 1 if there is a plant in that pot, 0 otherwise.
Map<int, int> getInitialPots(String pots) {
  final initialPots = <int, int>{};
  for (var i = 0; i < pots.length; i++) {
    if (pots[i] == '#') {
      initialPots[i] = 1;
    }
  }
  return initialPots;
}

/// Returns a map of rules. The key is the pattern of pots interpreted as a binary
/// number, and the value is the result of applying the rule to the pattern.
Map<int, int> getRules(List<String> input) {
  final rules = <int, int>{};
  for (var i = 0; i < input.length; i++) {
    final rule = input[i];
    final split = rule.split(' => ');
    final key =
        int.parse(split[0].replaceAll("#", "1").replaceAll(".", "0"), radix: 2);
    final value = split[1] == '#' ? 1 : 0;
    rules[key] = value;
  }
  return rules;
}

/// Returns key for given offset. Each key is a number of 5 bits. Two to the left
/// of offset, middle and two to the right of offset.
int getKey(Map<int, int> pots, int offset) {
  var key = 0;
  for (var i = 0; i < 5; i++) {
    key = key << 1;
    key += pots[i + offset - 2] ?? 0;
  }
  return key;
}

/// Simulates one generation
Map<int, int> getNextGeneration(Map<int, int> pots, Map<int, int> rules) {
  final nextGeneration = <int, int>{};
  final min = pots.keys.min;
  final max = pots.keys.max;
  for (var i = min - 2; i <= max + 2; i++) {
    final key = getKey(pots, i);
    final value = rules[key] ??= 0;
    nextGeneration[i] = value;
  }
  return nextGeneration;
}

int getSumOfPots(Map<int, int> pots) {
  return pots.entries.map((e) => e.value * e.key).sum;
}

dynamic part1(List<String> input) {
  var pots = getInitialPots(input[0].split(' ')[2]);
  final rules = getRules(input.sublist(2));
  for (var i = 0; i < 20; i++) {
    pots = getNextGeneration(pots, rules);
  }
  return getSumOfPots(pots);
}

dynamic part2(List<String> input) {
  var pots = getInitialPots(input[0].split(' ')[2]);
  final rules = getRules(input.sublist(2));
  for (var i = 0; i < 999; i++) {
    pots = getNextGeneration(pots, rules);
  }
  // After some iterations the increase rate stabilizes, so we can
  // calculate the delta and simply multiply it by the number of needed
  // iterations and add it to the current sum
  final s999 = getSumOfPots(pots);
  pots = getNextGeneration(pots, rules);
  final s1000 = getSumOfPots(pots);
  final delta = s1000 - s999;
  return s1000 + (50000000000 - 1000) * delta;
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');

  check(325, part1(testInput));
  print(part1(input));
  print(part2(input));
}
