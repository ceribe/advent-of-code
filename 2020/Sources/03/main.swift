import Util

func calculateNumberOfTrees(input: [String], dx: Int, dy: Int) -> Int {
    let width = input[0].count
    let height = input.count
    var y = 0
    var x = 0
    var count = 0
    while y < height {
        if input[y][x] == "#" {
            count += 1
        }
        y += dy
        x = (x + dx) % width
    }
    return count
}

func part1(input: [String]) -> Int {
    return calculateNumberOfTrees(input: input, dx: 3, dy: 1)
}

func part2(input: [String]) -> Int {
    var result = 1
    for i in stride(from: 1, to: 8, by: 2) {
        result *= calculateNumberOfTrees(input: input, dx: i, dy: 1)
    }
    result *= calculateNumberOfTrees(input: input, dx: 1, dy: 2)
    return result
}

let testInput = Util.readInput(day: "03", filename: "input_test.txt")
let input = Util.readInput(day: "03", filename: "input.txt")

Util.check(expected: 7, actual: part1(input: testInput))
print(part1(input: input)) // 187

Util.check(expected: 336, actual: part2(input: testInput))
print(part2(input: input)) // 4723283400