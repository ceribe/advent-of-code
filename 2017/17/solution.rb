require_relative '../utils'
include Utils
require 'set'

def part1(input)
  buffer = [0]
  position = 0
  2017.times do |i|
    position = (position + input) % buffer.length + 1
    buffer = buffer.insert(position, i + 1)
  end
  buffer[buffer.index(2017) + 1]
end

def part2(input)
  position = 0
  buffer_size = 1
  value_at_pos_1 = -1
  50_000_000.times do |i|
    position = (position + input) % buffer_size + 1
    value_at_pos_1 = i + 1 if position == 1
    buffer_size += 1
  end
  value_at_pos_1
end

input = 349
test_input = 3

check(638, part1(test_input))
puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"
