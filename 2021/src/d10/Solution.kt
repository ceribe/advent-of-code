package d10

import check
import readInput

fun Char.complementary() = when (this) {
    '(' -> ')'
    '[' -> ']'
    '{' -> '}'
    '<' -> '>'
    else -> throw Exception("Unexpected character")
}

/**
 * Checks if line is corrupted. If it is returns unexpected char, else returns ' '
 */
fun getCorruptedStatus(line: String): Char {
    val stack = mutableListOf<Char>()
    line.forEach {
        when (it) {
            in "([{<" -> stack.add(it)
            stack.last().complementary() -> stack.removeLast()
            else -> return it
        }
    }
    return ' '
}

/**
 * Returns list of chars which complete given [line]
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
    fun getPoints(char: Char) = when (char) {
        ')' -> 3
        ']' -> 57
        '}' -> 1197
        '>' -> 25137
        else -> throw Exception("Unexpected character $char")
    }
    return input
        .map { getCorruptedStatus(it) }
        .filter { it != ' ' }
        .sumOf { getPoints(it) }
}

/**
 * Returns middle element of [this] list
 */
fun <T> List<T>.middleElement(): T {
    return get(size / 2)
}

fun part2(input: List<String>): Int {
    fun getPoints(char: Char) = when (char) {
        ')' -> 1
        ']' -> 2
        '}' -> 3
        '>' -> 4
        else -> throw Exception("Unexpected character: $char")
    }

    return input
        .filter { getCorruptedStatus(it) == ' ' }
        .map { line ->
            getAutoComplete(line)
                .map { getPoints(it).toLong() }
                .reduce { acc, i -> acc * 5 + i }
        }
        .sorted()
        .middleElement()
        .toInt()
}

fun main() {
    val testInput = readInput("10", "input_test")
    val input = readInput("10", "input")

    check(26397, part1(testInput))
    println(part1(input)) // 392043

    check(288957, part2(testInput))
    println(part2(input)) // 1605968119
}
