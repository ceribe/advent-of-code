import java.io.File

/**
 * Reads lines from the given input txt file.
 */
fun readInput(name: String) = File("inputs", "$name.txt").readLines()

/**
 * Sorts the string alphabetically
 */
fun String.sort() = String(toCharArray().apply { sort() })