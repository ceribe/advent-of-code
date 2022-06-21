data class Instruction(val op: (Int, Int) -> Int, val arg1: Char, val arg2: Char, val arg3: Int?)

data class Alu(var w: Int = 0, var x: Int = 0, var y: Int = 0, var z: Int = 0, var number: Long = 0L) {
    fun performInstruction(i: Instruction) {
        set(i.arg1, i.op(get(i.arg1), (i.arg3 ?: get(i.arg2))))
    }

    fun set(variable: Char, value: Int) {
        when (variable) {
            'w' -> w = value
            'x' -> x = value
            'y' -> y = value
            'z' -> z = value
        }
    }

    fun get(variable: Char) = when (variable) {
        'w' -> w
        'x' -> x
        'y' -> y
        'z' -> z
        else -> throw Error("Invalid variable")
    }
}

object Ops {
    val add = { a: Int, b: Int -> a + b }
    val mul = { a: Int, b: Int -> a * b }
    val div = { a: Int, b: Int -> a / b }
    val mod = { a: Int, b: Int -> a.mod(b) }
    val eql = { a: Int, b: Int -> if (a == b) 1 else 0 }
    val non = { _: Int, _: Int -> 0 }
}

fun parseInput(input: List<String>): List<Instruction> {
    return buildList {
        input.forEach {
            val splits = it.split(' ')
            if (splits.getOrNull(2)?.toIntOrNull() != null) {
                when (splits[0]) {
                    "add" -> add(Instruction(Ops.add, splits[1][0], ' ', splits[2].toInt()))
                    "mul" -> add(Instruction(Ops.mul, splits[1][0], ' ', splits[2].toInt()))
                    "div" -> {
                        if (splits[2].toInt() != 1)
                        add(Instruction(Ops.div, splits[1][0], ' ', splits[2].toInt()))
                    }
                    "mod" -> add(Instruction(Ops.mod, splits[1][0], ' ', splits[2].toInt()))
                    "eql" -> add(Instruction(Ops.eql, splits[1][0], ' ', splits[2].toInt()))
                }
            }
            else {
                when (splits[0]) {
                    "add" -> add(Instruction(Ops.add, splits[1][0], splits[2][0], null))
                    "mul" -> add(Instruction(Ops.mul, splits[1][0], splits[2][0], null))
                    "div" -> add(Instruction(Ops.div, splits[1][0], splits[2][0], null))
                    "mod" -> add(Instruction(Ops.mod, splits[1][0], splits[2][0], null))
                    "eql" -> add(Instruction(Ops.eql, splits[1][0], splits[2][0], null))
                    "inp" -> add(Instruction(Ops.non, splits[1][0], ' ', -1))
                }
            }
        }
    }
}

fun main() {
    fun part1and2(input: List<String>, searchMax: Boolean): Long {
        val instructions = parseInput(input)
        val firstInstruction = instructions[0]
        var states = buildList {
            for (i in 1..9) {
                add(Alu().apply { set(firstInstruction.arg1, i); number = i.toLong() })
            }
        }
        instructions.drop(1).forEach { instruction ->
            // If instruction is "inp"
            if(instruction.arg3 == -1) {
                states = if(searchMax) {
                    states.sortedByDescending { it.number }
                } else {
                    states.sortedBy { it.number }
                }
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
        return states
            .filter { it.z == 0 }
            .let {
                if (searchMax)
                    it.maxOf { itt -> itt.number }
                else 
                    it.minOf { itt -> itt.number }
            }
    }

    val input = readInput("Day24")
    println(part1and2(input, true))
    println(part1and2(input, false))
}