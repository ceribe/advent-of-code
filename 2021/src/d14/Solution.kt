package d14

import check
import readInput

fun part1and2(input: List<String>, stepsCount: Int): Long {
    val initialPolymer = input[0]
    // Creates a map of rules
    // Example: HB -> C is mapped to key=HB, value = [HC, CB]
    val rules = input.drop(2).associate { line ->
        val (key, value) = line.split(" -> ")
        key to listOf("${key[0]}$value", "$value${key[1]}")
    }
    // Maps polymer to a map which keys are pairs of chars and values are counts
    var currentPolymer = initialPolymer
        .windowed(2, 1)
        .groupingBy { it }
        .eachCount()
        .mapValues { it.value.toLong() }

    repeat(stepsCount) {
        // In each iteration a new map is created. Second for loop maps one pair of chars to two pairs of chars
        // effectively inserting a char between them
        currentPolymer = buildMap {
            for ((pair, count) in currentPolymer) {
                for (charPair in rules[pair]!!) {
                    put(charPair, getOrDefault(charPair, 0) + count)
                }
            }
        }
    }
    val counts = buildMap<Char, Long> {
        // Add first and last char to have all values doubled
        // Example: polymer NNCB would be mapped to NN NC CB -> N=3, C=2,B=1
        // increasing N and B by 1 and then dividing by 2 gives count
        put(initialPolymer.first(), 1)
        put(initialPolymer.last(), 1)
        for ((pair, count) in currentPolymer) {
            for (char in pair) {
                put(char, getOrDefault(char, 0L) + count)
            }
        }
    }
    return (counts.values.max() - counts.values.min()) / 2
}

fun main() {
    val testInput = readInput("14", "input_test")
    val input = readInput("14", "input")

    check(1588, part1and2(testInput, 10))
    println(part1and2(input, 10)) // 3118

    check(2188189693529, part1and2(testInput, 40))
    println(part1and2(input, 40)) // 4332887448171
}
