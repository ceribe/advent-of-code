package d07

import check
import readFirstLine
import kotlin.math.absoluteValue

fun part1and2(input: String, isRateConstant: Boolean): Int {
    val crabPositions = input.split(',').map { it.toInt() }
    val minPos = crabPositions.min()
    val maxPos = crabPositions.max()
    // For each possible final position calculate total cost and find the minimum
    return (minPos..maxPos).minOf { finalPos ->
        crabPositions.sumOf { currPos ->
            val distanceToTravel = (currPos - finalPos).absoluteValue
            if (isRateConstant) distanceToTravel
            else (1..distanceToTravel).sum()
        }
    }
}

fun main() {
    val testInput = readFirstLine("07", "input_test")
    val input = readFirstLine("07", "input")

    check(37, part1and2(testInput, true))
    println(part1and2(input, true)) // 326132

    check(168, part1and2(testInput, false))
    println(part1and2(input, false)) // 88612508
}
