import 'package:collection/collection.dart';

// Opcodes are shared between day 16 and day 19

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

  /// Executes given [opcode] on this [State] using [ins] as its parameters
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
