import '../utils.dart';

int getPowerLevel(int x, int y, int serial, Map<int, int> cache) {
  var key = x * 1000 + y;
  if (!cache.containsKey(key)) {
    var rackId = x + 10;
    var powerLevel = (rackId * y + serial) * rackId;
    powerLevel = ((powerLevel / 100) % 10).toInt();
    powerLevel -= 5;
    cache[key] = powerLevel;
  }
  return cache[key]!;
}

dynamic part1(int input) {
  var cache = Map<int, int>();
  var maxPower = 0;
  var maxCoords = "";
  for (var x = 1; x <= 298; x++) {
    for (var y = 1; y <= 298; y++) {
      var sum = 0;
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          sum += getPowerLevel(x + i, y + j, input, cache);
        }
      }
      if (sum > maxPower) {
        maxPower = sum;
        maxCoords = "$x,$y";
      }
    }
  }
  return maxCoords;
}

dynamic part2(int input) {
  var cache = Map<int, int>();
  var maxPower = 0;
  var maxIdentifier = "";
  for (var size = 1; size <= 19; size++) {
    for (var x = 1; x <= 300 - size + 1; x++) {
      for (var y = 1; y <= 300 - size + 1; y++) {
        var sum = 0;
        for (var i = 0; i < size; i++) {
          for (var j = 0; j < size; j++) {
            sum += getPowerLevel(x + i, y + j, input, cache);
          }
        }
        if (sum > maxPower) {
          maxPower = sum;
          maxIdentifier = "$x,$y,$size";
        }
      }
    }
  }
  return maxIdentifier;
}

main() {
  var input = 7672;
  var testInput1 = 18;
  var testInput2 = 42;

  check("33,45", part1(testInput1));
  check("21,61", part1(testInput2));
  print(part1(input));

  check("90,269,16", part2(testInput1));
  check("232,251,12", part2(testInput2));
  print(part2(input));
}
