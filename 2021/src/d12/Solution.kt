package d12

import check
import readInput

fun generateConnectionMap(input: List<String>): Map<String, Set<String>> {
    return buildMap {
        input.forEach {
            val (cave1, cave2) = it.split('-')
            put(cave1, getOrDefault(cave1, mutableSetOf()) + cave2)
            put(cave2, getOrDefault(cave2, mutableSetOf()) + cave1)
        }
    }
}

fun part1(input: List<String>): Int {
    val connectionMap = generateConnectionMap(input)
    val paths = mutableSetOf<List<String>>()
    fun explore(path: List<String>) {
        val nextCaves = connectionMap[path.last()]!!
        nextCaves.forEach { nextCave ->
            if (nextCave == "end") {
                paths.add(path + "end")
            } else if (nextCave !in path || nextCave.uppercase() == nextCave) {
                explore(path + nextCave)
            }
        }
    }
    explore(mutableListOf("start"))
    return paths.size
}

fun part2(input: List<String>): Int {
    val connectionMap = generateConnectionMap(input)
    val paths = mutableSetOf<List<String>>()

    fun explore(path: List<String>, visitedSmallCaveTwice: Boolean) {
        val nextCaves = connectionMap[path.last()]!!
        nextCaves.forEach { nextCave ->
            when (nextCave) {
                "start" -> {}
                "end" -> paths.add(path + "end")
                nextCave.uppercase() -> explore(path + nextCave, visitedSmallCaveTwice)
                !in path -> explore(path + nextCave, visitedSmallCaveTwice)
                else -> if (!visitedSmallCaveTwice) explore(path + nextCave, true)
            }
        }
    }
    explore(mutableListOf("start"), false)
    return paths.size
}

fun main() {
    val testInput1 = readInput("12", "input_test_1")
    val testInput2 = readInput("12", "input_test_2")
    val testInput3 = readInput("12", "input_test_3")
    val input = readInput("12", "input")

    check(10, part1(testInput1))
    check(19, part1(testInput2))
    check(226, part1(testInput3))
    println("Part 1: " + part1(input)) // 4775

    check(36, part2(testInput1))
    check(103, part2(testInput2))
    check(3509, part2(testInput3))
    println("Part 2: " + part2(input)) // 152480
}
