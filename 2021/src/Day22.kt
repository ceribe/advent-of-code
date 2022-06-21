import kotlin.math.max
import kotlin.math.min

fun main() {
    data class Cube(
            val on: Boolean,
            val x: IntRange,
            val y: IntRange,
            val z: IntRange
    ) {
        infix fun overlaps(o: Cube): Boolean {
            return x.last >= o.x.first && x.first <= o.x.last &&
                    y.last >= o.y.first && y.first <= o.y.last &&
                    z.last >= o.z.first && z.first <= o.z.last
        }
    }


    fun parseInstructions(input: List<String>): List<Cube> {
        val onList = input.map { it.split(' ')[0] }
        val numbers = input.map {
            it
                .split(' ')[1]
                .replace(Regex("[^-0-9]"), " ")
                .replace("\\s+".toRegex(), " ")
                .trim()
                .split(' ')
                .map { it2 -> it2.toInt() }
        }
        return buildList {
            onList.zip(numbers).forEach {
                add(
                    Cube(
                        it.first == "on",
                        it.second[0]..it.second[1],
                        it.second[2]..it.second[3],
                        it.second[4]..it.second[5],
                    )
                )
            }
        }
    }

    fun part1(input: List<String>): Int {
        val instructions = parseInstructions(input)
        data class MiniCube(val x: Int, val y: Int, val z: Int)
        val activeCubes = mutableSetOf<MiniCube>()
        instructions.forEach {
            for (x in max(it.x.first, -50)..min(it.x.last, 50)) {
                for (y in max(it.y.first,-50)..min(it.y.last,50)) {
                    for (z in max(it.z.first,-50)..min(it.z.last,50)) {
                        if (it.on) {
                            activeCubes.add(MiniCube(x,y,z))
                        }
                        else {
                            activeCubes.remove(MiniCube(x,y,z))
                        }
                    }
                }
            }

        }
        return activeCubes.size
    }

    fun part2(input: List<String>): Long {
        val instructions = parseInstructions(input)
        val reactorState = mutableListOf<Cube>()
        instructions.forEach {
            val overlaps = mutableListOf<Cube>()
            reactorState.forEach { range ->
                // Always cut overlaps from reactor state. When cutting from "on" cube an "off" cube is added.
                // Thanks to this the next time when there would be a cut from the same region two overlaps would be added
                // one positive and one negative effectively negating each other. Always cutting also ensures that
                // when two positive cubes overlap the overlap cube is added as a negative cube. (Kind of like Vien Diagram
                // where you have to subtract the shared values)
                if (it overlaps range) {
                    overlaps.add(Cube(
                        !range.on,
                        max(it.x.first, range.x.first)..min(it.x.last, range.x.last),
                        max(it.y.first, range.y.first)..min(it.y.last, range.y.last),
                        max(it.z.first, range.z.first)..min(it.z.last, range.z.last)
                    ))
                }
            }
            reactorState.addAll(overlaps)
            if (it.on) reactorState.add(it)
        }
        return reactorState.fold(0L) { acc: Long, c: Cube ->
            acc + (if (c.on) 1L else -1L) * (c.x.last - c.x.first + 1) * (c.y.last - c.y.first + 1) * (c.z.last - c.z.first + 1)
        }
    }

    val testInput = readInput("Day22_test")
    check(part1(testInput) == 590784)
    check(part2(testInput) == 39769202357779L)

    val input = readInput("Day22")
    println(part1(input))
    println(part2(input))
}