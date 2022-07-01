package d21

import check
import readInput

data class Player(var position: Int, var score: Int = 0) {
    fun reducePosition() {
        position = (position - 1) % 10 + 1
    }

    fun addPositionToScore() {
        score += position
    }
}

fun part1(input: List<String>): Long {
    var dieState = 1
    var dieRollCount = 0L
    fun rollDie() = dieState.also {
        dieState++
        if (dieState == 101) dieState = 1
        dieRollCount++
    }

    val players = listOf(
        Player(input[0].last().digitToInt()),
        Player(input[1].last().digitToInt())
    )
    main@ while (true) {
        for (player in players) {
            player.position += rollDie() + rollDie() + rollDie()
            player.reducePosition()
            player.addPositionToScore()
            if (player.score >= 1000L) break@main
        }
    }
    return minOf(players[0].score, players[1].score) * dieRollCount
}

fun part2(input: List<String>): Long {
    val p1Pos = input[0].last().digitToInt()
    val p2Pos = input[1].last().digitToInt()

    data class Wins(var w1: Long = 0L, var w2: Long = 0L)
    // Cache could be of smaller (11 -> 10) but figuring out the offsets is not worth the effort
    val cache: List<List<List<MutableList<Wins?>>>> = List(11) { List(21) { List(11) { MutableList(21) { null } } } }
    fun roll(p1: Int, s1: Int, p2: Int, s2: Int): Wins {
        cache[p1][s1][p2][s2]?.let { return it }
        val timelineWins = Wins()
        for (x in 1..3) {
            for (y in 1..3) {
                for (z in 1..3) {
                    val p1New = (p1 + x + y + z - 1) % 10 + 1
                    val s1New = s1 + p1New
                    if (s1New >= 21) {
                        timelineWins.w1++
                    } else {
                        // Swap players, so I don't have to write second mirror-like function
                        val futureWins = roll(p2, s2, p1New, s1New)
                        // After returning from the future players need to be unswapped and their wins added to this timeline
                        timelineWins.apply {
                            w1 += futureWins.w2
                            w2 += futureWins.w1
                        }
                    }
                }
            }
        }
        // Update cache
        cache[p1][s1][p2][s2] = timelineWins
        return timelineWins
    }

    val finalWins = roll(p1Pos, 0, p2Pos, 0)
    return maxOf(finalWins.w1, finalWins.w2)
}

fun main() {
    val testInput = readInput("21", "input_test")
    val input = readInput("21", "input")

    check(739785L, part1(testInput))
    println("Part 1: " + part1(input)) // 893700

    check(444356092776315L, part2(testInput))
    println("Part 2: " + part2(input)) // 568867175661958
}
