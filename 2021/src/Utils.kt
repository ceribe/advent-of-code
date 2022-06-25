import java.io.File

/**
 * Reads lines from the given input txt file.
 */
fun readInput(day: String, name: String = "") = File("src/d$day","$name.txt").readLines()

/**
 * Reads first line from the given input txt file.
 */
fun readFirstLine(day: String, name: String = "") = readInput(day, name).first()

/**
 * Checks if given parameters are equal. If not throws an exception.
 */
fun <T> check(expected: T, actual: T) {
    if (expected != actual) {
        throw AssertionError("Expected $expected, got $actual")
    }
}