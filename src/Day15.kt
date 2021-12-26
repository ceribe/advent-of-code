import java.lang.Integer.min

fun main() {
    fun getSmallestRisk(chitos: List<List<Int>>): Int {
        val maxX = chitos[0].size - 1
        val maxY = chitos.size - 1
        val costMap = List(maxY + 1) { MutableList(maxX + 1) { 999999 } }
        costMap[0][0] = 0
        // Set first row
        for (x in 1..maxX) {
            costMap[0][x] = costMap[0][x - 1] + chitos[0][x]
        }
        // Set all columns
        repeat(maxX + 1) { x ->
            for (y in 1..maxY) {
                costMap[y][x] = costMap[y - 1][x] + chitos[y][x]
            }
        }

        // Brute force all costs
        repeat(chitos.size) {
            repeat(maxY + 1) { y ->
                for (x in 1..maxX) {
                    costMap[y][x] = min(costMap[y][x - 1] + chitos[y][x], costMap[y][x])
                }
            }

            repeat(maxX + 1) { x ->
                for (y in 1..maxY) {
                    costMap[y][x] = min(costMap[y - 1][x] + chitos[y][x], costMap[y][x])
                }
            }
            repeat(maxY + 1) { y ->
                for (x in 0 until maxX) {
                    costMap[y][x] = min(costMap[y][x + 1] + chitos[y][x], costMap[y][x])
                }
            }

            repeat(maxX + 1) { x ->
                for (y in 0 until maxY) {
                    costMap[y][x] = min(costMap[y + 1][x] + chitos[y][x], costMap[y][x])
                }
            }
        }
        return costMap[maxY][maxX]
    }

    fun getChitos(input: List<String>) = input.map { it.toCharArray().map { it2-> it2.digitToInt() } }

    fun part1(input: List<String>): Int {
        val chitos = getChitos(input)
        return getSmallestRisk(chitos)
    }

    fun part2(input: List<String>): Int {
        val chitos = getChitos(input)
        val y = chitos.size
        val x = chitos[0].size
        val newY = 5 * y
        val newX = 5 * x
        val newChitos = List(newY) { i ->
            MutableList(newX) { j ->
                val k = i / y + j / x
                (chitos[i % y][j % x] + k - 1) % 9 + 1
            }
        }
        return getSmallestRisk(newChitos)
    }

    val testInput = readInput("Day15_test")
    check(part1(testInput) == 40)
    check(part2(testInput) == 315)

    val input = readInput("Day15")
    println(part1(input))
    println(part2(input))
}