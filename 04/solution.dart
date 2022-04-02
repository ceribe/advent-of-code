import '../utils.dart';

class Event {
  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;
  String event = "";
  Event(String line) {
    var words = line.replaceAll(RegExp(r'[\[\]\-:]'), " ").trim().split(" ");
    this.year = int.parse(words[0]);
    this.month = int.parse(words[1]);
    this.day = int.parse(words[2]);
    this.hour = int.parse(words[3]);
    this.minute = int.parse(words[4]);
    this.event = words[6] + " " + words[7];
  }
  int getDateAsNumber() {
    return this.month * 1000000 +
        this.day * 10000 +
        this.hour * 100 +
        this.minute;
  }
}

Map<int, Map<int, int>> getMinutesMap(List<String> input) {
  var events = input.map(Event.new).toList();
  events.sort((a, b) => a.getDateAsNumber().compareTo(b.getDateAsNumber()));
  var guardMinutesMap = <int, Map<int, int>>{};
  var guard = 0;
  var minute = 0;
  for (var event in events) {
    if (event.event.startsWith("Guard")) {
      guard = int.parse(event.event.split(" ")[1].replaceAll(RegExp(r'#'), ""));
    } else if (event.event.startsWith("falls")) {
      minute = event.minute;
    } else if (event.event.startsWith("wakes")) {
      if (guardMinutesMap[guard] == null) {
        guardMinutesMap[guard] = <int, int>{};
      }
      for (var i = minute; i < event.minute; i++) {
        guardMinutesMap[guard]?[i] = (guardMinutesMap[guard]?[i] ?? 0) + 1;
      }
    }
  }
  return guardMinutesMap;
}

dynamic part1(List<String> input) {
  var guardMinutesMap = getMinutesMap(input);
  var maxGuard = 0;
  var maxMinutes = 0;
  for (var guard in guardMinutesMap.keys) {
    var minutesMap = guardMinutesMap[guard];
    var sumMins = minutesMap?.values.sum ?? 0;
    if (sumMins > maxMinutes) {
      maxGuard = guard;
      maxMinutes = sumMins;
    }
  }
  var maxMinute = 0;
  var maxMinuteCount = 0;
  for (var minute in guardMinutesMap[maxGuard]!.keys) {
    var minuteCount = guardMinutesMap[maxGuard]![minute] ?? 0;
    if (minuteCount > maxMinuteCount) {
      maxMinute = minute;
      maxMinuteCount = minuteCount;
    }
  }
  return maxMinute * maxGuard;
}

dynamic part2(List<String> input) {
  var guardMinutesMap = getMinutesMap(input);
  var maxGuard = 0;
  var maxMinute = 0;
  var maxMinuteCount = 0;
  // Iterates through all guards and all minutes for that guard finding the minute that has the highest count
  for (var guard in guardMinutesMap.keys) {
    var minutesMap = guardMinutesMap[guard];
    for (var minute in minutesMap!.keys) {
      var minuteCount = minutesMap[minute] ?? 0;
      if (minuteCount > maxMinuteCount) {
        maxGuard = guard;
        maxMinute = minute;
        maxMinuteCount = minuteCount;
      }
    }
  }
  return maxGuard * maxMinute;
}

main() {
  var input = readFile('input.txt');
  var testInput = readFile('test_input.txt');

  check(240, part1(testInput));
  print(part1(input));

  check(4455, part2(testInput));
  print(part2(input));
}
