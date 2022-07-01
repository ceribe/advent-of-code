package d22

import check
import readInput

/**
 * Just for the convenience and since this is not a real program this class represents both a cube and an instruction.
 */
data class Cube(
    val isOn: Boolean,
    val x: IntRange,
    val y: IntRange,
    val z: IntRange
) {
    infix fun overlaps(o: Cube): Boolean {
        return x.last >= o.x.first && x.first <= o.x.last &&
                y.last >= o.y.first && y.first <= o.y.last &&
                z.last >= o.z.first && z.first <= o.z.last
    }

    private val IntRange.size: Int
        get() =  last - first + 1

    val multiplier: Int
        get() = if (isOn) 1 else -1

    val volume: Long
        get() = x.size.toLong() * y.size * z.size
}

typealias Instruction = Cube

fun parseInstructions(input: List<String>): List<Instruction> {
    val onList = input.map { it.split(' ')[0] }
    val numbers = input.map { line ->
        line
            .split(' ')[1]
            .replace(Regex("[^-0-9]"), " ")
            .replace("\\s+".toRegex(), " ")
            .trim()
            .split(' ')
            .map { it.toInt() }
    }
    return buildList {
        onList.zip(numbers).forEach {
            add(
                Instruction(
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
    instructions.forEach { instruction ->
        for (x in maxOf(instruction.x.first, -50)..minOf(instruction.x.last, 50)) {
            for (y in maxOf(instruction.y.first, -50)..minOf(instruction.y.last, 50)) {
                for (z in maxOf(instruction.z.first, -50)..minOf(instruction.z.last, 50)) {
                    if (instruction.isOn) {
                        activeCubes.add(MiniCube(x, y, z))
                    } else {
                        activeCubes.remove(MiniCube(x, y, z))
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
    instructions.forEach { instruction ->
        val overlaps = mutableListOf<Cube>()
        reactorState.forEach { cube ->
            // Always cut overlaps from reactor state. When cutting from "on" cube an "off" cube is added.
            // Thanks to this the next time when there would be a cut from the same region two overlaps would be added
            // one positive and one negative effectively negating each other. Always cutting also ensures that
            // when two positive cubes overlap the overlap cube is added as a negative cube. (Kind of like Vien Diagram
            // where you have to subtract the shared values)
            if (instruction overlaps cube) {
                overlaps.add(
                    Cube(
                        !cube.isOn,
                        maxOf(instruction.x.first, cube.x.first)..minOf(instruction.x.last, cube.x.last),
                        maxOf(instruction.y.first, cube.y.first)..minOf(instruction.y.last, cube.y.last),
                        maxOf(instruction.z.first, cube.z.first)..minOf(instruction.z.last, cube.z.last)
                    )
                )
            }
        }
        reactorState.addAll(overlaps)
        if (instruction.isOn) reactorState.add(instruction)
    }
    return reactorState.fold(0L) { acc: Long, cube: Cube ->
        acc + cube.multiplier * cube.volume
    }
}

fun main() {
    val testInput = readInput("22", "input_test")
    val input = readInput("22", "input")

    check(590784, part1(testInput))
    println("Part 1: " + part1(input)) // 589411

    check(39769202357779L, part2(testInput))
    println("Part 2: " + part2(input)) // 1130514303649907
}
