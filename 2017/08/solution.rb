require_relative "../utils"
include Utils

def part1(input)
  registers = {}
  registers.default = 0
  input.each do |line|
    register, op, value, _, cond_register, cond, cond_value = line.split
    if eval("#{registers[cond_register]} #{cond} #{cond_value}")
      sign = 1
      if op == "dec"
        sign = -1
      end
      registers[register] += value.to_i * sign
    end
  end
  registers.values.max
end

def part2(input)
  registers = {}
  registers.default = 0
  max_value = 0
  input.each do |line|
    register, op, value, _, cond_register, cond, cond_value = line.split
    if eval("#{registers[cond_register]} #{cond} #{cond_value}")
      sign = 1
      if op == "dec"
        sign = -1
      end
      registers[register] += value.to_i * sign
      max_value = [registers.values.max, max_value].max
    end
  end
  max_value
end

input = read_input("input")
test_input = read_input("test_input")

check(1, part1(test_input))
puts "Part 1: #{part1(input)}"

check(10, part2(test_input))
puts "Part 2: #{part2(input)}"