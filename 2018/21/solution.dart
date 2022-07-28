import '../utils.dart';

dynamic part1and2() {
  var a = 0, b = 0, c = 0, d = 0, e = 0, f = 0;
  final seenNumbers = new Map<int, int>();
  var seenTwiceCount = 0;
  var part1Result = 0;
  while (true) {
    c = b | 65536;
    b = 10605201;
    while (true) {
      f = c & 255;
      b += f;
      b = b & 16777215;
      b *= 65899;
      b = b & 16777215;
      if (256 > c) {
        if part1Result == 0 {
          part1Result = b;
        }
        if seenNumbers[b] == null {
          seenNumbers[b] = 1;
        } else if (seenNumbers[b] == 1) {
          seenNumbers[b] = 2;
          seenTwiceCount++;
          if seenTwiceCount == seenNumbers.length {
            return "Part 1: $part1Result\nPart 2: $b";
          }
        }
      }
    }
  }
}

main() {
  print(part1(input));
}
