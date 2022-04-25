import '../utils.dart';

class Cart {
  int x;
  int y;
  int direction; // 0 = up, 1 = right, 2 = down, 3 = left
  int nextTurnModifier = -1;
  bool crashed = false;

  Cart(this.x, this.y, this.direction);

  int compareTo(Cart other) {
    if (y == other.y) {
      return x.compareTo(other.x);
    }
    return y.compareTo(other.y);
  }

  /// Moves this card by one tick and rotates it if needed
  void move(List<List<String>> tracks) {
    // Move in the current direction
    switch (direction) {
      case 0:
        y--;
        break;
      case 1:
        x++;
        break;
      case 2:
        y++;
        break;
      case 3:
        x--;
        break;
    }
    // Change direction if necessary
    switch (tracks[y][x]) {
      case '\\':
        direction = [3, 2, 1, 0][direction];
        break;
      case '/':
        direction = [1, 0, 3, 2][direction];
        break;
      case '+':
        direction = (direction + nextTurnModifier) % 4;
        nextTurnModifier++;
        if (nextTurnModifier > 1) {
          nextTurnModifier = -1;
        }
    }
  }

  bool crashesWith(Cart other) {
    return x == other.x &&
        y == other.y &&
        this != other &&
        !crashed &&
        !other.crashed;
  }
}

/// Extracts carts from the track and returns them. Carts initial positions
/// are replaced by "|" or "-"
List<Cart> getCarts(List<String> input, List<List<String>> track) {
  final carts = <Cart>[];
  for (var y = 0; y < track.length; y++) {
    for (var x = 0; x < track[y].length; x++) {
      switch (track[y][x]) {
        case '^':
          carts.add(Cart(x, y, 0));
          track[y][x] = '|';
          break;
        case '>':
          carts.add(Cart(x, y, 1));
          track[y][x] = '-';
          break;
        case 'v':
          carts.add(Cart(x, y, 2));
          track[y][x] = '|';
          break;
        case '<':
          carts.add(Cart(x, y, 3));
          track[y][x] = '-';
          break;
      }
    }
  }
  return carts;
}

dynamic part1(List<String> input) {
  final track = input.map((line) => line.split('')).toList();
  final carts = getCarts(input, track);
  while (true) {
    carts.sort((a, b) => a.compareTo(b));
    for (final cart in carts) {
      cart.move(track);
      // Check if any crash happens, if so end the simulation and return the coords
      for (final otherCart in carts) {
        if (cart.crashesWith(otherCart)) {
          return '${cart.x},${cart.y}';
        }
      }
    }
  }
}

dynamic part2(List<String> input) {
  final track = input.map((line) => line.split('')).toList();
  final carts = getCarts(input, track);
  while (true) {
    carts.sort((a, b) => a.compareTo(b));
    for (final cart in carts) {
      cart.move(track);
      // Check if any crash happens, if so mark those carts as crashed
      for (final otherCart in carts) {
        if (cart.crashesWith(otherCart)) {
          cart.crashed = true;
          otherCart.crashed = true;
        }
      }
    }
    carts.removeWhere((cart) => cart.crashed);
    if (carts.length == 1) {
      return '${carts[0].x},${carts[0].y}';
    }
  }
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');
  final testInput2 = readFile('test_input_2.txt');

  check("7,3", part1(testInput));
  print(part1(input));

  check("6,4", part2(testInput2));
  print(part2(input));
}
