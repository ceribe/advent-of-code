fun main() {
    fun createVentMap(): MutableMap<Pair<Int, Int>, Int> {
        val vents = mutableMapOf<Pair<Int, Int>, Int>()
        for(i in 0..999) {
            for(j in 0..999) {
                vents[i to j] = 0
            }
        }
        return vents
    }
    fun processInput(input: List<String>) = input
        .map {
            it
                .replace(" -> ", ",")
                .split(',')
                .map { itt -> itt.toInt() }
        }

    fun part1(input: List<String>): Int {
        val vents = createVentMap()
        val a = processInput(input)
        a.forEach {
            val (x1,y1,x2,y2) = it
            if(x1 == x2) {
                (y1 toward y2).forEach { y ->
                    vents[x1 to y] = vents[x1 to y]!! + 1
                }
            }
            if(y1 == y2) {
                (x1 toward x2).forEach { x ->
                    vents[x to y1] = vents[x to y1]!! + 1
                }
            }
        }
        return vents.count { it.value > 1 }
    }

    fun part2(input: List<String>): Int {
        val vents = createVentMap()
        val a = processInput(input)
        a.forEach {
            val (x1,y1,x2,y2) = it
            if(x1 == x2 && y1 != y2) {
                (y1 toward y2).forEach { y ->
                    vents[x1 to y] = vents[x1 to y]!! + 1
                }
            }
            else if(y1 == y2 && x1 != x2) {
                (x1 toward x2).forEach { x ->
                    vents[x to y1] = vents[x to y1]!! + 1
                }
            }
            //Must be a diagonal
            else {
                ((x1 toward x2) zip (y1 toward y2)).forEach { pair ->
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