fun main() {
    data class Octopus(var energy: Int, var flashed: Boolean = false)

    fun part1(input: List<String>): Int {
        val octoMap = input.map { it.map { it2 -> Octopus(it2.toString().toInt()) } }
        var flashesTotal = 0
        (1..100).forEach { _ ->
            //Increase energy of all by 1
            octoMap.map { it.map { it2 -> it2.energy++ } }
            var newFlashHappened = false
            //Process flashes
            label@ while (true) {
                for(x in 0..9) {
                    for(y in 0..9) {
                        if(octoMap[x][y].energy > 9 && !octoMap[x][y].flashed) {
                            octoMap[x][y].flashed = true
                            if(x-1>=0 && y-1>=0) octoMap[x-1][y-1].energy++
                            if(y-1>=0) octoMap[x][y-1].energy++
                            if(x+1<10 && y-1>=0) octoMap[x+1][y-1].energy++
                            if(x-1>=0) octoMap[x-1][y].energy++
                            if(x+1<10) octoMap[x+1][y].energy++
                            if(x-1>=0 && y+1<10) octoMap[x-1][y+1].energy++
                            if(y+1<10) octoMap[x][y+1].energy++
                            if(x+1<10 && y+1<10) octoMap[x+1][y+1].energy++
                            flashesTotal++
                            continue@label
                        }
                    }
                }
                break@label
            }
            octoMap.map { it.map { it2 -> if(it2.flashed) { it2.energy = 0; it2.flashed = false } } }
        }
        return flashesTotal
    }

    fun part2(input: List<String>): Int {
        val octoMap = input.map { it.map { it2 -> Octopus(it2.toString().toInt()) } }
        var flashesTotal = 0
        (1..10000).forEach { step ->
            //Increase energy of all by 1
            octoMap.map { it.map { it2 -> it2.energy++ } }
            var newFlashHappened = false
            //Process flashes
            label@ while (true) {
                for(x in 0..9) {
                    for(y in 0..9) {
                        if(octoMap[x][y].energy > 9 && !octoMap[x][y].flashed) {
                            octoMap[x][y].flashed = true
                            if(x-1>=0 && y-1>=0) octoMap[x-1][y-1].energy++
                            if(y-1>=0) octoMap[x][y-1].energy++
                            if(x+1<10 && y-1>=0) octoMap[x+1][y-1].energy++
                            if(x-1>=0) octoMap[x-1][y].energy++
                            if(x+1<10) octoMap[x+1][y].energy++
                            if(x-1>=0 && y+1<10) octoMap[x-1][y+1].energy++
                            if(y+1<10) octoMap[x][y+1].energy++
                            if(x+1<10 && y+1<10) octoMap[x+1][y+1].energy++
                            flashesTotal++
                            continue@label
                        }
                    }
                }
                break@label
            }
            octoMap.map { it.map { it2 -> if(it2.flashed) { it2.energy = 0; it2.flashed = false } } }
            if(octoMap.sumOf { it.sumOf { it2 -> it2.energy } } == 0)
                return step
        }
        return -1
    }

    val testInput = readInput("Day11_test")
    check(part1(testInput) == 1656)
    check(part2(testInput) == 195)

    val input = readInput("Day11")
    println(part1(input))
    println(part2(input))
}