require_relative "../utils"
include Utils

def get_layers(input)
    layers = {}
    input.each do |line|
        depth, range = line.split(": ").map(&:to_i)
        layers[depth] = range
    end
    layers
end

def part1(input)
    get_layers(input)
        .map { |depth, range| depth * range if depth % ((range - 1) * 2) == 0 }
        .compact
        .sum
end

def part2(input)
    layers = get_layers(input)
    delay = 0
    while true
        break if layers.none? { |depth, range| (depth + delay) % ((range - 1) * 2) == 0 }
        delay += 1
    end
    delay
end

input = read_input("input")
test_input = read_input("test_input")

check(24, part1(test_input))
puts "Part 1: #{part1(input)}"

check(10, part2(test_input))
puts "Part 2: #{part2(input)}"