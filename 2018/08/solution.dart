import '../utils.dart';

class Node {
  List<Node> children = [];
  List<int> metadata = [];

  int get recursiveMetadataSum {
    return metadata.sum +
        children.map((child) => child.recursiveMetadataSum).sum;
  }

  int get value {
    if (children.isEmpty) {
      return metadata.sum;
    }

    return metadata
        .map((i) => i <= children.length ? children[i - 1].value : 0)
        .sum;
  }
}

/// Recursively adds children to given node and returns new position
int addChildren(Node node, List<int> numbers, int pos) {
  final numChildren = numbers[pos++];
  final numMetadata = numbers[pos++];

  for (int i = 0; i < numChildren; i++) {
    node.children.add(Node());
    pos = addChildren(node.children[i], numbers, pos);
  }

  for (int i = 0; i < numMetadata; i++) {
    node.metadata.add(numbers[pos++]);
  }

  return pos;
}

Node getTree(List<String> input) {
  final numbers = input[0].split(' ').map(int.parse).toList();
  final root = Node();
  addChildren(root, numbers, 0);
  return root;
}

dynamic part1(List<String> input) {
  final root = getTree(input);
  return root.recursiveMetadataSum;
}

dynamic part2(List<String> input) {
  final root = getTree(input);
  return root.value;
}

main() {
  final input = readInput("08", 'input.txt');
  final testInput = readInput("08", 'test_input.txt');

  check(138, part1(testInput));
  print(part1(input));

  check(66, part2(testInput));
  print(part2(input));
}
