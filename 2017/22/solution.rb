require_relative '../utils'
include Utils
require 'set'

def part1(input, bursts_of_activity_count)
  infections_count = 0
  infected_nodes = Set.new
  # I asume that input is always a square 
  x = input.size / 2
  y = x
  dir = 0
  # Parse the input
  input.each_with_index do |line, index_y|
    line.chars.each_with_index do |char, index_x|
      infected_nodes.add([index_x, index_y]) if char == '#'
    end
  end
  bursts_of_activity_count.times do
    if infected_nodes.include?([x, y])
      dir = (dir + 1) % 4
      infected_nodes.delete([x, y])
    else
      dir = (dir - 1) % 4
      infected_nodes.add([x, y])
      infections_count += 1
    end

    # Move carrier
    case dir
    when 0
      y -= 1
    when 1
      x += 1
    when 2
      y += 1
    when 3
      x -= 1
    end
  end

  infections_count
end

def part2(input, bursts_of_activity_count) 
  infections_count = 0
  infected_nodes = {}
  infected_nodes.default = 0
  # I asume that input is always a square 
  x = input.size / 2
  y = x
  dir = 0
  # Parse the input
  input.each_with_index do |line, index_y|
    line.chars.each_with_index do |char, index_x|
      infected_nodes[[index_x, index_y]] = 2 if char == '#'
    end
  end
  bursts_of_activity_count.times do

    # Update dir according to rules
    case infected_nodes[[x, y]]
    when 0
      dir = (dir - 1) % 4
    when 1
      infections_count += 1
    when 2
      dir = (dir + 1) % 4
    when 3
      dir = (dir + 2) % 4
    end

    # Update the node
    infected_nodes[[x, y]] = (infected_nodes[[x, y]] + 1) % 4

    # Move carrier
    case dir
    when 0
      y -= 1 
    when 1
      x += 1
    when 2
      y += 1
    when 3
      x -= 1
    end
  end

  infections_count
end

input = read_input('input')
test_input = read_input('test_input')

check(41, part1(test_input, 70))
check(5587, part1(test_input, 10_000))
puts "Part 1: #{part1(input, 10_000)}"

check(26, part2(test_input, 100))
check(2_511_944, part2(test_input, 10_000_000))
puts "Part 2: #{part2(input, 10_000_000)}"
