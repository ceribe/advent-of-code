enum class InstructionType {
    inp, add1, add2, mul1, mul2, div1, div2, mod1, mod2, eql1, eql2, zer
}

data class Instruction(val type: InstructionType, val arg1: Char, val arg2: Char, val arg3: Int)

data class Alu(var w: Int = 0, var x: Int = 0, var y: Int = 0, var z: Int = 0, var number: Long = 0L) {
    fun performInstruction(i: Instruction) {
        when(i.type) {
            InstructionType.add1 -> set(i.arg1, get(i.arg1) + i.arg3)
            InstructionType.add2 -> set(i.arg1, get(i.arg1) + get(i.arg2))
            InstructionType.mul1 -> set(i.arg1, get(i.arg1) * i.arg3)
            InstructionType.mul2 -> set(i.arg1, get(i.arg1) * get(i.arg2))
            InstructionType.div1 -> set(i.arg1, get(i.arg1) / i.arg3)
            InstructionType.div2 -> set(i.arg1, get(i.arg1) / get(i.arg2))
            InstructionType.mod1 -> set(i.arg1, get(i.arg1).mod(i.arg3))
            InstructionType.mod2 -> set(i.arg1, get(i.arg1).mod(get(i.arg2)))
            InstructionType.eql1 -> set(i.arg1, if(get(i.arg1) == i.arg3) 1 else 0)
            InstructionType.eql2 -> set(i.arg1, if(get(i.arg1) == get(i.arg2)) 1 else 0)
            InstructionType.zer  -> set(i.arg1, 0)
            InstructionType.inp  -> throw Error("Input passed to alu")
        }
    }

    fun set(variable: Char, value: Int) {
        when(variable) {
            'w' -> w = value
            'x' -> x = value
            'y' -> y = value
            'z' -> z = value
        }
    }

    fun get(variable: Char) = when(variable) {
        'w' -> w
        'x' -> x
        'y' -> y
        'z' -> z
        else -> throw Error("Invalid variable")
    }
}

fun parseInput(input: List<String>): List<Instruction> {
    return buildList {
        input.forEach {
            val splits = it.split(' ')
            if(splits.getOrNull(2)?.toIntOrNull() != null) {
                when(splits[0]) {
                    "add" -> add(Instruction(InstructionType.add1, splits[1][0], ' ', splits[2].toInt()))
                    "mul" -> {
                        if(splits[2].toInt() == 0)
                            add(Instruction(InstructionType.zer, splits[1][0], ' ', 0))
                        else
                            add(Instruction(InstructionType.mul1, splits[1][0], ' ', splits[2].toInt()))
                    }
                    "div" -> {
                        if(splits[2].toInt() != 1)
                        add(Instruction(InstructionType.div1, splits[1][0], ' ', splits[2].toInt()))
                    }
                    "mod" -> add(Instruction(InstructionType.mod1, splits[1][0], ' ', splits[2].toInt()))
                    "eql" -> add(Instruction(InstructionType.eql1, splits[1][0], ' ', splits[2].toInt()))
                }
            }
            else {
                when(splits[0]) {
                    "add" -> add(Instruction(InstructionType.add2, splits[1][0], splits[2][0], 0))
                    "mul" -> add(Instruction(InstructionType.mul2, splits[1][0], splits[2][0], 0))
                    "div" -> add(Instruction(InstructionType.div2, splits[1][0], splits[2][0], 0))
                    "mod" -> add(Instruction(InstructionType.mod2, splits[1][0], splits[2][0], 0))
                    "eql" -> add(Instruction(InstructionType.eql2, splits[1][0], splits[2][0], 0))
                }
            }
            when(splits[0]) {
                "inp" -> add(Instruction(InstructionType.inp, splits[1][0], ' ', 0))
            }
        }
    }
}

fun main() {
    fun part1(input: List<String>): Long {
        val instructions = parseInput(input)
        val firstInstruction = instructions[0]
        var states = buildList {
            for (i in 1..9) {
                add(Alu().apply { set(firstInstruction.arg1, i); number = i.toLong() })
            }
        }
        instructions.drop(1).forEach { instruction ->
            if(instruction.type == InstructionType.inp) {
                states = states.sortedByDescending { it.number }
                states = states.distinctBy { it.z }
                states = buildList {
                    states.forEach {
                        for (i in 1..9) {
                            add(it.copy().apply { set(instruction.arg1, i); number = number * 10 + i.toLong() })
                        }
                    }
                }
            }
            else {
                states.forEach { state ->
                    state.performInstruction(instruction)
                }
            }
        }
        return states.filter { it.z == 0 }.maxOf { it.number }
    }

    fun part2(input: List<String>): Long {
        val instructions = parseInput(input)
        val firstInstruction = instructions[0]
        var states = buildList {
            for (i in 1..9) {
                add(Alu().apply { set(firstInstruction.arg1, i); number = i.toLong() })
            }
        }
        instructions.drop(1).forEach { instruction ->
            if(instruction.type == InstructionType.inp) {
                states = states.sortedBy { it.number }
                states = states.distinctBy { it.z }
                states = buildList {
                    states.forEach {
                        for (i in 1..9) {
                            add(it.copy().apply { set(instruction.arg1, i); number = number * 10 + i.toLong() })
                        }
                    }
                }
            }
            else {
                states.forEach { state ->
                    state.performInstruction(instruction)
                }
            }
        }
        return states.filter { it.z == 0 }.minOf { it.number }
    }

    val input = readInput("Day24")
    println(part1(input))
    println(part2(input))
}