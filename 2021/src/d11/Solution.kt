package d11

import check
import readInput

data class Octopus(var energy: Int, var flashed: Boolean = false)

fun parseInput(input: List<String>) = input.map { it.map { number -> Octopus(number.digitToInt()) } }

/**
 * Simulates one step and returns the number of flashes which happened in this step.
 */
fun simulateOneStep(octoMap: List<List<Octopus>>): Int {
    var flashCount = 0
    // Increase energy of all by 1
    octoMap.forEach { it.forEach { octopus -> octopus.energy++ } }
    // Process flashes
    label@ while (true) {
        for (x in 0..9) {
            for (y in 0..9) {
                if (octoMap[x][y].energy > 9 && !octoMap[x][y].flashed) {
                    octoMap[x][y].flashed = true
                    if (x - 1 >= 0 && y - 1 >= 0) octoMap[x - 1][y - 1].energy++
                    if (y - 1 >= 0) octoMap[x][y - 1].energy++
                    if (x + 1 < 10 && y - 1 >= 0) octoMap[x + 1][y - 1].energy++
                    if (x - 1 >= 0) octoMap[x - 1][y].energy++
                    if (x + 1 < 10) octoMap[x + 1][y].energy++
                    if (x - 1 >= 0 && y + 1 < 10) octoMap[x - 1][y + 1].energy++
                    if (y + 1 < 10) octoMap[x][y + 1].energy++
                    if (x + 1 < 10 && y + 1 < 10) octoMap[x + 1][y + 1].energy++
                    flashCount++
                    continue@label
                }
            }
        }
        break
    }
    octoMap.forEach {
        it.forEach { octopus ->
            with(octopus) {
                if (flashed) {
                    energy = 0
                    flashed = false
                }
            }
        }
    }
    return flashCount
}

fun part1(input: List<String>): Int {
    val octoMap = parseInput(input)
    var flashCount = 0
    repeat(100) {
        flashCount += simulateOneStep(octoMap)
    }
    return flashCount
}

fun part2(input: List<String>): Int {
    val octoMap = parseInput(input)
    (1..10000).forEach { step ->
        simulateOneStep(octoMap)
        if (octoMap.flatten().sumOf { it.energy } == 0) {
            return step
        }
    }
    return -1
}

fun main() {
    val testInput = readInput("11", "input_test")
    val input = readInput("11", "input")

    check(1656, part1(testInput))
    println("Part 1: " + part1(input)) // 1755

    check(195, part2(testInput))
    println("Part 2: " + part2(input)) // 212
}
