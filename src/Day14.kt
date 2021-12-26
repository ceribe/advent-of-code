fun main() {
    fun part1(input: List<String>): Int {
        val polymer = input[0].toMutableList()
        val rulesMap = mutableMapOf<String, String>()
        input.subList(2, input.size).forEach {
            val (key, value) = it.split(" -> ")
            rulesMap[key] = value
        }
        repeat(10) {
            var j = 0
            while (true) {
                val newElement = rulesMap[(polymer[j].toString()+polymer[j+1].toString())]
                polymer.add(j+1, newElement!![0])
                j+=2
                if (polymer.size <= j+1)
                    break
            }
        }
        val letters = polymer.toSet().toList().sorted()
        var minVal = 99999
        var maxVal = 0
        letters.forEach { char ->
            val count = polymer.count { it == char }
            if(count < minVal) {
                minVal = count
            }
            if(count > maxVal) {
                maxVal = count
            }
        }
        return maxVal-minVal
    }

    fun part2(input: List<String>): Long {
        val initialPolymer = input[0]
        // Creates a map of rules
        // Example: HB -> C is mapped to key=HB, value = [HC, CB]
        val rules = input.drop(2).associate { line ->
            val (key, value) = line.split(" -> ")
            key to listOf("${key[0]}$value", "$value${key[1]}")
        }
        // Maps polymer to a map which keys are pairs of chars and values are counts
        var currentPolymer = initialPolymer
            .windowed(2,1)
            .groupingBy { it }
            .eachCount()
            .mapValues { it.value.toLong() }
        repeat(40) {
            // In each iteration a new map is created. Second for loop maps one pair of chars to two pairs of chars
            // effectively inserting a char between them
            currentPolymer = buildMap {
                for ((pair, count) in currentPolymer) {
                    for (dst in rules.getValue(pair)) {
                        put(dst, getOrElse(dst) { 0 } + count)
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
                for (c in pair) {
                    put(c, getOrElse(c) { 0 } + count)
                }
            }
        }
        return (counts.values.maxOrNull()!! - counts.values.minOrNull()!!) / 2
    }

    val testInput = readInput("Day14_test")
    check(part1(testInput) == 1588)
    check(part2(testInput) == 2188189693529)

    val input = readInput("Day14")
    println(part1(input))
    println(part2(input))
}