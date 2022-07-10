import Util
import Foundation

func part1(input: [String]) -> Int {
    var validPasswordsCount = 0
    for line in input {
        let line = line.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "-", with: " ")
        let words = line.components(separatedBy: " ")
        let minOccurence = Int(words[0])!
        let maxOccurence = Int(words[1])!
        let letter = words[2].first!
        let password = words[3]
        let isValid = minOccurence...maxOccurence ~= password.filter { $0 == letter }.count
        if isValid {
            validPasswordsCount += 1
        }
    }
    return validPasswordsCount
}

func part2(input: [String]) -> Int {
    var validPasswordsCount = 0
    for line in input {
        let line = line.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "-", with: " ")
        let words = line.components(separatedBy: " ")
        let minOccurence = Int(words[0])!
        let maxOccurence = Int(words[1])!
        let letter = words[2].first!
        let password = words[3]
        let isValid = (password[minOccurence - 1] == letter) != (password[maxOccurence - 1] == letter)
        if isValid {
            validPasswordsCount += 1
        }
    }
    return validPasswordsCount
}

let testInput = Util.readInput(day: "02", filename: "input_test.txt")
let input = Util.readInput(day: "02", filename: "input.txt")

Util.check(expected: 2, actual: part1(input: testInput))
print(part1(input: input))

Util.check(expected: 1, actual: part2(input: testInput))
print(part2(input: input))