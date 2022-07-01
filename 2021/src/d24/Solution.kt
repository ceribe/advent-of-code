package d24

import readInput

data class Instruction(val operation: (Int, Int) -> Int, val arg1: Char, val arg2: Char, val arg3: Int?)

data class Alu(var w: Int = 0, var x: Int = 0, var y: Int = 0, var z: Int = 0, var number: Long = 0L) {
    fun performInstruction(i: Instruction) {
        set(i.arg1, i.operation(get(i.arg1), (i.arg3 ?: get(i.arg2))))
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

object Operations {
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
                    "add" -> add(Instruction(Operations.add, splits[1][0], ' ', splits[2].toInt()))
                    "mul" -> add(Instruction(Operations.mul, splits[1][0], ' ', splits[2].toInt()))
                    "div" -> {
                        if (splits[2].toInt() != 1)
                            add(Instruction(Operations.div, splits[1][0], ' ', splits[2].toInt()))
                    }
                    "mod" -> add(Instruction(Operations.mod, splits[1][0], ' ', splits[2].toInt()))
                    "eql" -> add(Instruction(Operations.eql, splits[1][0], ' ', splits[2].toInt()))
                }
            } else {
                when (splits[0]) {
                    "add" -> add(Instruction(Operations.add, splits[1][0], splits[2][0], null))
                    "mul" -> add(Instruction(Operations.mul, splits[1][0], splits[2][0], null))
                    "div" -> add(Instruction(Operations.div, splits[1][0], splits[2][0], null))
                    "mod" -> add(Instruction(Operations.mod, splits[1][0], splits[2][0], null))
                    "eql" -> add(Instruction(Operations.eql, splits[1][0], splits[2][0], null))
                    "inp" -> add(Instruction(Operations.non, splits[1][0], ' ', -1))
                }
            }
        }
    }
}

fun part1and2(input: List<String>, searchMax: Boolean): Long {
    val instructions = parseInput(input)
    val firstInstruction = instructions[0]
    var states = buildList {
        for (i in 1..9) {
            add(Alu().apply {
                set(firstInstruction.arg1, i)
                number = i.toLong()
            })
        }
    }
    instructions.drop(1).forEach { instruction ->
        // If instruction is "inp"
        if (instruction.arg3 == -1) {
            states = if (searchMax) {
                states.sortedByDescending { it.number }
            } else {
                states.sortedBy { it.number }
            }
            states = states.distinctBy { it.z }
            states = buildList {
                for (state in states) {
                    for (i in 1..9) {
                        add(state.copy().apply {
                            set(instruction.arg1, i)
                            number = number * 10 + i.toLong()
                        })
                    }
                }
            }
        } else {
            for (state in states) {
                state.performInstruction(instruction)
            }
        }
    }
    return states
        .filter { it.z == 0 }
        .let { alu ->
            if (searchMax)
                alu.maxOf { it.number }
            else
                alu.minOf { it.number }
        }
}

fun main() {
    val input = readInput("24", "input")
    println("Part 1: " + part1and2(input, true)) // 74929995999389
    println("Part 2: " + part1and2(input, false)) // 11118151637112
}
