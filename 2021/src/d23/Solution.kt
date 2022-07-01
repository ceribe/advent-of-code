package d23

import check
import readInput
import kotlin.math.absoluteValue
import kotlin.math.max
import kotlin.math.min


/**
 * Returns cost of moving one step for [this]
 */
fun Char.cost() = when (this) {
    'A' -> 1
    'B' -> 10
    'C' -> 100
    'D' -> 1000
    else -> 0
}

/**
 * Returns position in hallway of room which id = [this]
 */
fun Int.getRoomPos() = when (this) {
    0 -> 2
    1 -> 4
    2 -> 6
    3 -> 8
    else -> throw Exception("Illegal room id")
}

/**
 * Returns true if amphipod can move through [hallway] from [startPos] to [endPos]
 * When used for amphipod which is already in the [hallway] [skip] should be set to the value of this amphipod
 */
fun canMove(hallway: MutableList<Char>, startPos: Int, endPos: Int, skip: Char = 'E'): Boolean {
    var sublist: List<Char> = hallway.subList(min(startPos, endPos), max(startPos, endPos) + 1)
    if (sublist.first() == skip)
        sublist = sublist.drop(1)
    else if (sublist.last() == skip)
        sublist = sublist.dropLast(1)
    return startPos != endPos && sublist.all { it == '.' }
}

