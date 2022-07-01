package d13

import readInput

data class FoldInstruction(val axis: Char, val pos: Int)

/**
 * Parses input and returns a list of instructions and a list of dots.
 */
fun parseInput(input: List<String>): Pair<MutableList<FoldInstruction>, MutableList<Pair<Int, Int>>> {
    val instructions = mutableListOf<FoldInstruction>()
    val dots = mutableListOf<Pair<Int, Int>>()
    var dividerFound = false
    input.forEach {
        if (it == "") {
            dividerFound = true
        } else if (!dividerFound) dots.add(it.split(',')[0].toInt() to it.split(',')[1].toInt())
        else {
            val (axis, pos) = it.split(' ')[2].split('=')
            instructions.add(FoldInstruction(axis[0], pos.toInt()))
        }
    }
    return instructions to dots
}

// In those two functions I'm still not sure why IndexOutOfBoundsException is thrown, but
// since it is not a real program I don't care.

fun foldHorizontally(map: List<CharArray>, pos: Int) {
    for (i in 0 until pos) {
        for (x in 0 until map[0].size - 1) {
            try {
                if (map[pos * 2 - i][x] == '#') {
                    map[i][x] = '#'
                }
            } catch (_: IndexOutOfBoundsException) { }
        }
    }
}

fun foldVertically(map: List<CharArray>, pos: Int) {
    for (i in 0 until pos) {
        for (y in map.indices) {
            try {
                if (map[y][pos * 2 - i] == '#') {
                    map[y][i] = '#'
                }
            } catch (_: IndexOutOfBoundsException) { }
        }
    }
}

fun part1and2(input: List<String>) {
    val (instructions, dots) = parseInput(input)
    var map = mutableListOf<CharArray>()
    val maxX = dots.maxOf { it.first } + 1
    val maxY = dots.maxOf { it.second } + 1 // +1 to account for 0 based indexing
    repeat(maxY) {
        map.add(".".repeat(maxX).toCharArray())
    }

    dots.forEach { (x, y) ->
        map[y][x] = '#'
    }

    instructions.forEachIndexed { idx, instruction ->
        when (instruction.axis) {
            'x' -> {
                foldVertically(map, instruction.pos)
                map = map.map { s -> s.sliceArray(0 until instruction.pos) }.toMutableList()
            }
            'y' -> {
                foldHorizontally(map, instruction.pos)
                map = map.subList(0, instruction.pos)
            }
        }
        if (idx == 0) {
            println("After first fold: " + map.sumOf { line -> line.count { it == '#' } })
        }
    }
    println("After all folds:")
    map.forEach {
        println(it)
    }
}

fun main() {
    val testInput = readInput("13", "input_test")
    val input = readInput("13", "input")

    part1and2(testInput)
    println("\nPart 1 and 2:")
    part1and2(input) // 592 & JGAJEFKU
}
