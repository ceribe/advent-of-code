import 'package:collection/collection.dart';
import '../utils.dart';

List<List<int>> getCaveMap(List<int> input, int bonusSize) {
  final caveSystemDepth = input[0];
  final target = Point(input[1], input[2]);
  final erosionLevelMap = List.generate(target.y + 1 + bonusSize, (_) {
    return List.filled(target.x + 1 + bonusSize, 0);
  });
  for (var y = 0; y <= target.y + bonusSize; y++) {
    for (var x = 0; x <= target.x + bonusSize; x++) {
      var geologicIndex = 0;
      if ((y == 0 && x == 0) || (y == target.y && x == target.x)) {
        geologicIndex = 0;
      } else if (y == 0) {
        geologicIndex = x * 16807;
      } else if (x == 0) {
        geologicIndex = y * 48271;
      } else {
        geologicIndex = erosionLevelMap[y - 1][x] * erosionLevelMap[y][x - 1];
      }
      var erosionLevel = (geologicIndex + caveSystemDepth) % 20183;
      erosionLevelMap[y][x] = erosionLevel;
    }
  }
  final caveMap = erosionLevelMap
      .map((row) => row.map((erosionLevel) => erosionLevel % 3).toList())
      .toList();
  return caveMap;
}

dynamic part1(List<int> input) {
  final caveMap = getCaveMap(input, 0);
  final totalRiskLevel = caveMap
      .fold<int>(0, (acc, row) => acc + row.reduce((acc2, e) => acc2 + e));
  return totalRiskLevel;
}

enum Tool {
  torch,
  climbingGear,
  neither,
}

final tools = [Tool.torch, Tool.climbingGear, Tool.neither];

enum Region {
  rocky,
  wet,
  narrow,
}

Region getRegion(int type) {
  switch (type) {
    case 0:
      return Region.rocky;
    case 1:
      return Region.wet;
    case 2:
      return Region.narrow;
  }
  throw Exception('Invalid erosion level');
}

final Map<Region, List<Tool>> toolMap = {
  Region.rocky: [Tool.climbingGear, Tool.torch],
  Region.wet: [Tool.climbingGear, Tool.neither],
  Region.narrow: [Tool.torch, Tool.neither],
};

/// Returns tool which can be used in both regions.
Tool getToolForRegions(Region region1, Region region2) {
  final tools = toolMap[region1]!;
  return tools.firstWhere((tool) => toolMap[region2]!.contains(tool));
}

/// Returns true if [region] can be entered with given [tool].
bool canEnter(Region region, Tool tool) {
  final tools = toolMap[region]!;
  return tools.contains(tool);
}

class State {
  final Point position;
  final Tool tool;
  final int time;

  State(this.position, this.tool, this.time);
}

dynamic part2(List<int> input) {
  final caveMap = getCaveMap(input, 100);
  final target = Point(input[1], input[2]);
  final dp = <Tool, List<List<int>>>{};
  for (var tool in tools) {
    dp[tool] = List.generate(caveMap.length, (_) => List.filled(caveMap[0].length, 99999999));
  }
  final offsets = [
    Point(0, 1),
    Point(1, 0),
    Point(0, -1),
    Point(-1, 0),
  ];
  final queue = PriorityQueue<State>((a, b) => a.time.compareTo(b.time));
  queue.add(State(Point(0, 0), Tool.torch, 0));

  while (true) {
    final state = queue.removeFirst();
    if (state.position == Point(target.x, target.y)) {
      return state.time + (state.tool != Tool.torch ? 7 : 0);
    }
    for (var offset in offsets) {
      final newPosition = state.position + offset;
      if (newPosition.x < 0 ||
          newPosition.y < 0 ||
          newPosition.x >= caveMap[0].length ||
          newPosition.y >= caveMap.length) {
        continue;
      }
      final region = getRegion(caveMap[state.position.y][state.position.x]);
      final newRegion = getRegion(caveMap[newPosition.y][newPosition.x]);
      var cost = 1;
      var tool = state.tool;
      if (!canEnter(newRegion, tool)) {
        tool = getToolForRegions(region, newRegion);
        cost += 7;
      }
      if (dp[tool]![newPosition.y][newPosition.x] > state.time + cost) {
        dp[tool]![newPosition.y][newPosition.x] = state.time + cost;
        queue.add(State(newPosition, tool, state.time + cost));
      }
    }
  }
}

main() {
  final testInput = [510, 10, 10];
  final input = [8103, 9, 758];

  check(114, part1(testInput));
  print(part1(input));

  check(45, part2(testInput));
  print(part2(input));
}
