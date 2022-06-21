fun main() {
    fun part1(input: List<String>): Int {
        var gammaRate = ""
        for (i in 0 until input[0].length) {
            val numberOfOnes = input.map { it[i] }.count { it == '1' }
            val numberOfZeros = input.size - numberOfOnes
            gammaRate += if (numberOfOnes > numberOfZeros) "1" else "0"
        }
        val epsilonRate = gammaRate.map { if(it == '1') '0' else '1' }.joinToString("")
        return gammaRate.toInt(2) * epsilonRate.toInt(2)
    }

    fun part2(input: List<String>): Int {
        fun process(b1: Char, b2: Char): String {
            var filteredRecords = input
            for (i in 0 until input[0].length) {
                val numberOfOnes = filteredRecords.map { it[i] }.count { it == '1' }
                val numberOfZeros = filteredRecords.size - numberOfOnes
                val mostCommonBit = if (numberOfOnes >= numberOfZeros) b1 else b2
                filteredRecords = filteredRecords.filter { it[i] == mostCommonBit }
                if (filteredRecords.size == 1) { break }
            }
            return filteredRecords[0]
        }

        val oxygenGeneratorRating = process('1', '0')
        val co2ScrubberRating = process('0', '1')
        return oxygenGeneratorRating.toInt(2) * co2ScrubberRating.toInt(2)
    }

    val testInput = readInput("Day03_test")
    check(part1(testInput) == 198)
    check(part2(testInput) == 230)

    val input = readInput("Day03")
    println(part1(input))
    println(part2(input))
}