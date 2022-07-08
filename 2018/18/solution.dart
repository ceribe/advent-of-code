import '../utils.dart';

dynamic part1(List<String> input, int minutesCount) {
  var currMap = input.map((e) => e.split("")).toList();
  for (var i = 0; i < minutesCount; i++) {
    currMap = simulateOneMinute(currMap);
  }
  var woodedAcresCount = currMap.fold<int>(
      0, (acc, row) => acc + row.where((acre) => acre == "#").length);
  var lumberYardsCount = currMap.fold<int>(
      0, (acc, row) => acc + row.where((acre) => acre == "|").length);

  return woodedAcresCount * lumberYardsCount;
}

List<List<String>> simulateOneMinute(List<List<String>> map) {
  final mapSize = map.length;
  var newMap = List.generate(mapSize, (_) => List.generate(mapSize, (_) => ""));
  for (var x = 0; x < mapSize; x++) {
    for (var y = 0; y < mapSize; y++) {
      final adjecentAcres = getAdjecentAcres(map, x, y);
      switch (map[x][y]) {
        case ".":
          final atLeastThreeAreTrees =
              adjecentAcres.where((e) => e == "|").length >= 3;
          if (atLeastThreeAreTrees)
            newMap[x][y] = "|";
          else
            newMap[x][y] = ".";
          break;
        case "|":
          final atLeastThreeAreLumberyards =
              adjecentAcres.where((e) => e == "#").length >= 3;
          if (atLeastThreeAreLumberyards)
            newMap[x][y] = "#";
          else
            newMap[x][y] = "|";
          break;
        case "#":
          final atLeastOneIsLumberyard =
              adjecentAcres.where((e) => e == "#").length >= 1;
          final atLeastOneIsTree =
              adjecentAcres.where((e) => e == "|").length >= 1;
          if (atLeastOneIsLumberyard && atLeastOneIsTree)
            newMap[x][y] = "#";
          else
            newMap[x][y] = ".";
          break;
      }
    }
  }
  return newMap;
}

List<String> getAdjecentAcres(List<List<String>> map, int x, int y) {
  final adjecentAcres = <String>[];
  for (var xOffset = -1; xOffset <= 1; xOffset++) {
    final newX = x + xOffset;
    if (newX < 0 || newX >= map.length) {
      continue;
    }
    for (var yOffset = -1; yOffset <= 1; yOffset++) {
      final newY = y + yOffset;
      if (newY < 0 || newY >= map.length) {
        continue;
      }
      if (xOffset == 0 && yOffset == 0) {
        continue;
      }
      adjecentAcres.add(map[newX][newY]);
    }
  }
  return adjecentAcres;
}

dynamic part2(List<String> input) {}

main() {
  final input = readInput("18", 'input.txt');
  final testInput = readInput("18", 'test_input.txt');

  check(1147, part1(testInput, 10));
  print(part1(input, 10));
  print(part1(input, 1000));
}
