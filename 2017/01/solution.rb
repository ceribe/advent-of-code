require_relative "../utils"
include Utils

def part1(input)
  (input.chars + [input[0]])
    .each_cons(2)
    .to_a
    .select { |a, b| a == b }
    .map { |a| a.first.to_i }
    .reduce(:+)
end

def part2(input)
  (0..input.length)
    .select { |i| input[i] == input[(i + input.length / 2) % input.length] }
    .map { |i| input[i].to_i }
    .reduce(:+)
end

input = read_input("input")
test_input_1 = "91212129"
test_input_2 = "12131415"

check(9, part1(test_input_1))
puts "Part 1: #{part1(input[0])}"

check(4, part2(test_input_2))
puts "Part 2: #{part2(input[0])}"
