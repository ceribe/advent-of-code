fun main() {

    fun part1(input: List<String>): Int {
        val mutableInput = input.toMutableList()
        val numbers = mutableInput.removeFirst().split(',')
        mutableInput.removeFirst()
        val boards = mutableListOf<List<List<Position>>>()
        var currentBoard = mutableListOf<List<Position>>()
        mutableInput.forEach {
            if(it == "") {
                boards.add(currentBoard)
                currentBoard = mutableListOf()
            }
            else {
                currentBoard.add(it.split(' ').filter { it2 -> it2 != "" }.map { it2 -> Position(it2) })
            }
        }
        boards.add(currentBoard)

        val wonBoardsIndexes = mutableSetOf<Int>()
        numbers.forEach {
            markNumber(boards, it)
            checkWin(boards, wonBoardsIndexes).let { idx ->
                if(idx != -1) {
                    val sum = getSumOfUnchecked(boards[idx])
                    return sum * it.toInt()
                }
            }
        }
        return 0
    }

    fun part2(input: List<String>): Int {
        val mutableInput = input.toMutableList()
        val numbers = mutableInput.removeFirst().split(',')
        mutableInput.removeFirst()
        val boards = mutableListOf<List<List<Position>>>()
        var currentBoard = mutableListOf<List<Position>>()
        mutableInput.forEach {
            if(it == "") {
                boards.add(currentBoard)
                currentBoard = mutableListOf()
            }
            else {
                currentBoard.add(it.split(' ').filter { it2 -> it2 != "" }.map { it2 -> Position(it2) })
            }
        }
        boards.add(currentBoard)

        val wonBoardsIndexes = mutableSetOf<Int>()
        var scoreOfLastWonBoard = -1
        numbers.forEach {
            markNumber(boards, it)
            var idx = checkWin(boards, wonBoardsIndexes)
            while(idx != -1) {
                val sum = getSumOfUnchecked(boards[idx])
                scoreOfLastWonBoard = sum * it.toInt()
                idx = checkWin(boards, wonBoardsIndexes)
            }
        }
        return scoreOfLastWonBoard
    }

    val testInput = readInput("Day04_test")
    check(part1(testInput) == 4512)
    check(part2(testInput) == 1924)

    val input = readInput("Day04")
    println(part1(input))
    println(part2(input))
}

fun markNumber(boards: List<List<List<Position>>>, number: String) {
    boards.forEach { board ->
        board.forEach { row ->
            row.forEach {
                if(it.number == number) {
                    it.checked = true
                }
            }
        }
    }
}

fun checkWin(boards: MutableList<List<List<Position>>>, wonBoardsIndexes: MutableSet<Int>): Int {
    boards.forEachIndexed { idx, board ->
        for(x in 0..4) {
            if (board[x][0].checked && board[x][1].checked && board[x][2].checked && board[x][3].checked && board[x][4].checked) {
                if(idx !in wonBoardsIndexes) {
                    wonBoardsIndexes.add(idx)
                    return idx
                }
            }
        }
        for(y in 0..4) {
            if (board[0][y].checked && board[1][y].checked && board[2][y].checked && board[3][y].checked && board[4][y].checked) {
                if(idx !in wonBoardsIndexes) {
                    wonBoardsIndexes.add(idx)
                    return idx
                }
            }
        }
    }
    return -1
}

fun getSumOfUnchecked(board: List<List<Position>>): Int {
    return board.sumOf { it.sumOf { pos -> if (pos.checked) 0 else pos.number.toInt() } }
}

class Position(var number: String, var checked: Boolean = false)