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

// Recursively adds children to given node and returns new position
int addChildren(Node node, List<int> numbers, int pos) {
  int numChildren = numbers[pos++];
  int numMetadata = numbers[pos++];

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
  var numbers = input[0].split(' ').map(int.parse).toList();
  Node root = Node();
  addChildren(root, numbers, 0);
  return root;
}

dynamic part1(List<String> input) {
  var root = getTree(input);
  return root.recursiveMetadataSum;
}

dynamic part2(List<String> input) {
  var root = getTree(input);
  return root.value;
}

main() {
  var input = readFile('input.txt');
  var testInput = readFile('test_input.txt');

  check(138, part1(testInput));
  print(part1(input));

  check(66, part2(testInput));
  print(part2(input));
}
