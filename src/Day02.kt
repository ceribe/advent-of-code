fun main() {
    fun part1(input: List<String>): Int {
        var x = 0
        var y = 0
        input.map { val s = it.split(' '); s[0] to s[1] }.forEach {
            val value = it.second.toInt()
            when (it.first) {
                "forward" -> x += value
                "up" -> y -= value
                "down" -> y += value
            }
        }
        return x * y
    }

    fun part2(input: List<String>): Int {
        var x = 0
        var y = 0
        var aim = 0
        input.map { val s = it.split(' '); s[0] to s[1] }.forEach {
            val value = it.second.toInt()
            when (it.first) {
                "forward" -> {
                    x += value; y += aim * value
                }
                "up" -> aim -= value
                "down" -> aim += value
            }
        }
        return x * y
    }

    val testInput = readInput("Day02_test")
    check(part1(testInput) == 150)
    check(part2(testInput) == 900)

    val input = readInput("Day02")
    println(part1(input))
    println(part2(input))
}
