package d15

import check
import readInput
import java.util.PriorityQueue

fun scaleChitonsMatrix(chitonsMatrix: List<List<Int>>, scale: Int): List<List<Int>> {
    val size = chitonsMatrix.size
    val newSize = size * scale
    val scaledChitonsMatrix = List(newSize) { i ->
        List(newSize) { j ->
            val k = i / size + j / size
            (chitonsMatrix[i % size][j % size] + k - 1) % 9 + 1
        }
    }
    return scaledChitonsMatrix
}

fun getSmallestRisk(chitonsMatrix: List<List<Int>>): Int {
    data class State(val risk: Int, val x: Int, val y: Int)
    val size = chitonsMatrix.size
    val riskMap = List(size) { MutableList(size) { Int.MAX_VALUE } }
    riskMap[0][0] = 0
    val queue = PriorityQueue<State> { a, b -> a.risk - b.risk }
    queue.add(State(0, 0, 0))
    while (queue.isNotEmpty()) {
        val (totalRisk, x, y) = queue.poll()
        val nextPositions = listOf(x to y - 1, x to y + 1, x - 1 to y, x + 1 to y)
        nextPositions.forEach { (nextX, nextY) ->
            if (nextX in riskMap.indices && nextY in riskMap.indices) {
                val newRisk = totalRisk + chitonsMatrix[nextX][nextY]
                if (riskMap[nextX][nextY] > newRisk) {
                    riskMap[nextX][nextY] = newRisk
                    queue.add(State(newRisk, nextX, nextY))
                }
            }
        }
    }
    return riskMap.last().last()
}

fun part1and2(input: List<String>, scale: Int): Int {
    val chitonsMatrix = input.map { line -> line.map { it.digitToInt() } }
    val scaledChitonsMatrix = scaleChitonsMatrix(chitonsMatrix, scale)
    return getSmallestRisk(scaledChitonsMatrix)
}

fun main() {
    val testInput = readInput("15", "input_test")
    val input = readInput("15", "input")

    check(40, part1and2(testInput, 1))
    println(part1and2(input, 1)) // 687

    check(315, part1and2(testInput, 5))
    println(part1and2(input, 5)) // 2957
}
