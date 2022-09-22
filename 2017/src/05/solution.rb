require_relative "../utils"
include Utils

def part1(input)
  pos = 0
  steps_count = 0
  instructions = input.map(&:to_i)
  while pos >= 0 && pos < instructions.length
    instructions[pos] += 1
    pos += instructions[pos] - 1
    steps_count += 1
  end
  steps_count
end

def part2(input)
  pos = 0
  steps_count = 0
  instructions = input.map(&:to_i)
  while pos >= 0 && pos < instructions.length
    offset = instructions[pos]
    if offset >= 3
      instructions[pos] -= 1
    else
      instructions[pos] += 1
    end
    pos += offset
    steps_count += 1
  end
  steps_count
end

input = read_input("input.txt")
test_input = read_input("input_test.txt")

check(5, part1(test_input))
puts "Part 1: #{part1(input)}" # 325922

check(10, part2(test_input))
puts "Part 2: #{part2(input)}" # 24490906