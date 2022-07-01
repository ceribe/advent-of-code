import '../utils.dart';

void addNewRecipes(List<int> recipes, int elf1, int elf2) {
  final sum = recipes[elf1] + recipes[elf2];
  if (sum >= 10) {
    recipes.add(1);
    recipes.add(sum - 10);
  } else {
    recipes.add(sum);
  }
}

dynamic part1(int input) {
  final recipes = [3, 7];
  var elf1Pos = 0;
  var elf2Pos = 1;
  while (recipes.length < input + 10) {
    addNewRecipes(recipes, elf1Pos, elf2Pos);
    elf1Pos = (elf1Pos + recipes[elf1Pos] + 1) % recipes.length;
    elf2Pos = (elf2Pos + recipes[elf2Pos] + 1) % recipes.length;
  }
  return recipes.sublist(input, input + 10).join();
}

dynamic part2(String input) {
  final recipes = [3, 7];
  var elf1Pos = 0;
  var elf2Pos = 1;
  var lastCheckedStartIdx = 0;
  while (true) {
    addNewRecipes(recipes, elf1Pos, elf2Pos);
    elf1Pos = (elf1Pos + recipes[elf1Pos] + 1) % recipes.length;
    elf2Pos = (elf2Pos + recipes[elf2Pos] + 1) % recipes.length;
    if (recipes.length - lastCheckedStartIdx > 20) {
      final last20 = recipes.sublist(lastCheckedStartIdx).join();
      final idx = last20.indexOf(input);
      if (idx != -1) {
        return lastCheckedStartIdx + idx;
      }
      lastCheckedStartIdx += 10;
    }
  }
}

main() {
  const input = 505961;

  check("5158916779", part1(9));
  check("0124515891", part1(5));
  check("9251071085", part1(18));
  check("5941429882", part1(2018));
  print(part1(input));

  check(9, part2("51589"));
  check(5, part2("01245"));
  check(18, part2("92510"));
  check(2018, part2("59414"));
  print(part2(input.toString()));
}
