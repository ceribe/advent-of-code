fun main() {

    data class Packet(val version: Int, val type: Int, val packets: List<Packet>, val value: Long, val length: Int)

    fun String.toBitList(): List<Int> {
        return map { it.digitToInt(radix = 16) }.flatMap {
            listOf(it and 8, it and 4, it and 2, it and 1).map { it2 -> if(it2 != 0) 1 else 0 }
        }
    }

    fun List<Int>.toLong() = joinToString("").toLong(2)

    fun createPacketFromBits(bits: List<Int>): Packet {
        val version = bits.take(3).toLong().toInt()
        val typeID = bits.drop(3).take(3).toLong().toInt()
        if(typeID == 4) {
            val contentBits = bits.drop(6).toMutableList()
            var hasNextGroup = true
            var len = 0
            val accumulatedBits = buildList {
                while (hasNextGroup) {
                    hasNextGroup = contentBits.removeFirst() == 1
                    repeat(4) {
                        add(contentBits.removeFirst())
                    }
                    len += 5
                }
            }
            return Packet(version, typeID, listOf(), accumulatedBits.toLong(), 3+3+len)
        }
        else {
            val lengthTypeID = bits.drop(6).first()
            if(lengthTypeID == 0) {
                val totalLength = bits.drop(7).take(15).toLong().toInt()
                var contentBits = bits.drop(7).drop(15).take(totalLength)
                var currentLength = 0
                val subPackets = buildList {
                    while (currentLength < totalLength) {
                        val packet = createPacketFromBits(contentBits)
                        contentBits = contentBits.drop(packet.length)
                        add(packet)
                        currentLength += packet.length
                    }
                }
                return Packet(version, typeID, subPackets, 0, 3+3+1+15+totalLength)
            }
            else {
                val numberOfSubPackets = bits.drop(7).take(11).toLong()
                var contentBits = bits.drop(7).drop(11)
                var currentCount = 0
                val subPackets = buildList<Packet> {
                    while (currentCount < numberOfSubPackets) {
                        val packet = createPacketFromBits(contentBits)
                        contentBits = contentBits.drop(packet.length)
                        add(packet)
                        currentCount++
                    }
                }
                return Packet(version, typeID, subPackets, 0, 3+3+1+11+subPackets.sumOf { it.length })
            }
        }
    }

    fun getSumOfVersionNumbers(packet: Packet): Int {
        var sum = 0
        fun addToSum(packet: Packet) {
            sum += packet.version
            packet.packets.forEach{
                addToSum(it)
            }
        }
        addToSum(packet)
        return sum
    }

    fun part1(input: List<String>): Int {
        val bits = input[0].toBitList()
        val packet = createPacketFromBits(bits)
        return getSumOfVersionNumbers(packet)
    }

    fun decodePacket(packet: Packet): Long {
        with(packet.packets) {
            return when (packet.type) {
                0 -> sumOf { decodePacket(it) }
                1 -> fold(1L) { acc, subpacket -> decodePacket(subpacket) * acc }
                2 -> minOf { decodePacket(it) }
                3 -> maxOf { decodePacket(it) }
                5 -> if (decodePacket(get(0)) > decodePacket(get(1))) 1 else 0
                6 -> if (decodePacket(get(0)) < decodePacket(get(1))) 1 else 0
                7 -> if (decodePacket(get(0)) == decodePacket(get(1))) 1 else 0
                else -> packet.value
            }
        }
    }

    fun part2(input: List<String>): Long {
        val bits = input[0].toBitList()
        val packet = createPacketFromBits(bits)
        return decodePacket(packet)
    }

    val testInput = readInput("Day16_test")
    check(part1(testInput) == 31)
    check(part2(testInput) == 54L)

    val input = readInput("Day16")
    println(part1(input))
    println(part2(input))
}