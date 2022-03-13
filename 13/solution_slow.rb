require_relative "../utils"
include Utils

# This solution is unnecessarily complicated because I expected part 2 to be different than it is.
# I left this solution only because I spend quite a lot of time writing it. For proper solution look at "solution.rb"

class Layer
    attr_reader :position, :depth
    
    def initialize(line)
        @depth, @range = line.split(": ").map(&:to_i)
        @is_going_down = true
        @position = 0
    end

    def move
        @position += @is_going_down ? 1 : -1

        if @position == @range
            @position -= 2
            @is_going_down = false
        end
        if @position == -1
            @position = 1
            @is_going_down = true
        end
    end

    def severity
        @position == 0 ? @depth * @range : 0
    end
end

def part1(input)
    layers = input.map { |line| Layer.new(line) }
    max_depth = layers.map { |layer| layer.depth }.max
    position = 0
    total_severity = 0
    (0..max_depth).each do |depth|
        position += 1
        curr_layer = layers.select { |layer| layer.depth == depth }[0]
        total_severity += curr_layer.severity if curr_layer != nil
        layers.each(&:move)
    end
    total_severity
end

def will_be_caught(layers, max_depth)
    position = 0
    caught = false
    (0..max_depth).each do |depth|
        position += 1
        curr_layer = layers.select { |layer| layer.depth == depth }[0]
        caught = true if curr_layer != nil && curr_layer.position == 0
        next if caught
        layers.each(&:move)
    end
    caught
end

def part2(input)
    layers = input.map { |line| Layer.new(line) }
    max_depth = layers.map { |layer| layer.depth }.max
    delay = 0
    while true
        break if !will_be_caught(layers.map(&:clone), max_depth)
        layers.each(&:move)
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