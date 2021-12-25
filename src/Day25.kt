/**
 * Helper function to check if two matrices of Chars are the same.
 * There is most likely a better way to do this.
 */
infix fun List<List<Char>>.isTheSameAs(o: List<List<Char>>): Boolean {
    for(y in o.indices) {
        for(x in o[0].indices) {
            if(get(y)[x] != o[y][x])
                return false
        }
    }
    return true
}


fun main() {
    fun part1(input: List<String>): Int {
        var cucumbers = input.map { it.toList() }
        val width = cucumbers[0].size
        val height = cucumbers.size
        fun getNextX(x: Int) = if(x+1 < width) x+1 else 0
        fun getNextY(y: Int) = if(y+1 < height) y+1 else 0

        var stepsCount = 1
        while(true) {
            //Deep copy cucumbers matrix
            //To simulate cucumbers moving all at once constrains need to be checked on unchanged matrix
            val intermediateCucumbers = cucumbers.map { it.toMutableList() }

            //Move right
            for (y in cucumbers.indices) {
                for (x in cucumbers[0].indices) {
                    if(cucumbers[y][x] == '>') {
                        if (cucumbers[y][getNextX(x)] == '.') {
                            intermediateCucumbers[y][x] = '.'
                            intermediateCucumbers[y][getNextX(x)] = '>'
                        }
                    }
                }
            }

            //Deep copy cucumbers matrix
            //To simulate cucumbers moving all at once constrains need to be checked on unchanged matrix
            val newCucumbers = intermediateCucumbers.map { it.toMutableList() }
            
            //Mode down
            for (y in cucumbers.indices) {
                for (x in cucumbers[0].indices) {
                    if(intermediateCucumbers[y][x] == 'v') {
                        if (intermediateCucumbers[getNextY(y)][x] == '.') {
                            newCucumbers[y][x] = '.'
                            newCucumbers[getNextY(y)][x] = 'v'
                        }
                    }
                }
            }

            //If matrices are the same then cucumbers stopped moving
            if (cucumbers isTheSameAs newCucumbers) {
                return stepsCount
            }
            cucumbers = newCucumbers
            stepsCount++
        }
    }

    val testInput = readInput("Day25_test")
    check(part1(testInput) == 58)

    val input = readInput("Day25")
    println(part1(input))
}