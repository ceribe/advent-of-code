import '../utils.dart';
import 'package:collection/collection.dart';

enum Opcode {
  addr,
  addi,
  mulr,
  muli,
  banr,
  bani,
  borr,
  bori,
  setr,
  seti,
  gtir,
  gtri,
  gtrr,
  eqir,
  eqri,
  eqrr
}

class State {
  List<int> registers;

  State(this.registers);

  State copy() => State(registers.toList());

  bool equals(State other) => ListEquality().equals(registers, other.registers);

  void add(int a, int b, int c) => registers[c] = a + b;
  void mul(int a, int b, int c) => registers[c] = a * b;
  void ban(int a, int b, int c) => registers[c] = a & b;
  void bor(int a, int b, int c) => registers[c] = a | b;
  void set(int a, int c) => registers[c] = a;
  void gt(int a, int b, int c) => registers[c] = a > b ? 1 : 0;
  void eq(int a, int b, int c) => registers[c] = a == b ? 1 : 0;

  /// Executes given instruction, first value is ignored and given [opcode] is used instead.
  void executeOpcode(Opcode opcode, List<int> ins) {
    switch (opcode) {
      case Opcode.addr:
        add(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
      case Opcode.addi:
        add(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.mulr:
        mul(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
      case Opcode.muli:
        mul(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.banr:
        ban(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
      case Opcode.bani:
        ban(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.borr:
        bor(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
      case Opcode.bori:
        bor(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.setr:
        set(registers[ins[0]], ins[2]);
        break;
      case Opcode.seti:
        set(ins[0], ins[2]);
        break;
      case Opcode.gtir:
        gt(ins[0], registers[ins[1]], ins[2]);
        break;
      case Opcode.gtri:
        gt(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.gtrr:
        gt(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
      case Opcode.eqir:
        eq(ins[0], registers[ins[1]], ins[2]);
        break;
      case Opcode.eqri:
        eq(registers[ins[0]], ins[1], ins[2]);
        break;
      case Opcode.eqrr:
        eq(registers[ins[0]], registers[ins[1]], ins[2]);
        break;
    }
  }
}

class Sample {
  final State before;
  final List<int> instruction;
  final State after;

  Sample(this.before, this.instruction, this.after);

  /// Returns new state produced by executing given opcode on this sample
  State executeOpcode(Opcode op) {
    final state = before.copy();
    state.executeOpcode(op, instruction.sublist(1, 4));
    return state;
  }
}

/// Returns list of samples extracted from given [input]
List<Sample> parseSamples(List<String> input) {
  final samples = <Sample>[];
  for (var i = 0; i < input.length; i += 4) {
    final before = getIntegersFromLine(input[i]);
    final instruction = getIntegersFromLine(input[i + 1]);
    final after = getIntegersFromLine(input[i + 2]);
    samples.add(Sample(State(before), instruction, State(after)));
  }
  return samples;
}

/// Returns list of opcodes that could be used to produce given [sample]
List<Opcode> getMatchingOpcodes(Sample sample) {
  var matchingOpcodes = <Opcode>[];
  for (final op in Opcode.values) {
    final newState = sample.executeOpcode(op);
    if (newState.equals(sample.after)) {
      matchingOpcodes.add(op);
    }
  }
  return matchingOpcodes;
}

dynamic part1(List<String> input) {
  var count = 0;
  final samples = parseSamples(input);
  for (final sample in samples) {
    if (getMatchingOpcodes(sample).length >= 3) {
      count++;
    }
  }
  return count;
}

/// Returns a map of definite mapping of numbers to opcodes using given [possibleMatches]
Map<int, Opcode> matchOpcodes(Map<Sample, List<Opcode>> possibleMatches) {
  final matchedOpcodes = <int, Opcode>{};
  while (matchedOpcodes.length < 16) {
    for (final sample in possibleMatches.keys) {
      final samplesOpcodes = possibleMatches[sample]!;
      if (samplesOpcodes.length == 1) {
        // Mark opcode as matched
        final matchedOpcode = samplesOpcodes.first;
        matchedOpcodes[sample.instruction[0]] = matchedOpcode;
        possibleMatches.remove(sample);
        // Remove this opcode from all samples
        for (final otherSample in possibleMatches.keys) {
          final otherSampleOpcodes = possibleMatches[otherSample]!;
          otherSampleOpcodes.remove(matchedOpcode);
        }
        break;
      }
    }
  }
  return matchedOpcodes;
}

dynamic part2(List<String> input, List<String> input2) {
  final possibleMatches = <Sample, List<Opcode>>{};
  final samples = parseSamples(input);

  // Create a map of samples and their possible opcodes
  for (final sample in samples) {
    possibleMatches[sample] = getMatchingOpcodes(sample);
  }

  final matchedOpcodes = matchOpcodes(possibleMatches);

  // Execute program
  final state = State([0, 0, 0, 0]);
  for (final line in input2) {
    final instruction = getIntegersFromLine(line);
    final opcode = matchedOpcodes[instruction[0]]!;
    state.executeOpcode(opcode, instruction.sublist(1, 4));
  }
  return state.registers[0];
}

main() {
  final input1 = readFile('input_1.txt');
  final input2 = readFile('input_2.txt');

  print(part1(input1));
  print(part2(input1, input2));
}
