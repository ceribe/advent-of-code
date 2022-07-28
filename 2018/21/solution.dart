dynamic part1and2(bool isPart1) {
  var b = 0, c = 0, f = 0;
  final seenNumbers = new Map<int, int>();
  while (true) {
    c = b | 65536;
    b = 10605201;
    while (true) {
      f = c & 255;
      b += f;
      b = b & 16777215;
      b *= 65899;
      b = b & 16777215;
      if (256 <= c) {
        c = c ~/ 256;
        continue;
      }

      if (isPart1) {
        print(b);
        return;
      }
      
      if (seenNumbers[b] == null) {
        seenNumbers[b] = 1;
      } else if (seenNumbers[b] == 1) {
        seenNumbers[b] = 2;
        print(b);
      }
      break;
    }
  }
}

main() {
  part1and2(true); // 11592302
  // part1and2(false); // 313035
}
