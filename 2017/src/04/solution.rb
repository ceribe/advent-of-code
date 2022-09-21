require_relative "../utils"
include Utils

def part1(input)
  input
    .map { |passphrase| passphrase.split.length == passphrase.split.uniq.length ? 1 : 0 }.reduce(:+)
end

def part2(input)
  input
    .map { |passphrase| passphrase.split.length == passphrase.split.map { |word| word.chars.sort.join }.uniq.length ? 1 : 0 }.reduce(:+)
end

input = read_input("input.txt")
test_input_1 = read_input("input_test_1.txt")
test_input_2 = read_input("input_test_2.txt")

check(2, part1(test_input_1))
puts "Part 1: #{part1(input)}" # 325

check(3, part2(test_input_2))
puts "Part 2: #{part2(input)}" # 119