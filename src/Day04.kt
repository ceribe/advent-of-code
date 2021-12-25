fun main() {
    class Position(var number: String, var checked: Boolean = false)

    /**
     * Sets all positions of given [boards] as checked if their number is equal to [number]
     */
    fun markNumber(boards: List<List<List<Position>>>, number: String) {
        boards.forEach { board ->
            board.forEach { row ->
                row.forEach {
                    if (it.number == number) {
                        it.checked = true
                    }
                }
            }
        }
    }

    /**
     * Checks given [boards] whether a board is won while ignoring boards with indexes present in [wonBoardsIndexes]
     * After finding a newly won board its index is added to [wonBoardsIndexes] and returned
     */
    fun checkWin(boards: List<List<List<Position>>>, wonBoardsIndexes: MutableSet<Int>): Int {
        boards.forEachIndexed { idx, board ->
            if (idx !in wonBoardsIndexes) {
                // Check vertical lines
                for (y in 0..4) {
                    if (board[y][0].checked && board[y][1].checked && board[y][2].checked && board[y][3].checked && board[y][4].checked) {
                        wonBoardsIndexes.add(idx)
                        return idx
                    }
                }
                // Check horizontal lines
                for (x in 0..4) {
                    if (board[0][x].checked && board[1][x].checked && board[2][x].checked && board[3][x].checked && board[4][x].checked) {
                        wonBoardsIndexes.add(idx)
                        return idx
                    }
                }
            }
        }
        return -1
    }

    /**
     * Returns sum of all unchecked positions in given [board]
     */
    fun getSumOfUnchecked(board: List<List<Position>>) =
        board.sumOf { it.sumOf { pos -> if (pos.checked) 0 else pos.number.toInt() } }

    /**
     * Parses [input] converting it to list of boards
     */
    fun getBoards(input: List<String>): List<List<List<Position>>> {
        return  buildList {
            input.drop(2).chunked(6).forEach { chunk ->
                val currentBoard = buildList {
                    chunk.take(5).forEach {
                        add(
                            it
                                .split(' ')
                                .filter { it2 -> it2 != "" } // split can produce an empty string when number is one digit long
                                .map { it2 -> Position(it2) }
                        )
                    }
                }
                add(currentBoard)
            }
        }
    }

    fun part1(input: List<String>): Int {
        val numbers = input[0].split(',')
        val boards = getBoards(input)

        val wonBoardsIndexes = mutableSetOf<Int>()
        // Iterate through numbers marking each on all boards and checking if after that change a board is won
        numbers.forEach { bingoNumber ->
            markNumber(boards, bingoNumber)
            checkWin(boards, wonBoardsIndexes).let { idx ->
                if (idx != -1) {
                    val sum = getSumOfUnchecked(boards[idx])
                    return sum * bingoNumber.toInt()
                }
            }
        }
        return 0
    }

    fun part2(input: List<String>): Int {
        val numbers = input[0].split(',')
        val boards = getBoards(input)

        val wonBoardsIndexes = mutableSetOf<Int>()
        var scoreOfLastWonBoard = -1
        // Iterate through numbers marking each on all boards and checking if after that change a board is won
        numbers.forEach {
            markNumber(boards, it)
            var idx = checkWin(boards, wonBoardsIndexes)
            // If a board is won check again until there is no new won boards for this number
            while (idx != -1) {
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