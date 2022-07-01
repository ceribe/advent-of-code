import '../shared.dart';
import '../utils.dart';

dynamic part1(List<String> input) {
  final state = State(List.generate(6, (_) => 0));
  final instructionPointerIndex = int.parse(input[0].substring(4));
  final instructions =
      input.sublist(1).map((line) => line.split(" ")).map((parts) {
    final opcode = opcodes[parts[0]];
    final params = parts.sublist(1).map(int.parse).toList();
    return Instruction(opcode!, params);
  }).toList();

  while (true) {
    final currentInstruction =
        instructions[state.registers[instructionPointerIndex]];
    state.executeInstruction(currentInstruction);
    state.registers[instructionPointerIndex]++;
    final instructionPointerValue = state.registers[instructionPointerIndex];
    final isProgramFinished = instructionPointerValue >= instructions.length ||
        instructionPointerValue < 0;
    if (isProgramFinished) {
      return state.registers[0];
    }
  }
}

dynamic part2(List<String> input) {
  return 1 + 137 + 77017 + 10551329;
}

main() {
  final input = readFile('input.txt');
  final testInput = readFile('test_input.txt');

  check(7, part1(testInput));
  print(part1(input));
  print(part2(input));
}
