fun main() {
    fun part1(input: List<String>): Int {
        val vents = mutableMapOf<Pair<Int, Int>, Int>()
        for(i in 0..999) {
            for(j in 0..999) {
                vents[i to j] = 0
            }
        }
        val a = input.map { it.replace(" -> ", ",").split(',').map { itt -> itt.toInt() } }
        a.forEach {
            if(it[0] == it[2]) {
                (it[1] toward it[3]).forEach { y ->
                    vents[it[0] to y] = vents[it[0] to y]!! + 1
                }
            }
            if(it[1] == it[3]) {
                (it[0] toward it[2]).forEach { x ->
                    vents[x to it[1]] = vents[x to it[1]]!! + 1
                }
            }
        }
        return vents.count { it.value > 1 }
    }

    fun part2(input: List<String>): Int {
        val vents = mutableMapOf<Pair<Int, Int>, Int>()
        for(i in 0..999) {
            for(j in 0..999) {
                vents[i to j] = 0
            }
        }
        val a = input.map { it.replace(" -> ", ",").split(',').map { itt -> itt.toInt() } }
        a.forEach {
            if(it[0] == it[2] && it[1] != it[3]) {
                (it[1] toward it[3]).forEach { y ->
                    vents[it[0] to y] = vents[it[0] to y]!! + 1
                }
            }
            else if(it[1] == it[3] && it[0] != it[2]) {
                (it[0] toward it[2]).forEach { x ->
                    vents[x to it[1]] = vents[x to it[1]]!! + 1
                }
            }
            //Must be a diagonal
            else {
                ((it[0] toward it[2]) zip (it[1] toward it[3])).forEach { pair ->
                    vents[pair] = vents[pair]!! + 1
                }
            }
        }
        return vents.count { it.value > 1 }
    }

    val testInput = readInput("Day05_test")
    check(part1(testInput) == 5)
    check(part2(testInput) == 12)

    val input = readInput("Day05")
    println(part1(input))
    println(part2(input))
}