import Util
import Foundation

func isValidForFirstPolicy(minOccurence: Int, maxOccurence: Int, letter: Character, password: String) -> Bool {
    return minOccurence...maxOccurence ~= password.filter { $0 == letter }.count
}

func isValidForSecondPolicy(minOccurence: Int, maxOccurence: Int, letter: Character, password: String) -> Bool {
    return (password[minOccurence - 1] == letter) != (password[maxOccurence - 1] == letter)
}

func part1and2(input: [String], isValid: (Int, Int, Character, String) -> Bool) -> Int {
    var validPasswordsCount = 0
    for line in input {
        let line = line.replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "-", with: " ")
        let words = line.components(separatedBy: " ")
        let minOccurence = Int(words[0])!
        let maxOccurence = Int(words[1])!
        let letter = words[2].first!
        let password = words[3]
        if isValid(minOccurence, maxOccurence, letter, password) {
            validPasswordsCount += 1
        }
    }
    return validPasswordsCount
}

let testInput = Util.readInput(day: "02", filename: "input_test.txt")
let input = Util.readInput(day: "02", filename: "input.txt")

Util.check(expected: 2, actual: part1and2(input: testInput, isValid: isValidForFirstPolicy))
print(part1and2(input: input, isValid: isValidForFirstPolicy)) // 493

Util.check(expected: 1, actual: part1and2(input: testInput, isValid: isValidForSecondPolicy))
print(part1and2(input: input, isValid: isValidForSecondPolicy)) // 593