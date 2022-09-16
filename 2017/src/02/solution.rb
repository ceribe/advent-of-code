require_relative "../utils"
include Utils

def part1(input)
  input
    .map { |a| a.split.map(&:to_i).sort }
    .map { |a| a[-1] - a[0] }
    .reduce(:+)
end

def part2(input)
  input
    .map { |row|
      row
        .split
        .map(&:to_i)
        .sort
        .combination(2)
        .find { |smaller, bigger| bigger % smaller == 0 }
    }
    .map { |smaller, bigger| bigger / smaller }
    .reduce(:+)
end

input = read_input("input.txt")
test_input = read_input("input_test.txt")

check(18, part1(test_input))
puts "Part 1: #{part1(input)}" # 45972

check(9, part2(test_input))
puts "Part 2: #{part2(input)}" # 326
