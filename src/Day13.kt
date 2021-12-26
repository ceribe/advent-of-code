import java.lang.Exception

fun main() {
    data class FoldInstruction(val axis: Char, val pos: Int)

    fun part1and2(input: List<String>) {
        val instructions = mutableListOf<FoldInstruction>()
        val dots = mutableListOf<Pair<Int,Int>>()
        var dividerFound = false
        input.forEach {
            if (it == "") {
                dividerFound = true
            }
            else if (!dividerFound)
                dots.add(it.split(',')[0].toInt() to it.split(',')[1].toInt())
            else {
                val (axis, pos) = it.split(' ')[2].split('=')
                instructions.add(FoldInstruction(axis[0], pos.toInt()))
            }
        }
        var map = mutableListOf<String>()
        val maxX = dots.maxOf { it.first } + 1
        val maxY = dots.maxOf { it.second } + 1 //+1 to account for 0 based indexing
        repeat(maxY) {
            map.add(".".repeat(maxX))
        }
        fun MutableList<String>.set(x: Int, y: Int) {
            val prev = get(y).toCharArray()
            prev[x] = '#'
            set(y, String(prev))
        }
        dots.forEach {
            map.set(it.first, it.second)
        }
        fun foldHorizontally(map: MutableList<String>, pos: Int) {
            for (i in 0 until pos) {
                for (x in 0 until map[0].length) {
                    try {
                        if (map[pos * 2 - i][x] == '#') {
                            map.set(x, i)
                        }
                    }
                    catch (_: Exception) {}
                }
            }
        }
        fun foldVertically(map: MutableList<String>, pos: Int) {
            for (i in 0 until pos) {
                for (y in 0 until map.size) {
                    try {
                        if (map[y][pos * 2 - i] == '#') {
                            map.set(i, y)
                        }
                    }
                    catch (_: Exception) {}
                }
            }
        }
        instructions.forEachIndexed { idx, it ->
            when (it.axis) {
                'x' -> {
                    foldVertically(map, it.pos)
                    map = map.map { s -> s.substring(0, it.pos) }.toMutableList()
                }
                'y' -> {
                    foldHorizontally(map, it.pos)
                    map = map.subList(0, it.pos)
                }
            }
            if (idx == 0) {
                println("After first fold: " + map.sumOf { it.map { it2-> if(it2 == '#') 1 else 0 }.sum() })
            }
        }
        println("After all folds:")
        map.forEach {
            println(it)
        }
    }


    val testInput = readInput("Day13_test")
    part1and2(testInput)

    val input = readInput("Day13")
    part1and2(input)
}