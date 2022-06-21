fun main() {
    fun part1and2(input: List<String>, days: Int): Long {
        val fishList = input[0].split(',').map { it.toInt() }
        val fishMap = buildMap<Int, Long> {
            fishList.forEach { set(it, getOrDefault(it, 0) + 1) }
            repeat(days) {
                val newFishCount = getOrDefault(0, 0)
                set(0, getOrDefault(1, 0))
                set(1, getOrDefault(2, 0))
                set(2, getOrDefault(3, 0))
                set(3, getOrDefault(4, 0))
                set(4, getOrDefault(5, 0))
                set(5, getOrDefault(6, 0))
                set(6, getOrDefault(7, 0))
                set(7, getOrDefault(8, 0))
                set(8, newFishCount)
                set(6, getOrDefault(6, 0) + newFishCount)
            }
        }
        return fishMap.map { it.value }.sum()
    }

    val testInput = readInput("Day06_test")
    check(part1and2(testInput, 80) == 5934L)
    check(part1and2(testInput, 256) == 26984457539L)

    val input = readInput("Day06")
    println(part1and2(input, 80))
    println(part1and2(input, 256))
}