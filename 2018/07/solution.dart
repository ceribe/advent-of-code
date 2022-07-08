import '../utils.dart';

Map<String, List<String>> getTasks(input) {
  final tasks = <String, List<String>>{};
  for (var line in input) {
    var match =
        RegExp(r'^Step (\w+) must be finished before step (\w+) can begin.')
            .firstMatch(line);
    if (match != null) {
      tasks[match[1]!] ??= [];
      (tasks[match[2]!] ??= []).add(match[1]!);
    }
  }
  return tasks;
}

/// Removes task from map of tasks and removes it from other tasks' lists
void removeTask(Map<String, List<String>> tasks, String task) {
  tasks.remove(task);
  for (var key in tasks.keys) {
    tasks[key]!.remove(task);
  }
}

dynamic part1(List<String> input) {
  final tasks = getTasks(input);
  var result = '';
  while (tasks.isNotEmpty) {
    // Gets ready tasks in alfabetical order
    final readyTasks = tasks.keys.where((key) => tasks[key]!.isEmpty).toList();
    readyTasks.sort();

    // Mark the first task as completed
    final task = readyTasks.first;
    result += task;
    removeTask(tasks, task);
  }
  return result;
}

int getTimeForTask(String task, int duration) {
  return task.codeUnitAt(0) - 64 + duration;
}

dynamic part2(List<String> input, int workersCount, int duration) {
  final tasks = getTasks(input);
  var result = 0;
  final workers = <String, int>{};
  while (tasks.isNotEmpty) {
    // Get all tasks which are ready and not being worked on
    final readyTasks = tasks.keys
        .where((key) => tasks[key]!.isEmpty && !workers.keys.contains(key))
        .toList();
    readyTasks.sort();

    // Assign tasks to workers
    for (var task in readyTasks) {
      if (workers.length >= workersCount) break;
      workers[task] = getTimeForTask(task, duration);
    }

    // Simulate one second
    result++;
    for (var key in workers.keys) {
      workers[key] = workers[key]! - 1;
    }

    // Remove completed tasks and free workers
    for (var key in workers.keys.toList()) {
      if (workers[key] == 0) {
        removeTask(tasks, key);
        workers.remove(key);
      }
    }
  }
  return result;
}

main() {
  final input = readInput("07", 'input.txt');
  final testInput = readInput("07", 'test_input.txt');

  check("CABDFE", part1(testInput));
  print(part1(input));

  check(15, part2(testInput, 2, 0));
  print(part2(input, 5, 60));
}
