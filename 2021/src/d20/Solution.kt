package d20

import check
import readInput

var infiniteState = 0
val offsets = listOf(-1 to -1, -1 to 0, -1 to 1, 0 to -1, 0 to 0, 0 to 1, 1 to -1, 1 to 0, 1 to 1)

fun enhance(image: List<List<Int>>, alg: List<Int>): List<List<Int>> {
    // Add two lines of zeros to top and bottom of the image
    var extendedImage = buildList {
        repeat(2) { add(List(image.size) { infiniteState }) }
        addAll(image)
        repeat(2) { add(List(image.size) { infiniteState }) }
    }
    // Add two lines of zeros to right and left side of the image
    extendedImage = extendedImage.map {
        buildList {
            repeat(2) { add(infiniteState) }
            addAll(it)
            repeat(2) { add(infiniteState) }
        }
    }

    val enhancedImage = List(extendedImage.size) { MutableList(extendedImage[0].size) { infiniteState } }
    for (y in 1 until extendedImage.size - 1) {
        for (x in 1 until extendedImage[0].size - 1) {
            var value = 0
            for (offset in offsets) {
                value *= 2
                value += extendedImage[y + offset.first][x + offset.second]
            }
            enhancedImage[y][x] = alg[value]
        }
    }
    infiniteState = if (infiniteState == 1 || alg[0] == 0) 0 else 1
    return enhancedImage.drop(1).dropLast(1).map { it.drop(1).dropLast(1) }
}

fun part1and2(input: List<String>, times: Int): Int {
    infiniteState = 0
    val imageEnhancementAlgorithm = input[0].map { if (it == '.') 0 else 1 }
    var image = input.drop(2).map { line -> line.map { if (it == '.') 0 else 1 } }
    repeat(times) {
        image = enhance(image, imageEnhancementAlgorithm)
    }
    return image.sumOf { it.sum() }
}

fun main() {
    val testInput = readInput("20", "input_test")
    val input = readInput("20", "input")
    check(35, part1and2(testInput, 2))
    println(part1and2(input, 2)) // 4968

    check(3351, part1and2(testInput, 50))
    println(part1and2(input, 50)) // 16793
}
