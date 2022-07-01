package d25

import check
import readInput

fun part1(input: List<String>): Int {
    var cucumbers = input.map { it.toList() }
    val width = cucumbers[0].size
    val height = cucumbers.size
    var stepsCount = 1

    fun move(cucumber: Char, getNextX: (Int) -> Int, getNextY: (Int) -> Int): Boolean {
        // Deep copy cucumbers matrix
        // To simulate cucumbers moving all at once positions need to be checked on unchanged matrix
        val newCucumbers = cucumbers.map { it.toMutableList() }
        var moved = false
        // Iterate over the matrix searching for given type of cucumber. When it's found and spot next to it
        // is empty then cucumber is moved.
        for (y in cucumbers.indices) {
            for (x in cucumbers[0].indices) {
                if (cucumbers[y][x] == cucumber) {
                    val nextX = getNextX(x)
                    val nextY = getNextY(y)
                    if (cucumbers[nextY][nextX] == '.') {
                        newCucumbers[y][x] = '.'
                        newCucumbers[nextY][nextX] = cucumber
                        moved = true
                    }
                }
            }
        }
        cucumbers = newCucumbers
        return moved
    }

    while (true) {
        var moved = false

        // Move right
        moved = move(
            cucumber = '>',
            getNextX = { x -> if (x + 1 < width) x + 1 else 0 },
            getNextY = { y -> y }) || moved

        // Move down
        moved = move(
            cucumber = 'v',
            getNextX = { x -> x },
            getNextY = { y -> if (y + 1 < height) y + 1 else 0 }) || moved

        if (!moved) return stepsCount

        stepsCount++
    }
}

fun main() {
    val testInput = readInput("25", "input_test")
    val input = readInput("25", "input")

    check(58, part1(testInput))
    println("Part 1: " + part1(input)) // 374
}
