package d08

import check
import readInput

/**
 * Sorts the string alphabetically
 */
fun String.sort() = String(toCharArray().apply { sort() })

fun part1(input: List<String>): Int {
    return input.sumOf { line ->
        line
            .split("|")[1]
            .split(' ')
            .count { segments -> segments.length in listOf(2, 3, 4, 7) }
    }
}

fun part2(input: List<String>): Int {
    val numbersIn = input.map { line ->
        line
            .split("|")[0]
            .split(' ')
            .map { it.sort() }
    }
    var sum = 0
    numbersIn.forEachIndexed { idx, numbers ->
        // Array which maps number shown to the active segments
        val n = Array(10) { "" }
        n[1] = numbers.first { it.length == 2 }
        n[7] = numbers.first { it.length == 3 }
        n[8] = numbers.first { it.length == 7 }
        n[4] = numbers.first { it.length == 4 }
        n[3] = numbers.first { it.length == 5 && n[7].all { l -> l in it } }
        n[9] = numbers.first { it.length == 6 && n[3].all { l -> l in it } }
        val bSegment = n[9].filter { it !in n[3] }
        n[5] = numbers.first { it.length == 5 && it != n[3] && bSegment in it }
        n[6] = numbers.first { it.length == 6 && n[5].all { l -> l in it } && it != n[9] }
        n[0] = numbers.first { it.length == 6 && it != n[9] && it != n[6] }
        n[2] = numbers.first { it.length == 5 && it != n[3] && it != n[5] }

        val numbersMap = n.mapIndexed { i, segment -> segment to i }.toMap()

        val numbersOut = input[idx]
            .split('|')[1]
            .split(' ')
            .map { it.sort() }
            .subList(1, 5)

        var number = 0
        for (i in 0..3) {
            number *= 10
            number += numbersMap[numbersOut[i]]!!
        }
        sum += number
    }
    return sum
}

fun main() {
    val testInput = readInput("08", "input_test")
    val input = readInput("08", "input")

    check(26, part1(testInput))
    println(part1(input)) // 342

    check(61229, part2(testInput))
    println(part2(input)) // 1068933
}
