import kotlin.math.absoluteValue

fun main() {

    data class Direction(val first: Int, val second: Int, val third: Int, val rotX: Int, val rotY: Int, val rotZ: Int)
    data class Beacon(var x: Int, var y: Int, var z: Int)
    data class Scanner(var x: Int, var y: Int, var z: Int, var beacons: List<Beacon>)

    //Don't judge me
    val directions = listOf(
        Direction(0,1,2,1,1,1),
        Direction(0,2,1,1,1,-1),
        Direction(0,1,2,1,-1,-1),
        Direction(0,2,1,1,-1,1),
        Direction(0,1,2,-1,1,-1),
        Direction(0,2,1,-1,1,1),
        Direction(0,1,2,-1,-1,1),
        Direction(0,2,1,-1,-1,-1),
        Direction(1,0,2,1,1,-1),
        Direction(1,2,0,1,-1,-1),
        Direction(1,0,2,1,-1,1),
        Direction(1,2,0,1,1,1),
        Direction(1,0,2,-1,1,1),
        Direction(1,2,0,-1,1,-1),
        Direction(1,0,2,-1,-1,-1),
        Direction(1,2,0,-1,-1,1),
        Direction(2,1,0,1,1,-1),
        Direction(2,0,1,1,-1,-1),
        Direction(2,1,0,1,-1,1),
        Direction(2,0,1,1,1,1),
        Direction(2,1,0,-1,1,1),
        Direction(2,0,1,-1,1,-1),
        Direction(2,1,0,-1,-1,-1),
        Direction(2,0,1,-1,-1,1),
    )

    fun createScannerMap(input: List<String>): MutableList<Scanner> {
        val scanners = buildList {
            var beacons = mutableListOf<Beacon>()
            //Parse all beacons belonging to a scanner
            for(it in input) {
                if(it.contains("---")) {
                    continue
                }
                if(it == "") {
                    add(Scanner(0,0,0, beacons))
                    beacons = mutableListOf()
                    continue
                }
                val (x,y,z) = it.split(",").map { it.toInt() }
                beacons.add(Beacon(x,y,z))
            }
            add(Scanner(0,0,0, beacons))
        }
        val placedScanners = scanners.take(1).toMutableList()
        val unplacedScanners = scanners.drop(1).toMutableList()
        // Loops go brrrrrr
        mainLoop@ while (unplacedScanners.isNotEmpty()) {
            for (dir in directions) {
                for (uScanner in unplacedScanners) {
                    for (pScanner in placedScanners) {
                        val matchMap = buildMap<String, Int> {
                            for (b1 in uScanner.beacons) {
                                for (b2 in pScanner.beacons) {
                                    val match = listOf(
                                        b2.x - (if(dir.first == 0) b1.x else if(dir.first == 1) b1.y else b1.z) * dir.rotX,
                                        b2.y - (if(dir.second == 0) b1.x else if(dir.second == 1) b1.y else b1.z) * dir.rotY,
                                        b2.z - (if(dir.third == 0) b1.x else if(dir.third == 1) b1.y else b1.z) * dir.rotZ
                                    )
                                    val stringifiedMatch = match.toString()
                                    put(stringifiedMatch, getOrDefault(stringifiedMatch, 0) + 1)
                                }
                            }
                        }
                        val filteredMatchMap = matchMap.filter { it.value >= 12 }
                        if (filteredMatchMap.isNotEmpty()) {
                            // Get first (and only) key from map and extract x,y,z from it
                            val (x,y,z) = filteredMatchMap
                                .entries
                                .iterator()
                                .next()
                                .key
                                .removePrefix("[")
                                .removeSuffix("]")
                                .split(", ")
                                .map { it.toInt() }
                            uScanner.x = pScanner.x + x
                            uScanner.y = pScanner.y + y
                            uScanner.z = pScanner.z + z
                            unplacedScanners.remove(uScanner)
                            placedScanners.add(uScanner)
                            // Transform all beacons to normalize them so direction does not need to be saved
                            uScanner.beacons = uScanner.beacons.map {
                                Beacon(
                                    (if (dir.first == 0) it.x else if (dir.first == 1) it.y else it.z) * dir.rotX,
                                    (if (dir.second == 0) it.x else if (dir.second == 1) it.y else it.z) * dir.rotY,
                                    (if (dir.third == 0) it.x else if (dir.third == 1) it.y else it.z) * dir.rotZ
                                )
                            }
                            continue@mainLoop
                        }
                    }
                }
            }
        }
        return placedScanners
    }

    fun part1(input: List<String>): Int {
        val scanners = createScannerMap(input)
        val beaconMap = buildMap<String, Int> {
            scanners.forEach { scanner ->
                scanner.beacons.forEach { beacon ->
                    put("${beacon.x + scanner.x},${beacon.y + scanner.y},${beacon.z + scanner.z}", 1)
                }
            }
        }
        return beaconMap.size
    }

    fun part2(input: List<String>): Int {
        var max = 0
        val map = createScannerMap(input)
        map.forEach { i ->
            map.forEach { j ->
                val dist = (i.x - j.x).absoluteValue + (i.y - j.y).absoluteValue + (i.z - j.z).absoluteValue
                max = kotlin.math.max(max, dist)
            }
        }
        return max
    }

    val testInput = readInput("Day19_test")
    check(part1(testInput) == 79)
    check(part2(testInput) == 3621)

    val input = readInput("Day19")
    println(part1(input))
    println(part2(input))
}