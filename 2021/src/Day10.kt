
fun main() {
    fun Char.complementary() = when(this) {
        '(' -> ')'
        '[' -> ']'
        '{' -> '}'
        '<' -> '>'
        else -> throw Exception("Unexpected character")
    }

    /**
     * Checks if line is corrupted. If it is returns unexpected char else returns ' '
     */
    fun String.corruptedStatus(): Char {
        val stack = mutableListOf<Char>()
        forEach {
            when (it) {
                in "([{<" -> stack.add(it)
                stack.last().complementary() -> stack.removeLast()
                else -> return it
            }
        }
        return ' '
    }

    /**
     * Returns list of chars which complete [line]
     */
    fun getAutoComplete(line: String): List<Char> {
        val stack = mutableListOf<Char>()
        line.forEach {
            when (it) {
                in "([{<" -> stack.add(it)
                stack.last().complementary() -> stack.removeLast()
                else -> throw Exception("Line is corrupted")
            }
        }
        return stack.map { it.complementary() }.reversed()
    }


    fun part1(input: List<String>): Int {
        fun Char.points() = when (this) {
            ')' -> 3
            ']' -> 57
            '}' -> 1197
            '>' -> 25137
            else -> throw Exception("Unexpected character $this")
        }
        return input.map { it.corruptedStatus() }.filter { it != ' ' }.sumOf { it.points() }
    }

    fun part2(input: List<String>): Int {
        fun Char.points() = when (this) {
            ')' -> 1
            ']' -> 2
            '}' -> 3
            '>' -> 4
            else -> throw Exception("Unexpected character: $this")
        }

        /**
         * Returns middle element of [this] list
         */
        fun<T> List<T>.middle(): T {
            return get(size / 2)
        }

        return input
            .filter { it.corruptedStatus() == ' ' }
            .map {
                getAutoComplete(it)
                    .map { it2 -> it2.points().toLong() }
                    .reduce { acc, i -> acc * 5 + i }
            }
            .sorted()
            .middle()
            .toInt()
    }

    val testInput = readInput("Day10_test")
    check(part1(testInput) == 26397)
    check(part2(testInput) == 288957)

    val input = readInput("Day10")
    println(part1(input))
    println(part2(input))
}