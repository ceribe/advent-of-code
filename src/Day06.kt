fun main() {
    fun part1(input: List<String>): Int {
        val fish = input[0].split(',').map { it.toInt() }.toMutableList()
        (1..80).forEach { _ ->
            var newFishCount = 0
            fish.forEachIndexed { index, it ->
                if(it == 0) {
                    fish[index] = 6
                    newFishCount++
                }
                else {
                    fish[index] = fish[index] - 1
                }
            }
            (1..newFishCount).forEach { _ ->
                fish.add(8)
            }
        }
        return fish.size
    }

    fun part2(input: List<String>): Long {
        val fish = input[0].split(',').map { it.toInt() }.toMutableList()
        val fishMap = mutableMapOf<Int, Long>()
        fish.forEach {
            fishMap[it] = (fishMap[it] ?: 0) + 1
        }
        (1..256).forEach { _ ->
           val newFishCount = fishMap[0] ?: 0
            fishMap[0] = fishMap[1] ?: 0
            fishMap[1] = fishMap[2] ?: 0
            fishMap[2] = fishMap[3] ?: 0
            fishMap[3] = fishMap[4] ?: 0
            fishMap[4] = fishMap[5] ?: 0
            fishMap[5] = fishMap[6] ?: 0
            fishMap[6] = fishMap[7] ?: 0
            fishMap[7] = fishMap[8] ?: 0
            fishMap[8] = newFishCount
            fishMap[6] = (fishMap[6] ?: 0) + newFishCount
        }
        return fishMap.map { it.value }.sum()
    }

    val testInput = readInput("Day06_test")
    check(part1(testInput) == 5934)
    check(part2(testInput) == 26984457539)

    val input = readInput("Day06")
    println(part1(input))
    println(part2(input))
}