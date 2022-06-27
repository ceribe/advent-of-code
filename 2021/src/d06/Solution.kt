package d06

import check
import readFirstLine

fun part1and2(input: String, days: Int): Long {
    val fishList = input.split(',').map { it.toInt() }
    val fishMap = buildMap<Int, Long> {
        fishList.forEach { set(it, getOrDefault(it, 0) + 1) }
        repeat(days) {
            val newFishCount = getOrDefault(0, 0)
            repeat(8) {
                set(it, getOrDefault(it + 1, 0))
            }
            set(8, newFishCount)
            set(6, getOrDefault(6, 0) + newFishCount)
        }
    }
    return fishMap.map { it.value }.sum()
}

fun main() {
    val testInput = readFirstLine("06", "input_test")
    val input = readFirstLine("06", "input")

    check(5934L, part1and2(testInput, 80))
    println(part1and2(input, 80)) // 391888

    check(26984457539L, part1and2(testInput, 256))
    println(part1and2(input, 256)) // 1754597645339
}
