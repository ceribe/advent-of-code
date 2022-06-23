package d04

import check
import readInput

data class Position(val number: Int, var checked: Boolean = false)

class Board(input: List<String>) {
    private val positionsMatrix: List<List<Position>> = buildList {
        input.take(5).forEach { line ->
            val positions = line
                .split(" ")
                .filter { it.isNotEmpty() } // split can produce an empty string when number is one digit long
                .map { Position(it.toInt()) }
            add(positions)
        }
    }

    /**
     * Marks all positions which number is equal to [number] as checked.
     */
    fun markNumber(number: Int) {
        positionsMatrix.forEach { row ->
            row.forEach { position ->
                if (position.number == number) {
                    position.checked = true
                }
            }
        }
    }

    /**
     * Returns sum of all unchecked positions.
     */
    fun getSumOfUnchecked(): Int {
        return positionsMatrix.flatten().filter { !it.checked }.sumOf { it.number }
    }

    /**
     * Returns true if a row or column contains only checked positions, false otherwise.
     */
    fun isWon(): Boolean {
        for (i in 0..4) {
            var isRowChecked = true
            var isColumnChecked = true

            for (j in 0..4) {
                if (!positionsMatrix[j][i].checked) {
                    isRowChecked = false
                }
                if (!positionsMatrix[i][j].checked) {
                    isColumnChecked = false
                }
            }
            if (isRowChecked || isColumnChecked) {
                return true
            }
        }
        return false
    }
}

/**
 * Checks given [boards] whether a board is won while ignoring boards with indexes present in [wonBoardsIndexes]
 * After finding a newly won board its index is added to [wonBoardsIndexes] and returned. Otherwise null is returned.
 */
fun getNextWonBoardIndex(boards: List<Board>, wonBoardsIndexes: MutableSet<Int>): Int? {
    boards.forEachIndexed { idx, board ->
        if (idx !in wonBoardsIndexes) {
            if (board.isWon()) {
                wonBoardsIndexes.add(idx)
                return idx
            }
        }
    }
    return null
}

/**
 * Parses [input] converting it to list of boards
 */
private fun getBoards(input: List<String>): List<Board> {
    return buildList {
        input.drop(2).chunked(6).forEach { chunk ->
            val board = Board(chunk)
            add(board)
        }
    }
}

fun part1(input: List<String>): Int {
    val numbers = input[0].split(',').map { it.toInt()}
    val boards = getBoards(input)
    val wonBoardsIndexes = mutableSetOf<Int>()

    for (bingoNumber in numbers) {
        for (board in boards) {
            board.markNumber(bingoNumber)
        }
        val idx = getNextWonBoardIndex(boards, wonBoardsIndexes)
        if (idx != null) {
            val sum = boards[idx].getSumOfUnchecked()
            return sum * bingoNumber
        }
    }
    return 0
}

fun part2(input: List<String>): Int {
    val numbers = input[0].split(',').map { it.toInt()}
    val boards = getBoards(input)
    val wonBoardsIndexes = mutableSetOf<Int>()
    var scoreOfLastWonBoard = -1

    for (bingoNumber in numbers) {
        for (board in boards) {
            board.markNumber(bingoNumber)
        }
        var idx = getNextWonBoardIndex(boards, wonBoardsIndexes)
        // If a board is won check again until there is no new won boards for this number
        while (idx != null) {
            val sum = boards[idx].getSumOfUnchecked()
            scoreOfLastWonBoard = sum * bingoNumber
            idx = getNextWonBoardIndex(boards, wonBoardsIndexes)
        }
        if (wonBoardsIndexes.size == boards.size) {
            break
        }
    }
    return scoreOfLastWonBoard
}

fun main() {
    val testInput = readInput("04", "input_test")
    val input = readInput("04", "input")

    check(4512, part1(testInput))
    println(part1(input)) // 66716

    check(1924, part2(testInput))
    println(part2(input)) // 1830
}