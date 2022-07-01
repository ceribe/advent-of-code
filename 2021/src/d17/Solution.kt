package d17

import check

fun part1and2(input: String): Pair<Int, Int> {
    val (minX, maxX, minY, maxY) = input
        .replace("[^0-9-]+".toRegex(), " ")
        .drop(1)
        .split(' ')
        .map { it.toInt() }
    var globalMaxHeight = 0
    var distinctVelocityValuesCount = 0
    for (_xVel in 1..500) {
        for (_yVel in -500..500) {
            var xVel = _xVel
            var yVel = _yVel
            var (x, y) = listOf(0, 0)
            var wasInside = false
            var maxHeight = 0
            while (y >= minY) {
                x += xVel
                y += yVel
                if (xVel > 0) xVel--
                yVel--
                maxHeight = maxOf(y, maxHeight)
                val isInside = x in minX..maxX && y in minY..maxY
                if (isInside) wasInside = true
            }
            if (wasInside) {
                globalMaxHeight = maxOf(globalMaxHeight, maxHeight)
                distinctVelocityValuesCount++
            }
        }
    }
    return globalMaxHeight to distinctVelocityValuesCount
}

fun main() {
    val testInput = "target area: x=20..30, y=-10..-5"
    val input = "target area: x=235..259, y=-118..-62"

    check(45 to 112, part1and2(testInput))
    println(part1and2(input)) // 1: 6903, 2: 2351
}
