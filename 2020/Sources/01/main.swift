import Util

func part1(input: [String]) -> Int {
    let numbers = input.map { Int($0)! }
    var seenNumbers = Set<Int>()
    for number in numbers {
        if seenNumbers.contains(2020 - number) {
            return number * (2020 - number)
        }
        seenNumbers.insert(number)
    }
    return -1
}

func part2(input: [String]) -> Int {
    let numbers = input.map { Int($0)! }
    for i in 0..<numbers.count {
        for j in i+1..<numbers.count {
            for k in j+1..<numbers.count {
                let a = numbers[i]
                let b = numbers[j]
                let c = numbers[k]
                if a + b + c == 2020 {
                    return a * b * c
                }
            }
        }
    }
    return -1
}

let testInput = Util.readInput(day: "01", filename: "input_test.txt")
let input = Util.readInput(day: "01", filename: "input.txt")

Util.check(expected: 514579, actual: part1(input: testInput))
print(part1(input: input)) // 290784

Util.check(expected: 241861950, actual: part2(input: testInput))
print(part2(input: input)) // 290784
