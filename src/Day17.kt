import kotlin.math.max

fun main() {
    fun part1and2(input: List<String>) {
        val (minX, maxX, minY, maxY) = input
            .first()
            .replace("[^0-9-]+".toRegex(), " ")
            .drop(1)
            .split(' ')
            .map { it.toInt() }
        fun isInside(x: Int, y: Int) = x in minX..maxX && y in minY..maxY
        var globalMaxHeight = 0
        var count = 0
        for (_xVel in 1..1000) {
            for (_yVel in -1000..1000) {
                var xVel = _xVel
                var yVel = _yVel
                var (x, y) = listOf(0, 0)
                var wasInside = false
                var maxHeight = 0
                while (y >= minY) {
                    x += xVel
                    y += yVel
                    if (xVel > 0) xVel--
                    if (xVel < 0) xVel++
                    yVel--
                    maxHeight = max(y, maxHeight)
                    if (isInside(x, y)) wasInside = true
                }
                if (wasInside) {
                    globalMaxHeight = max(globalMaxHeight, maxHeight)
                    count++
                }
            }
        }
        println("Max H = $globalMaxHeight")
        println("Count = $count")
    }

    val testInput = readInput("Day17_test")
    println("Expected output for test (45, 112)")
    part1and2(testInput)

    println()
    val input = readInput("Day17")
    part1and2(input)

}