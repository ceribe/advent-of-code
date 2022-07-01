package d16

import check
import readFirstLine

data class Packet(val version: Int, val type: Int, val packets: List<Packet>, val value: Long, val length: Int) {
    fun getSumOfVersionNumbers(): Int {
        return version + packets.sumOf { it.getSumOfVersionNumbers() }
    }

    fun decode(): Long = when (type) {
        0 -> packets.sumOf { it.decode() }
        1 -> packets.fold(1L) { acc, subpacket -> subpacket.decode() * acc }
        2 -> packets.minOf { it.decode() }
        3 -> packets.maxOf { it.decode() }
        5 -> if (packets[0].decode() > packets[1].decode()) 1 else 0
        6 -> if (packets[0].decode() < packets[1].decode()) 1 else 0
        7 -> if (packets[0].decode() == packets[1].decode()) 1 else 0
        else -> value
    }
}

fun String.toBitList(): List<Int> {
    return map { it.digitToInt(radix = 16) }.flatMap { digit ->
        listOf(digit and 8, digit and 4, digit and 2, digit and 1).map { if (it != 0) 1 else 0 }
    }
}

fun List<Int>.toLong() = joinToString("").toLong(2)

fun createPacket(input: String): Packet {
    return createPacketFromBits(input.toBitList())
}

fun createPacketFromBits(bits: List<Int>): Packet {
    val version = bits.take(3).toLong().toInt()
    val typeID = bits.drop(3).take(3).toLong().toInt()
    if (typeID == 4) {
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
        return Packet(version, typeID, listOf(), accumulatedBits.toLong(), 3 + 3 + len)
    } else {
        val lengthTypeID = bits.drop(6).first()
        if (lengthTypeID == 0) {
            val totalLength = bits.drop(7).take(15).toLong().toInt()
            var contentBits = bits.drop(7 + 15).take(totalLength)
            var currentLength = 0
            val subPackets = buildList {
                while (currentLength < totalLength) {
                    val packet = createPacketFromBits(contentBits)
                    contentBits = contentBits.drop(packet.length)
                    add(packet)
                    currentLength += packet.length
                }
            }
            return Packet(version, typeID, subPackets, 0, 3 + 3 + 1 + 15 + totalLength)
        } else {
            val numberOfSubPackets = bits.drop(7).take(11).toLong()
            var contentBits = bits.drop(7 + 11)
            var currentCount = 0
            val subPackets = buildList {
                while (currentCount < numberOfSubPackets) {
                    val packet = createPacketFromBits(contentBits)
                    contentBits = contentBits.drop(packet.length)
                    add(packet)
                    currentCount++
                }
            }
            return Packet(version, typeID, subPackets, 0, 3 + 3 + 1 + 11 + subPackets.sumOf { it.length })
        }
    }
}

fun part1(input: String): Int {
    val packet = createPacket(input)
    return packet.getSumOfVersionNumbers()
}

fun part2(input: String): Long {
    val packet = createPacket(input)
    return packet.decode()
}

fun main() {
    val input = readFirstLine("16", "input")

    check(16, part1("8A004A801A8002F478"))
    check(12, part1("620080001611562C8802118E34"))
    check(23, part1("C0015000016115A2E0802F182340"))
    check(31, part1("A0016C880162017C3686B18A3D4780"))
    println("Part 1: " + part1(input)) // 895

    check(3, part2("C200B40A82"))
    check(54, part2("04005AC33890"))
    check(7, part2("880086C3E88112"))
    check(9, part2("CE00C43D881120"))
    check(1, part2("D8005AC2A8F0"))
    check(0, part2("F600BC2D8F"))
    check(0, part2("9C005AC2F8F0"))
    check(1, part2("9C0141080250320F1802104A08"))
    println("Part 2: " + part2(input)) // 1148595959144
}
