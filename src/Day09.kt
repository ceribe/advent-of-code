fun main() {
    data class Basin(var x: Int, var y: Int, val points: MutableSet<Pair<Int, Int>> = mutableSetOf())

    fun part1(input: List<String>): Int {
        val maxX = input[0].length
        val maxY = input.size
        var total = 0
        (0 until maxX).forEach { x ->
             (0 until maxY).forEach { y ->
                val currVal = input[y][x]
                val isLowest =
                            ((y-1) < 0 || currVal < input[y-1][x]) &&
                            ((x-1) < 0 || currVal < input[y][x-1]) &&
                            ((x+1) >= maxX || currVal < input[y][x+1]) &&
                            ((y+1) >= maxY || currVal < input[y+1][x])
                 if(isLowest)
                     total += currVal.toString().toInt() + 1
            }
        }
        return total
    }

    fun part2(input: List<String>): Int {
        val maxX = input[0].length
        val maxY = input.size
        val lowPoints = mutableListOf<Basin>()
        (0 until maxX).forEach { x ->
            (0 until maxY).forEach { y ->
                val currVal = input[y][x]
                val isLowest =
                    ((y-1) < 0 || currVal < input[y-1][x]) &&
                    ((x-1) < 0 || currVal < input[y][x-1]) &&
                    ((x+1) >= maxX || currVal < input[y][x+1]) &&
                    ((y+1) >= maxY || currVal < input[y+1][x])
                if(isLowest) {
                    val basin = Basin(x, y)
                    basin.points.add(x to y)
                    lowPoints.add(basin)
                }
            }
        }
        //99 is enough iterations to find the whole basin. Ineffective but faster to write
        (0..99).forEach { _ ->
            lowPoints.forEach { basin ->
                val pointsToAdd = mutableSetOf<Pair<Int, Int>>()
                basin.points.forEach {
                    if((it.first - 1) in (0 until maxX) && input[it.second][it.first-1] != '9')
                        pointsToAdd.add(it.first-1 to it.second)
                    if((it.first + 1) in (0 until maxX) && input[it.second][it.first+1] != '9')
                        pointsToAdd.add(it.first+1 to it.second)
                    if((it.second - 1) in (0 until maxY) && input[it.second-1][it.first] != '9')
                        pointsToAdd.add(it.first to it.second-1)
                    if((it.second + 1) in (0 until maxY) && input[it.second+1][it.first] != '9')
                        pointsToAdd.add(it.first to it.second+1)
                }
                basin.points.addAll(pointsToAdd)
            }
        }
        return lowPoints
            .sortedByDescending { it.points.size }
            .take(3)
            .map { it.points.size }
            .reduce{ acc, i -> acc * i }
    }

    val testInput = readInput("Day09_test")
    check(part1(testInput) == 15)
    check(part2(testInput) == 1134)

    val input = readInput("Day09")
    println(part1(input))
    println(part2(input))
}