fun main() {

    fun List<Int>.toLong() = joinToString("").toLong(2)

    var infiniteState = 0

    fun enhance(image: List<List<Int>>, alg: List<Int>): List<List<Int>> {
        //Add two lines of zeros to top and bottom of the image
        var extendedImage= buildList {
            repeat(2) { add(List(image.size) { infiniteState }) }
            addAll(image)
            repeat(2) { add(List(image.size) { infiniteState }) }
        }
        //Add two lines of zeros to right and left side of the image
        extendedImage = extendedImage.map {
            buildList {
                repeat(2) { add(infiniteState) }
                addAll(it)
                repeat(2) { add(infiniteState) }
            }
        }

        val enhancedImage = MutableList(extendedImage.size) { MutableList(extendedImage[0].size) { infiniteState } }
        for (y in 1 until extendedImage.size - 1) {
            for (x in 1 until extendedImage[0].size - 1) {
                val value = buildList {
                    add(extendedImage[y-1][x-1])
                    add(extendedImage[y-1][x])
                    add(extendedImage[y-1][x+1])
                    add(extendedImage[y][x-1])
                    add(extendedImage[y][x])
                    add(extendedImage[y][x+1])
                    add(extendedImage[y+1][x-1])
                    add(extendedImage[y+1][x])
                    add(extendedImage[y+1][x+1])
                }.toLong()
                enhancedImage[y][x] = alg[value.toInt()]
            }
        }
        infiniteState = if (infiniteState == 1 || alg[0] == 0) 0 else 1
        return enhancedImage.drop(1).dropLast(1).map { it.drop(1).dropLast(1) }
    }

    fun part1(input: List<String>): Int {
        val alg = input[0].map { if(it=='.') 0 else 1 }
        var image = input.drop(2).map { line -> line.map { if(it=='.') 0 else 1 } }
        repeat(2) {
            image = enhance(image, alg)
        }
        return image.sumOf { it.sum() }
    }

    fun part2(input: List<String>): Int {
        val alg = input[0].map { if(it=='.') 0 else 1 }
        var image = input.drop(2).map { line -> line.map { if(it=='.') 0 else 1 } }
        repeat(50) {
            image = enhance(image, alg)
        }
        return image.sumOf { it.sum() }
    }

    val testInput = readInput("Day20_test")
    check(part1(testInput) == 35)
    check(part2(testInput) == 3351)

    val input = readInput("Day20")
    println(part1(input))
    println(part2(input))
}