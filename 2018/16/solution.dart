import '../shared.dart';
import '../utils.dart';

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
  final input1 = readInput("16", 'input_1.txt');
  final input2 = readInput("16", 'input_2.txt');

  print(part1(input1));
  print(part2(input1, input2));
}
