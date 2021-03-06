package d01

import check
import readInput

fun part1(input: List<String>) =
    input
        .map { it.toInt() }
        .zipWithNext()
        .count { (a, b) -> b > a }

fun part2(input: List<String>) =
    input
        .map { it.toInt() }
        .windowed(3) { it.sum() }
        .zipWithNext()
        .count { (a, b) -> b > a }

fun main() {
    val testInput = readInput("01", "input_test")
    val input = readInput("01", "input")

    check(7, part1(testInput))
    println("Part 1: " + part1(input)) // 1681

    check(5, part2(testInput))
    println("Part 2: " + part2(input)) // 1704
}