fun part1(input: List<String>): Int {
    data class Room(var topAmphipod: Char, var bottomAmphipod: Char) {
        /**
         * Removes [amphipod] nearest to hallway from this room.
         */
        fun moveOut(amphipod: Char) {
            if (topAmphipod == amphipod)
                topAmphipod = '.'
            else
                bottomAmphipod = '.'
        }

        /**
         * If all amphipods in this room should not move out function returns true
         */
        fun shouldAllStay(c: Char): Boolean {
            return (topAmphipod == c && bottomAmphipod == c) || (topAmphipod == '.' && bottomAmphipod == c)
        }

        /**
         * Returns true if [amphipod] can move in to this room
         */
        fun canMoveIn(amphipod: Char): Boolean {
            return topAmphipod == '.' && (bottomAmphipod == '.' || bottomAmphipod == amphipod)
        }

    }

    fun List<Room>.areOrganized(): Boolean {
        return get(0).topAmphipod == 'A' && get(0).bottomAmphipod == 'A' &&
                get(1).topAmphipod == 'B' && get(1).bottomAmphipod == 'B' &&
                get(2).topAmphipod == 'C' && get(2).bottomAmphipod == 'C' &&
                get(3).topAmphipod == 'D' && get(3).bottomAmphipod == 'D'
    }

    val rooms = buildList {
        add(Room(input[2][3], input[3][3]))
        add(Room(input[2][5], input[3][5]))
        add(Room(input[2][7], input[3][7]))
        add(Room(input[2][9], input[3][9]))
    }
    val hallway = MutableList(11) { '.' }

    var globalMinEnergy = Int.MAX_VALUE

    fun makeMove(rooms: List<Room>, hallway: MutableList<Char>, energy: Int) {
        if (energy > globalMinEnergy) return
        if (rooms.areOrganized()) {
            if (globalMinEnergy > energy)
                globalMinEnergy = energy
            return
        }
        //Make all possible moves causing amphipods to leave a room
        rooms.forEachIndexed { idx, room ->
            val shouldStay = when (idx) {
                0 -> room.shouldAllStay('A')
                1 -> room.shouldAllStay('B')
                2 -> room.shouldAllStay('C')
                3 -> room.shouldAllStay('D')
                else -> false
            }
            if (shouldStay) return@forEachIndexed

            var stepsCount = 0
            var amphipod = room.topAmphipod
            if (amphipod == '.') {
                amphipod = room.bottomAmphipod
                stepsCount++
            }

            fun moveRoomToRoom(amphipodRoomId: Int): Boolean {
                if (canMove(hallway, idx.getRoomPos(), amphipodRoomId.getRoomPos()) && rooms[amphipodRoomId].canMoveIn(
                        amphipod
                    )
                ) {
                    stepsCount += (idx.getRoomPos() - amphipodRoomId.getRoomPos()).absoluteValue + 2 // +2 because of moving out of room AND moving in to room
                    val cRooms = rooms.map { it.copy() }
                    cRooms[amphipodRoomId].topAmphipod = amphipod
                    cRooms[idx].moveOut(amphipod)
                    if (cRooms[amphipodRoomId].bottomAmphipod == '.') {
                        stepsCount++
                        cRooms[amphipodRoomId].bottomAmphipod = amphipod
                        cRooms[amphipodRoomId].topAmphipod = '.'
                    }
                    makeMove(cRooms, hallway, energy + stepsCount * amphipod.cost())
                    return true
                }
                return false
            }

            fun moveRoomToHallway() {
                for (i in listOf(0, 1, 3, 5, 7, 9, 10)) {
                    if (canMove(hallway, idx.getRoomPos(), i)) {
                        val cHallway = hallway.toMutableList()
                        val cRooms = rooms.map { it.copy() }
                        cRooms[idx].moveOut(amphipod)
                        cHallway[i] = amphipod
                        makeMove(
                            cRooms,
                            cHallway,
                            energy + (stepsCount + (idx.getRoomPos() - i).absoluteValue + 1) * amphipod.cost()
                        )
                    }
                }
            }
            when (amphipod) {
                'A' -> {
                    if (moveRoomToRoom(0)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'B' -> {
                    if (moveRoomToRoom(1)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'C' -> {
                    if (moveRoomToRoom(2)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'D' -> {
                    if (moveRoomToRoom(3)) return@forEachIndexed
                    moveRoomToHallway()
                }
                else -> {}
            }
        }

        // Make all possible moves causing amphipods to move from hallway to a room
        hallway.forEachIndexed { idx, c ->
            /**
             * Moves amphipod from hallway (from position = idx) to room with id = [roomId]
             */
            fun moveHallwayToRoom(roomId: Int) {
                if (canMove(hallway, idx, roomId.getRoomPos(), c) && rooms[roomId].canMoveIn(c)) {
                    val cHallway = hallway.toMutableList()
                    val cRooms = rooms.map { it.copy() }
                    var stepsCount = (idx - roomId.getRoomPos()).absoluteValue + 1
                    cHallway[idx] = '.'
                    cRooms[roomId].topAmphipod = c
                    if (cRooms[roomId].bottomAmphipod == '.') {
                        stepsCount++
                        cRooms[roomId].bottomAmphipod = c
                        cRooms[roomId].topAmphipod = '.'
                    }
                    makeMove(cRooms, cHallway, energy + stepsCount * c.cost())
                }
            }
            when (c) {
                'A' -> moveHallwayToRoom(0)
                'B' -> moveHallwayToRoom(1)
                'C' -> moveHallwayToRoom(2)
                'D' -> moveHallwayToRoom(3)
            }
        }
    }
    makeMove(rooms, hallway, 0)
    return globalMinEnergy
}

fun part2(input: List<String>): Int {
    data class Room(var a1: Char, var a2: Char, var a3: Char, var a4: Char) {
        /**
         * Removes [amphipod] nearest to hallway from this room.
         */
        fun moveOut(amphipod: Char) {
            if (a1 == amphipod)
                a1 = '.'
            else if (a2 == amphipod)
                a2 = '.'
            else if (a3 == amphipod)
                a3 = '.'
            else
                a4 = '.'
        }

        /**
         * If all amphipods in this room should not move out function returns true
         */
        fun shouldAllStay(c: Char): Boolean {
            val acceptable = listOf('.', c)
            return a1 in acceptable && a2 in acceptable && a3 in acceptable && a4 in acceptable
        }

        /**
         * Returns true if [amphipod] can move in to this room
         */
        fun canMoveIn(amphipod: Char): Boolean {
            return shouldAllStay(amphipod)
        }

    }

    fun List<Room>.areOrganized(): Boolean {
        return get(0).a1 == 'A' && get(0).a2 == 'A' && get(0).a3 == 'A' && get(0).a4 == 'A' &&
                get(1).a1 == 'B' && get(1).a2 == 'B' && get(1).a3 == 'B' && get(1).a4 == 'B' &&
                get(2).a1 == 'C' && get(2).a2 == 'C' && get(2).a3 == 'C' && get(2).a4 == 'C' &&
                get(3).a1 == 'D' && get(3).a2 == 'D' && get(3).a3 == 'D' && get(3).a4 == 'D'

    }

    val rooms = buildList {
        add(Room(input[2][3], 'D', 'D', input[3][3]))
        add(Room(input[2][5], 'C', 'B', input[3][5]))
        add(Room(input[2][7], 'B', 'A', input[3][7]))
        add(Room(input[2][9], 'A', 'C', input[3][9]))
    }
    val hallway = MutableList(11) { '.' }

    var globalMinEnergy = Int.MAX_VALUE

    fun makeMove(rooms: List<Room>, hallway: MutableList<Char>, energy: Int) {
        if (energy > globalMinEnergy) return
        if (rooms.areOrganized()) {
            if (globalMinEnergy > energy)
                globalMinEnergy = energy
            return
        }
        // Make all possible moves causing amphipods to leave a room
        rooms.forEachIndexed { idx, room ->
            val shouldStay = when (idx) {
                0 -> room.shouldAllStay('A')
                1 -> room.shouldAllStay('B')
                2 -> room.shouldAllStay('C')
                3 -> room.shouldAllStay('D')
                else -> false
            }
            if (shouldStay) return@forEachIndexed

            var stepsCount = 0
            var amphipod = room.a1
            if (amphipod == '.') {
                amphipod = room.a2
                stepsCount++
            }
            if (amphipod == '.') {
                amphipod = room.a3
                stepsCount++
            }
            if (amphipod == '.') {
                amphipod = room.a4
                stepsCount++
            }

            fun moveRoomToRoom(amphipodRoomId: Int): Boolean {
                if (canMove(hallway, idx.getRoomPos(), amphipodRoomId.getRoomPos()) && rooms[amphipodRoomId].canMoveIn(
                        amphipod
                    )
                ) {
                    stepsCount += (idx.getRoomPos() - amphipodRoomId.getRoomPos()).absoluteValue + 2 //+2 because of moving out of room AND moving in to room
                    val cRooms = rooms.map { it.copy() }
                    cRooms[amphipodRoomId].a1 = amphipod
                    cRooms[idx].moveOut(amphipod)
                    if (cRooms[amphipodRoomId].a2 == '.') {
                        stepsCount++
                        cRooms[amphipodRoomId].a2 = amphipod
                        cRooms[amphipodRoomId].a1 = '.'
                    }
                    if (cRooms[amphipodRoomId].a3 == '.') {
                        stepsCount++
                        cRooms[amphipodRoomId].a3 = amphipod
                        cRooms[amphipodRoomId].a2 = '.'
                    }
                    if (cRooms[amphipodRoomId].a4 == '.') {
                        stepsCount++
                        cRooms[amphipodRoomId].a4 = amphipod
                        cRooms[amphipodRoomId].a3 = '.'
                    }
                    makeMove(cRooms, hallway, energy + stepsCount * amphipod.cost())
                    return true
                }
                return false
            }

            fun moveRoomToHallway() {
                for (i in listOf(0, 1, 3, 5, 7, 9, 10)) {
                    if (canMove(hallway, idx.getRoomPos(), i)) {
                        val cHallway = hallway.toMutableList()
                        val cRooms = rooms.map { it.copy() }
                        cRooms[idx].moveOut(amphipod)
                        cHallway[i] = amphipod
                        makeMove(
                            cRooms,
                            cHallway,
                            energy + (stepsCount + (idx.getRoomPos() - i).absoluteValue + 1) * amphipod.cost()
                        )
                    }
                }
            }
            when (amphipod) {
                'A' -> {
                    if (moveRoomToRoom(0)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'B' -> {
                    if (moveRoomToRoom(1)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'C' -> {
                    if (moveRoomToRoom(2)) return@forEachIndexed
                    moveRoomToHallway()
                }
                'D' -> {
                    if (moveRoomToRoom(3)) return@forEachIndexed
                    moveRoomToHallway()
                }
                else -> {}
            }
        }

        // Make all possible moves causing amphipods to move from hallway to a room
        hallway.forEachIndexed { idx, amphipod ->
            /**
             * Moves amphipod from hallway (from position = idx) to room with id = [roomId]
             */
            fun moveHallwayToRoom(roomId: Int) {
                if (canMove(hallway, idx, roomId.getRoomPos(), amphipod) && rooms[roomId].canMoveIn(amphipod)) {
                    val cHallway = hallway.toMutableList()
                    val cRooms = rooms.map { it.copy() }
                    var stepsCount = (idx - roomId.getRoomPos()).absoluteValue + 1
                    cHallway[idx] = '.'
                    cRooms[roomId].a1 = amphipod
                    if (cRooms[roomId].a2 == '.') {
                        stepsCount++
                        cRooms[roomId].a2 = amphipod
                        cRooms[roomId].a1 = '.'
                    }
                    if (cRooms[roomId].a3 == '.') {
                        stepsCount++
                        cRooms[roomId].a3 = amphipod
                        cRooms[roomId].a2 = '.'
                    }
                    if (cRooms[roomId].a4 == '.') {
                        stepsCount++
                        cRooms[roomId].a4 = amphipod
                        cRooms[roomId].a3 = '.'
                    }
                    makeMove(cRooms, cHallway, energy + stepsCount * amphipod.cost())
                }
            }
            when (amphipod) {
                'A' -> moveHallwayToRoom(0)
                'B' -> moveHallwayToRoom(1)
                'C' -> moveHallwayToRoom(2)
                'D' -> moveHallwayToRoom(3)
            }
        }
    }
    makeMove(rooms, hallway, 0)
    return globalMinEnergy
}

fun main() {
    val testInput = readInput("23", "input_test")
    val input = readInput("23", "input")
    check(12521, part1(testInput))
    println(part1(input))

    check(44169, part2(testInput))
    println(part2(input))
}