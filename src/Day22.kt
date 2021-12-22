import kotlin.math.max
import kotlin.math.min

fun main() {
    fun part1(input: List<String>): Int {
        val onList = input.map { it.split(' ')[0] }
        val ranges = input.map {
            it
                .split(' ')[1]
                .replace(Regex("[^-0-9]"), " ")
                .replace("\\s+".toRegex(), " ")
                .trim()
                .split(' ')
                .map { it2 -> it2.toInt() }
        }
        data class Cube(val x: Int, val y: Int, val z: Int)
        val activeCubes = mutableSetOf<Cube>()
        ranges.zip(onList).forEach {
            for (x in max(it.first[0], -50)..min(it.first[1], 50)) {
                for (y in max(it.first[2],-50)..min(it.first[3],50)) {
                    for (z in max(it.first[4],-50)..min(it.first[5],50)) {
                        if(it.second == "on") {
                            activeCubes.add(Cube(x,y,z))
                        }
                        else {
                            activeCubes.remove(Cube(x,y,z))
                        }
                    }
                }
            }

        }
        return activeCubes.size
    }

    fun part2(input: List<String>): Long {
        data class Range(
            val on: Boolean,
            val x1: Long,
            val x2: Long,
            val y1: Long,
            val y2: Long,
            val z1: Long,
            val z2: Long
        )

        val onList = input.map { it.split(' ')[0] }
        val numbers = input.map {
            it
                .split(' ')[1]
                .replace(Regex("[^-0-9]"), " ")
                .replace("\\s+".toRegex(), " ")
                .trim()
                .split(' ')
                .map { it2 -> it2.toLong() }
        }
        val ranges = buildList {
            onList.zip(numbers).forEach {
                add(
                    Range(
                        it.first == "on",
                        it.second[0],
                        it.second[1],
                        it.second[2],
                        it.second[3],
                        it.second[4],
                        it.second[5]
                    )
                )
            }
        }

        infix fun Range.overlaps(o: Range): Boolean {
            return x2 >= o.x1 && x1 <= o.x2 && y2 >= o.y1 && y1 <= o.y2 && z2 >= o.z1 && z1 <= o.z2
        }

        val reactorState = mutableListOf<Range>()
        ranges.forEach {
            val overlaps = mutableListOf<Range>()
            reactorState.forEach { range ->
                //Always cut overlaps from reactor state. Cutting from off state needs to add an on state so calculations later on are correct
                if (it overlaps range) {
                    overlaps.add(Range(
                        !range.on,
                        max(it.x1, range.x1),
                        min(it.x2, range.x2),
                        max(it.y1, range.y1),
                        min(it.y2, range.y2),
                        max(it.z1, range.z1),
                        min(it.z2, range.z2),
                    ))
                }
            }

            reactorState.addAll(overlaps)
            if (it.on) reactorState.add(it)
        }
        return reactorState.fold(0L) { acc: Long, r: Range ->
            acc + (if (r.on) 1L else -1L) * (r.x2 - r.x1 + 1) * (r.y2 - r.y1 + 1) * (r.z2 - r.z1 + 1)
        }
    }

    val testInput = readInput("Day22_test")
    check(part1(testInput) == 590784)
    check(part2(testInput) == 39769202357779L)

    val input = readInput("Day22")
    println(part1(input))
    println(part2(input))
}