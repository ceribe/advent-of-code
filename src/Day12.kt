fun main() {
    fun part1(input: List<String>): Int {
        val connectionMap = buildMap<String, List<String>> {
            //Build map of connections
            input.forEach {
                val (cave1, cave2) = it.split('-')
                put(cave1, getOrDefault(cave1, mutableListOf()) + cave2)
                put(cave2, getOrDefault(cave2, mutableListOf()) + cave1)
            }
        }
        val paths = mutableListOf<List<String>>()
        fun explore(path: List<String>) {
            connectionMap[path.last()]!!.forEach {
                if((it !in path || it.uppercase() == it) && it != "end") {
                    explore(path + it)
                }
                else if (it == "end") {
                    paths.add(path + "end")
                }
            }
        }
        explore(mutableListOf("start"))
        return paths.size
    }

    fun part2(input: List<String>): Int {
        val connectionMap = buildMap<String, List<String>> {
            //Build map of connections
            input.forEach {
                val (cave1, cave2) = it.split('-')
                put(cave1, getOrDefault(cave1, mutableListOf()) + cave2)
                put(cave2, getOrDefault(cave2, mutableListOf()) + cave1)
            }
        }
        val paths = mutableListOf<List<String>>()
        fun List<String>.canVisitSmallCave(): Boolean {
            filter { it.lowercase() == it }.forEach {
                if(count { it2 -> it2 == it } > 1)
                    return false
            }
            return true
        }
        fun explore(path: List<String>) {
            connectionMap[path.last()]!!.forEach {
                when (it) {
                    "end" -> paths.add(path + "end")
                    it.uppercase() -> explore(path + it)
                    !in path -> explore(path + it)
                    else -> if(path.canVisitSmallCave() && it != "start") explore(path + it)
                }
            }
        }
        explore(mutableListOf("start"))
        return paths.size
    }

    val testInput = readInput("Day12_test")
    check(part1(testInput) == 10)
    check(part2(testInput) == 36)

    val input = readInput("Day12")
    println(part1(input))
    println(part2(input))
}