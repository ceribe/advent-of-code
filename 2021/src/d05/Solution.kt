package d05

import check
import readInput

/**
 * Creates a universal range.
 *
 * 5 towards 2 => 5, 4, 3, 2
 * 2 towards 5 => 2, 3, 4, 5
 */
infix fun Int.toward(to: Int): IntProgression {
    val step = if (this > to) -1 else 1
    return IntProgression.fromClosedRange(this, to, step)
}

/**
 * Returns a map of all possible pairs of numbers from range 0 to 999.
 * Each key maps to 0.
 */
fun createVentMap(): MutableMap<Pair<Int, Int>, Int> {
    val vents = mutableMapOf<Pair<Int, Int>, Int>()
    repeat(1000) { i ->
        repeat(1000) { j ->
            vents[i to j] = 0
        }
    }
    return vents
}

fun processInput(input: List<String>) = input.map { line ->
    line.replace(" -> ", ",").split(',').map { it.toInt() }
}

fun part1(input: List<String>): Int {
    val ventsMap = createVentMap()
    val linesOfVents = processInput(input)
    // Apply each line of vents to ventsMap
    linesOfVents.forEach { (x1, y1, x2, y2) ->
        if (x1 == x2) {
            (y1 toward y2).forEach { y ->
                ventsMap[x1 to y] = ventsMap[x1 to y]!! + 1
            }
        }
        if (y1 == y2) {
            (x1 toward x2).forEach { x ->
                ventsMap[x to y1] = ventsMap[x to y1]!! + 1
            }
        }
    }
    return ventsMap.count { it.value > 1 }
}

fun part2(input: List<String>): Int {
    val ventsMap = createVentMap()
    val linesOfVents = processInput(input)
    // Apply each line of vents to ventsMap
    linesOfVents.forEach { (x1, y1, x2, y2) ->
        if (x1 == x2 && y1 != y2) {
            (y1 toward y2).forEach { y ->
                ventsMap[x1 to y] = ventsMap[x1 to y]!! + 1
            }
        } else if (y1 == y2 && x1 != x2) {
            (x1 toward x2).forEach { x ->
                ventsMap[x to y1] = ventsMap[x to y1]!! + 1
            }
        }
        //Must be a diagonal
        else {
            ((x1 toward x2) zip (y1 toward y2)).forEach { pair ->
                ventsMap[pair] = ventsMap[pair]!! + 1
            }
        }
    }
    return ventsMap.count { it.value > 1 }
}

fun main() {
    val testInput = readInput("05", "input_test")
    val input = readInput("05", "input")

    check(5, part1(testInput))
    println(part1(input)) // 5167

    check(12, part2(testInput))
    println(part2(input)) // 17604
}
