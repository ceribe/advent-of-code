import java.lang.Long.max
import java.lang.Long.min

//100% sure it is not optimal, but it works fast anyway
fun reducePos(pos: Int): Int {
    var cPos = pos
    while(cPos > 10)
        cPos -= 10
    return cPos
}

fun main() {
    fun part1(input: List<String>): Long {
        var dieState = 1
        var dieRollCount = 0L
        fun rollDie() = dieState.also { dieState++; if(dieState == 101) dieState = 1; dieRollCount++ }

        var p1Pos = input[0].last().digitToInt()
        var p2Pos = input[1].last().digitToInt()
        var p1Score = 0L
        var p2Score = 0L
        while(p2Score < 1000) {
            p1Pos += rollDie() + rollDie() + rollDie()
            p1Pos = reducePos(p1Pos)
            p1Score += p1Pos
            if(p1Score >= 1000L)
                break
            p2Pos += rollDie() + rollDie() + rollDie()
            p2Pos = reducePos(p2Pos)
            p2Score += p2Pos
        }
        return min(p1Score, p2Score) * dieRollCount
    }

    fun part2(input: List<String>): Long {
        val p1Pos = input[0].last().digitToInt()
        val p2Pos = input[1].last().digitToInt()
        data class Wins(var w1: Long = 0L, var w2: Long = 0L)
        //Cache could be of smaller (11 -> 10) but figuring out the offsets is not worth the effort
        val cache: List<List<List<MutableList<Wins?>>>> = List(11) { List(21)  { List(11) { MutableList(21) { null } } } }
        fun roll(p1: Int, s1: Int, p2: Int, s2: Int): Wins {
            cache[p1][s1][p2][s2]?.let { return it }
            val timelineWins = Wins()
            for (x in 1..3) {
                for (y in 1..3) {
                    for (z in 1..3) {
                        val p1New = reducePos(p1 + x + y + z)
                        val s1New = s1 + p1New
                        if(s1New > 20) { timelineWins.w1++ }
                        else {
                            //Swap players, so I don't have to write second mirror-like function
                            val futureWins = roll(p2, s2, p1New, s1New)
                            //After returning from the future players need to be unswapped and their wins added to this timeline
                            timelineWins.apply {
                                w1 += futureWins.w2
                                w2 += futureWins.w1
                            }
                        }
                    }
                }
            }
            //Update cache
            cache[p1][s1][p2][s2] = timelineWins
            return  timelineWins
        }

        val finalWins = roll(p1Pos, 0, p2Pos, 0)
        return max(finalWins.w1, finalWins.w2)
    }

    val testInput = readInput("Day21_test")
    check(part1(testInput) == 739785L)
    check(part2(testInput) == 444356092776315L)

    val input = readInput("Day21")
    println(part1(input))
    println(part2(input))
}