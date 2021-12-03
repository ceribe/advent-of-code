fun main() {
    fun part1(input: List<String>): Int {
        val len = input[0].length
        var gamma = ""
        for (i in 0 until len) {
            val numberOfOnes = input.map { it[i] }.count { it == '1' }
            val numberOfZeros = input.size - numberOfOnes
            gamma += if (numberOfOnes > numberOfZeros) "1" else "0"
        }
        val epsilon = gamma.map { if(it == '1') '0' else '1' }.joinToString("")
        return gamma.toInt(2) * epsilon.toInt(2)
    }

    fun part2(input: List<String>): Int {
        val len = input[0].length
        var filteredRecords = input
        for (i in 0 until len) {
            val numberOfOnes = filteredRecords.map { it[i] }.count { it == '1' }
            val numberOfZeros = filteredRecords.size - numberOfOnes
            val mostCommonBit = when {
                numberOfOnes > numberOfZeros -> '1'
                numberOfOnes == numberOfZeros -> '1'
                else -> '0'
            }
            filteredRecords = filteredRecords.filter { it[i] == mostCommonBit }
            if(filteredRecords.size == 1)
                break
        }
        val oxygen = filteredRecords[0]
        filteredRecords = input
        for (i in 0 until len) {
            val numberOfOnes = filteredRecords.map { it[i] }.count { it == '1' }
            val numberOfZeros = filteredRecords.size - numberOfOnes
            val leastCommonBit = when {
                numberOfOnes > numberOfZeros -> '0'
                numberOfOnes == numberOfZeros -> '0'
                else -> '1'
            }
            filteredRecords = filteredRecords.filter { it[i] == leastCommonBit }
            if(filteredRecords.size == 1)
                break
        }
        val co2Scrubber = filteredRecords[0]
        return oxygen.toInt(2) * co2Scrubber.toInt(2)
    }

    val testInput = readInput("Day03_test")
    check(part1(testInput) == 198)
    check(part2(testInput) == 230)

    val input = readInput("Day03")
    println(part1(input))
    println(part2(input))
}