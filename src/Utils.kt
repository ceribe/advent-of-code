import java.io.File
import java.math.BigInteger
import java.security.MessageDigest

/**
 * Reads lines from the given input txt file.
 */
fun readInput(name: String) = File("src", "$name.txt").readLines()

/**
 * Converts string to md5 hash.
 */
fun String.md5(): String = BigInteger(1, MessageDigest.getInstance("MD5").digest(toByteArray())).toString(16)

/**
 * Creates a universal range
 */
infix fun Int.toward(to: Int): IntProgression {
    val step = if (this > to) -1 else 1
    return IntProgression.fromClosedRange(this, to, step)
}

/**
 * Creates empty files for given day
 */
fun main() {
    val day = "07"
    val path = "src"
    File("$path\\Day$day.txt").createNewFile()
    File("$path\\Day${day}_test.txt").createNewFile()
    val file = File("$path\\Day$day.kt")
    file.writeText(
        "fun main() {\n" +
                "    fun part1(input: List<String>): Int {\n" +
                "        TODO()\n" +
                "    }\n" +
                "\n" +
                "    fun part2(input: List<String>): Int {\n" +
                "        TODO()\n" +
                "    }\n" +
                "\n" +
                "    val testInput = readInput(\"Day${day}_test\")\n" +
                "    check(part1(testInput) == 7)\n" +
                "    //check(part2(testInput) == 5)\n" +
                "\n" +
                "    val input = readInput(\"Day$day\")\n" +
                "    println(part1(input))\n" +
                "    println(part2(input))\n" +
                "}"
    )
}