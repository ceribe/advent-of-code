package d18

import check
import readInput
import kotlin.math.ceil
import kotlin.math.floor

abstract class Number(var parent: Number? = null) {
    fun magnitude(): Long = when (this) {
        is Ordinary -> value.toLong()
        is SFNumber -> left.magnitude() * 3 + right.magnitude() * 2
        else -> 0L
    }
}
data class Ordinary(var value: Int) : Number()
data class SFNumber(var left: Number, var right: Number) : Number() {
    private fun findNumberOnDepth(depth: Int): SFNumber? {
        if (depth == 0) return this
        (left as? SFNumber)?.findNumberOnDepth(depth - 1)?.let { return it }
        (right as? SFNumber)?.findNumberOnDepth(depth - 1)?.let { return it }
        return null
    }

    private fun getListOfOrdinaryNumbers(): List<Ordinary> {
        val list = mutableListOf<Ordinary>()
        fun SFNumber.addToList() {
            (left as? SFNumber)?.addToList()
            (left as? Ordinary)?.let { list.add(it) }
            (right as? SFNumber)?.addToList()
            (right as? Ordinary)?.let { list.add(it) }
        }
        addToList()
        return list
    }

    private fun findNumberWithValue(value: Int): Number? {
        return getListOfOrdinaryNumbers().find { it.value >= value }
    }

    private fun findNeighboursOf(node: Ordinary): Pair<Ordinary?, Ordinary?> {
        val list = getListOfOrdinaryNumbers()
        val idx = list.indexOfFirst { it === node }
        return list.getOrNull(idx - 1) to list.getOrNull(idx + 1)
    }

    fun reduce(): SFNumber {
        while (true) {
            val number = findNumberOnDepth(4)
            if (number != null) {
                val parent = (number.parent as SFNumber)
                val lVal = (number.left as Ordinary).value
                val rVal = (number.right as Ordinary).value
                val newNumber = Ordinary(0)
                newNumber.parent = parent
                if (parent.left === number) {
                    parent.left = newNumber
                }
                if (parent.right === number) {
                    parent.right = newNumber
                }
                val (leftN, rightN) = this.findNeighboursOf(newNumber)
                if (leftN != null) {
                    leftN.value += lVal
                }
                if (rightN != null) {
                    rightN.value += rVal
                }
                continue
            }
            val number2 = findNumberWithValue(10)
            if (number2 != null) {
                val parent = (number2.parent as SFNumber)
                val ordinary = number2 as Ordinary
                val splitNumber = SFNumber(
                    Ordinary(floor(ordinary.value / 2.0).toInt()), Ordinary(ceil(ordinary.value / 2.0).toInt())
                )
                splitNumber.parent = parent
                splitNumber.left.parent = splitNumber
                splitNumber.right.parent = splitNumber
                if (parent.left === number2) {
                    parent.left = splitNumber
                }
                if (parent.right === number2) {
                    parent.right = splitNumber
                }
                continue
            }
            break
        }
        return this
    }
}

fun parseSFNumber(s: String): Number {
    var i = 0
    fun parse(): Number {
        if (s[i] == '[') {
            i++
            val left = parse()
            i++
            val right = parse()
            i++
            val newNumber = SFNumber(left, right)
            left.parent = newNumber
            right.parent = newNumber
            return newNumber
        }
        return Ordinary(s[i++].digitToInt())
    }
    return parse()
}

fun part1(input: List<String>): Long {
    val numbers = input.map { parseSFNumber(it) }
    val additionResult = numbers.reduce { acc, number ->
        val newNumber = SFNumber(acc, number)
        acc.parent = newNumber
        number.parent = newNumber
        newNumber.reduce()
    }
    return additionResult.magnitude()
}

fun part2(input: List<String>): Long {
    var numbers = input.map { parseSFNumber(it) }
    val magnitudes = buildList {
        numbers.indices.forEach { i ->
            numbers.indices.forEach { j ->
                if (i != j) {
                    val newNumber = SFNumber(numbers[i], numbers[j])
                    numbers[i].parent = newNumber
                    numbers[j].parent = newNumber
                    add(newNumber.reduce().magnitude())
                    // Numbers are references and are changed by "reduce()" so for each iteration they have to be refreshed
                    numbers = input.map { parseSFNumber(it) }
                }
            }
        }
    }
    return magnitudes.maxOf { it }
}

fun main() {
    val testInput = readInput("18", "input_test")
    val input = readInput("18", "input")

    check(4140L, part1(testInput))
    println("Part 1: " + part1(input)) // 2541

    check(3993L, part2(testInput))
    println("Part 2: " + part2(input)) // 4647
}
