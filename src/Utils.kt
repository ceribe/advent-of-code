import java.io.File

/**
 * Reads lines from the given input txt file.
 */
fun readInput(name: String) = File("inputs", "$name.txt").readLines()

/**
 * Creates a universal range
 *
 * 5 towards 2 => 5, 4, 3, 2
 */
infix fun Int.toward(to: Int): IntProgression {
    val step = if (this > to) -1 else 1
    return IntProgression.fromClosedRange(this, to, step)
}

/**
 * Sorts the string alphabetically
 */
fun String.sort() = String(toCharArray().apply { sort() })