package d09

import check
import readInput

data class Basin(val x: Int, val y: Int, val points: MutableSet<Pair<Int, Int>> = mutableSetOf())

fun part1(input: List<String>): Int {
    val maxX = input[0].length
    val maxY = input.size
    var total = 0
    repeat(maxX) { x ->
        repeat(maxY) { y ->
            val currVal = input[y][x]
            val isLowest =
                ((y - 1) < 0 || currVal < input[y - 1][x]) &&
                ((x - 1) < 0 || currVal < input[y][x - 1]) &&
                ((x + 1) >= maxX || currVal < input[y][x + 1]) &&
                ((y + 1) >= maxY || currVal < input[y + 1][x])
            if (isLowest)
                total += currVal.digitToInt() + 1
        }
    }
    return total
}

fun part2(input: List<String>): Int {
    val maxX = input[0].length
    val maxY = input.size
    val lowPoints = mutableListOf<Basin>()

    // Find the lowest points
    repeat(maxX) { x ->
        repeat(maxY) { y ->
            val currVal = input[y][x]
            val isLowest =
                ((y - 1) < 0 || currVal < input[y - 1][x]) &&
                ((x - 1) < 0 || currVal < input[y][x - 1]) &&
                ((x + 1) >= maxX || currVal < input[y][x + 1]) &&
                ((y + 1) >= maxY || currVal < input[y + 1][x])
            if (isLowest) {
                val basin = Basin(x, y)
                basin.points.add(x to y)
                lowPoints.add(basin)
            }
        }
    }

    /**
     * Recursively finds the whole basin using DFS. Adds found points to the basin.
     */
    fun findWholeBasing(basin: Basin, x: Int, y: Int) {
        if ((x - 1) in (0 until maxX) && input[y][x - 1] != '9' && !basin.points.contains(x - 1 to y)) {
            basin.points.add(x - 1 to y)
            findWholeBasing(basin, x - 1, y)
        }
        if ((x + 1) in (0 until maxX) && input[y][x + 1] != '9' && !basin.points.contains(x + 1 to y)) {
            basin.points.add(x + 1 to y)
            findWholeBasing(basin, x + 1, y)
        }
        if ((y - 1) in (0 until maxY) && input[y - 1][x] != '9' && !basin.points.contains(x to y - 1)) {
            basin.points.add(x to y - 1)
            findWholeBasing(basin, x, y - 1)
        }
        if ((y + 1) in (0 until maxY) && input[y + 1][x] != '9' && !basin.points.contains(x to y + 1)) {
            basin.points.add(x to y + 1)
            findWholeBasing(basin, x, y + 1)
        }
    }

    lowPoints.forEach { basin ->
        findWholeBasing(basin, basin.x, basin.y)
    }

    return lowPoints
        .sortedByDescending { it.points.size }
        .take(3)
        .map { it.points.size }
        .reduce(Int::times)
}

fun main() {
    val testInput = readInput("09", "input_test")
    val input = readInput("09", "input")

    check(15, part1(testInput))
    println(part1(input)) // 591

    check(1134, part2(testInput))
    println(part2(input)) // 1113424
}
