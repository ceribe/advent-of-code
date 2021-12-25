fun main() {
    fun part1(input: List<String>): Int {
        var cucumbers = input.map { it.toList() }
        val width = cucumbers[0].size
        val height = cucumbers.size
        fun getNextX(x: Int) = if (x + 1 < width) x + 1 else 0
        fun getNextY(y: Int) = if (y + 1 < height) y + 1 else 0
        var stepsCount = 1

        while (true) {
            var moved = false

            //Deep copy cucumbers matrix
            //To simulate cucumbers moving all at once positions need to be checked on unchanged matrix
            val intermediateCucumbers = cucumbers.map { it.toMutableList() }

            //Move right
            for (y in cucumbers.indices) {
                for (x in cucumbers[0].indices) {
                    if(cucumbers[y][x] == '>') {
                        val nextX = getNextX(x)
                        if (cucumbers[y][nextX] == '.') {
                            intermediateCucumbers[y][x] = '.'
                            intermediateCucumbers[y][nextX] = '>'
                            moved = true
                        }
                    }
                }
            }

            //Deep copy cucumbers matrix
            //To simulate cucumbers moving all at once positions need to be checked on unchanged matrix
            val newCucumbers = intermediateCucumbers.map { it.toMutableList() }
            //Mode down
            for (y in cucumbers.indices) {
                for (x in cucumbers[0].indices) {
                    if (intermediateCucumbers[y][x] == 'v') {
                        val nextY = getNextY(y)
                        if (intermediateCucumbers[nextY][x] == '.') {
                            newCucumbers[y][x] = '.'
                            newCucumbers[nextY][x] = 'v'
                            moved = true
                        }
                    }
                }
            }

            if (!moved) { return stepsCount }

            cucumbers = newCucumbers
            stepsCount++
        }
    }

    val testInput = readInput("Day25_test")
    check(part1(testInput) == 58)

    val input = readInput("Day25")
    println(part1(input))
}