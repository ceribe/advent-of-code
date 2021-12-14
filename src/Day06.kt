fun main() {
    fun part1(input: List<String>): Int {
        val fish = input[0].split(',').map { it.toInt() }.toMutableList()
        repeat(80) { _ ->
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
            fish.addAll(MutableList(newFishCount) { 8 })
        }
        return fish.size
    }

    fun part2(input: List<String>): Long {
        val fish = input[0].split(',').map { it.toInt() }.toMutableList()
        val fishMap = mutableMapOf<Int, Long>()
        fish.forEach {
            fishMap[it] = fishMap.getOrDefault(it,0) + 1
        }
        repeat(256) {
           val newFishCount = fishMap.getOrDefault(0,0)
            fishMap[0] = fishMap.getOrDefault(1,0)
            fishMap[1] = fishMap.getOrDefault(2,0)
            fishMap[2] = fishMap.getOrDefault(3,0)
            fishMap[3] = fishMap.getOrDefault(4,0)
            fishMap[4] = fishMap.getOrDefault(5,0)
            fishMap[5] = fishMap.getOrDefault(6,0)
            fishMap[6] = fishMap.getOrDefault(7,0)
            fishMap[7] = fishMap.getOrDefault(8,0)
            fishMap[8] = newFishCount
            fishMap[6] = fishMap.getOrDefault(6,0) + newFishCount
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