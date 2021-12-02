fun main() {
    fun part1(input: List<String>): Int {
        return input
            .map{ it.toInt() }
            .zipWithNext()
            .count { (a,b) -> b > a }
    }

    fun part2(input: List<String>): Int {
        return input
            .map { it.toInt() }
            .windowed(3) { it.sum() }
            .zipWithNext()
            .count { (a,b) -> b > a }
    }

    val testInput = readInput("Day01_test")
    check(part1(testInput) == 7)
    check(part2(testInput) == 5)

    val input = readInput("Day01")
    println(part1(input))
    println(part2(input))
}
