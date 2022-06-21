import kotlin.math.absoluteValue

fun main() {
    fun part1(input: List<String>): Int {
        val positions = input[0].split(',').map { it.toInt() }
        val minPos = positions.minOf { it }
        val maxPos = positions.maxOf { it }
        return (minPos..maxPos).minOf { positions.sumOf { it2 -> (it2 - it).absoluteValue } }
    }

    fun part2(input: List<String>): Int {
        val positions = input[0].split(',').map { it.toInt() }
        val minPos = positions.minOf { it }
        val maxPos = positions.maxOf { it }
        return (minPos..maxPos).minOf {
            positions.sumOf { it2 ->
                (1..(it2 - it).absoluteValue).sumOf { it3 -> it3 }
            }
        }
    }

    val testInput = readInput("Day07_test")
    check(part1(testInput) == 37)
    check(part2(testInput) == 168)

    val input = readInput("Day07")
    println(part1(input))
    println(part2(input))
}