fun main() {
    fun part1(input: List<String>): Int {
        return input.sumOf {
            it
                .split("|")[1]
                .split(' ')
                .count { it2 -> it2.length in listOf(2,3,4,7) }
        }
    }
    fun part2(input: List<String>): Int {
        val numbersIn = input.map { it.split("|")[0].split(' ').map { it2 -> it2.sort() } }
        var sum = 0
        numbersIn.forEachIndexed { idx, numbers ->
            val n1 = numbers.first { it.length == 2 }
            val n7 = numbers.first { it.length == 3 }
            val n8 = numbers.first { it.length == 7 }
            val n4 = numbers.first { it.length == 4 }
            val n3 = numbers.first { it.length == 5 && n7.all { l -> l in it } }
            val n9 = numbers.first { it.length == 6 && n3.all { l -> l in it } }
            val b = n9.filter { it !in n3 }
            val n5 = numbers.first { it != n3 && b in it && it.length == 5 }
            val n6 = numbers.first { it.length == 6 && n5.all { l -> l in it} && it != n9}
            val n0 = numbers.first { it.length == 6 && it != n9 && it != n6 }
            val n2 = numbers.first { it.length == 5 && it != n3  && it != n5 }
            val numbersMap = mapOf(
                n0 to 0,
                n1 to 1,
                n2 to 2,
                n3 to 3,
                n4 to 4,
                n5 to 5,
                n6 to 6,
                n7 to 7,
                n8 to 8,
                n9 to 9
            )
            val numbersOut = input[idx].split('|')[1].split(' ').map { it.sort() }.subList(1, 5)
            val number = numbersMap[numbersOut[0]]!! * 1000 +
                    numbersMap[numbersOut[1]]!! * 100 +
                    numbersMap[numbersOut[2]]!! * 10 +
                    numbersMap[numbersOut[3]]!!
            sum += number
        }
        return sum
    }

    val testInput = readInput("Day08_test")
    check(part1(testInput) == 26)
    check(part2(testInput) == 61229)

    val input = readInput("Day08")
    println(part1(input))
    println(part2(input))
}