import '../utils.dart';

class Claim {
  int id = 0;
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;

  Claim(String line) {
    var words =
        line.replaceAll(RegExp(r'[#@,:x]'), " ").trim().split(RegExp(" +"));
    this.id = int.parse(words[0]);
    this.x = int.parse(words[1]);
    this.y = int.parse(words[2]);
    this.width = int.parse(words[3]);
    this.height = int.parse(words[4]);
  }
}

Map<Point, int> getFabricWithClaims(List<Claim> claims) {
  final fabric = <Point, int>{};
  for (var claim in claims) {
    for (var x = claim.x; x < claim.x + claim.width; x++) {
      for (var y = claim.y; y < claim.y + claim.height; y++) {
        final key = Point(x, y);
        fabric[key] = (fabric[key] ?? 0) + 1;
      }
    }
  }
  return fabric;
}

dynamic part1(List<String> input) {
  final claims = input.map(Claim.new).toList();
  final fabric = getFabricWithClaims(claims);
  return fabric.values.where((v) => v > 1).length;
}

dynamic part2(List<String> input) {
  final claims = input.map(Claim.new).toList();
  final fabric = getFabricWithClaims(claims);
  for (var claim in claims) {
    var overlaps = false;
    for (var x = claim.x; x < claim.x + claim.width; x++) {
      for (var y = claim.y; y < claim.y + claim.height; y++) {
        if (fabric[Point(x, y)] != 1) {
          overlaps = true;
          break;
        }
      }
    }
    if (!overlaps) {
      return claim.id;
    }
  }
  return null;
}

main() {
  final input = readInput("03", 'input.txt');
  final testInput = readInput("03", 'test_input.txt');

  check(4, part1(testInput));
  print(part1(input));

  check(3, part2(testInput));
  print(part2(input));
}
