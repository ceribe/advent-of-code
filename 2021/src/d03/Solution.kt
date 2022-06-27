package d03

import check
import readInput

fun part1(input: List<String>): Int {
    var gammaRate = ""
    for (i in input[0].indices) {
        val numberOfOnes = input.count { it[i] == '1' }
        val numberOfZeros = input.size - numberOfOnes
        gammaRate += if (numberOfOnes > numberOfZeros) "1" else "0"
    }
    val epsilonRate = gammaRate.map { if (it == '1') '0' else '1' }.joinToString("")
    return gammaRate.toInt(2) * epsilonRate.toInt(2)
}

fun part2(input: List<String>): Int {
    fun process(b1: Char, b2: Char): String {
        var filteredRecords = input
        for (i in input[0].indices) {
            val numberOfOnes = filteredRecords.count { it[i] == '1' }
            val numberOfZeros = filteredRecords.size - numberOfOnes
            val mostCommonBit = if (numberOfOnes >= numberOfZeros) b1 else b2
            filteredRecords = filteredRecords.filter { it[i] == mostCommonBit }
            if (filteredRecords.size == 1) {
                break
            }
        }
        return filteredRecords.first()
    }

    val oxygenGeneratorRating = process('1', '0')
    val co2ScrubberRating = process('0', '1')
    return oxygenGeneratorRating.toInt(2) * co2ScrubberRating.toInt(2)
}

fun main() {
    val testInput = readInput("03", "input_test")
    val input = readInput("03", "input")

    check(198, part1(testInput))
    println(part1(input)) // 3959450

    check(230, part2(testInput))
    println(part2(input)) // 7440311
}
