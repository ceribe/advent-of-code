import '../utils.dart';

class CircularNode {
  int value;
  CircularNode? next = null;
  CircularNode? prev = null;

  CircularNode(this.value, [this.next, this.prev]);
}

// I am using exclamation marks instead of question marks, because I know that variables here will not
// be null. And if they are null that means I made a mistake somewhere in the implementation
// so an exception should be thrown instead of silently working with nulls.
class CircularList {
  CircularNode? head;

  /// Adds a new node at head position and places head as the next node of the new node
  void add(int value) {
    if (head == null) {
      head = CircularNode(value);
      head!.next = head;
      head!.prev = head;
    } else {
      CircularNode newNode = CircularNode(value);
      newNode.next = head;
      newNode.prev = head!.prev;
      head!.prev!.next = newNode;
      head!.prev = newNode;
      head = newNode;
    }
  }

  /// Removes head node and returns its value
  int remove() {
    if (head == null) {
      return 0;
    }
    var value = head!.value;
    head!.next!.prev = head!.prev;
    head!.prev!.next = head!.next;
    head = head!.next;
    return value;
  }

  /// Moves head "times" positions forward (right)
  void rotateForward(int times) {
    if (head == null) {
      return;
    }
    for (int i = 0; i < times; i++) {
      head = head!.next;
    }
  }

  /// Moves head "times" positions backward (left)
  void rotateBackward(int times) {
    if (head == null) {
      return;
    }
    for (int i = 0; i < times; i++) {
      head = head!.prev;
    }
  }
}

dynamic part1and2(String input, [int multiplier = 1]) {
  final match =
      RegExp(r'^([0-9]+) players; last marble is worth ([0-9]+) points')
          .firstMatch(input)!;
  final players = int.parse(match[1]!);
  final lastMarble = int.parse(match[2]!);
  final scores = List.filled(players, 0);
  final circle = CircularList();
  circle.add(0);
  var currentElf = 0;
  for (var marble in List.generate(lastMarble * multiplier, (i) => i + 1)) {
    if (marble % 23 == 0) {
      scores[currentElf] += marble;
      circle.rotateBackward(7);
      scores[currentElf] += circle.remove();
    } else {
      circle.rotateForward(2);
      circle.add(marble);
    }
    currentElf = (currentElf + 1) % players;
  }
  return scores.max;
}

main() {
  final input = "476 players; last marble is worth 71657 points";
  final testInput0 = "9 players; last marble is worth 25 points";
  final testInput1 = "10 players; last marble is worth 1618 points";
  final testInput2 = "13 players; last marble is worth 7999 points";
  final testInput3 = "17 players; last marble is worth 1104 points";
  final testInput4 = "21 players; last marble is worth 6111 points";
  final testInput5 = "30 players; last marble is worth 5807 points";

  check(32, part1and2(testInput0));
  check(8317, part1and2(testInput1));
  check(146373, part1and2(testInput2));
  check(2764, part1and2(testInput3));
  check(54718, part1and2(testInput4));
  check(37305, part1and2(testInput5));
  print(part1and2(input));
  print(part1and2(input, 100));
}
