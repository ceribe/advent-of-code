fun main() {
    fun part1(input: List<String>): Int {
        var x = 0
        var y = 0
        input.map { it.split(' ') }.forEach { (direction, value) ->
            when (direction) {
                "forward" -> x += value.toInt()
                "up" -> y -= value.toInt()
                "down" -> y += value.toInt()
            }
        }
        return x * y
    }

    fun part2(input: List<String>): Int {
        var x = 0
        var y = 0
        var aim = 0
        input.map { it.split(' ') }.forEach { (direction, value) ->
            when (direction) {
                "forward" -> {
                    x += value.toInt(); y += aim * value.toInt()
                }
                "up" -> aim -= value.toInt()
                "down" -> aim += value.toInt()
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
