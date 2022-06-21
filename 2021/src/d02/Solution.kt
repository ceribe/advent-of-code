package d02

import check
import readInput

fun parseInput(input: List<String>): List<Pair<String, Int>> {
    return input.map {
        val line = it.split(" ")
        (line[0] to line[1].toInt())
    }
}

fun part1(input: List<String>): Int {
    var x = 0
    var y = 0
    val commands = parseInput(input)
    commands.forEach { (direction, value) ->
        when (direction) {
            "forward" -> x += value
            "up" -> y -= value
            "down" -> y += value
        }
    }
    return x * y
}

fun part2(input: List<String>): Int {
    var x = 0
    var y = 0
    var aim = 0
    val commands = parseInput(input)
    commands.forEach { (direction, value) ->
        when (direction) {
            "forward" -> {
                x += value
                y += aim * value
            }
            "up" -> aim -= value
            "down" -> aim += value
        }
    }
    return x * y
}

fun main() {
    val testInput = readInput("02", "input_test")
    val input = readInput("02", "input")

    check(150, part1(testInput))
    println(part1(input))

    check(900, part2(testInput))
    println(part2(input))
}
