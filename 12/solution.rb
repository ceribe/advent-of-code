require_relative "../utils"
require 'set'
include Utils

def get_group_for_program(initial_program, pipes)
    open_set = Set.new
    open_set.add(initial_program)
    closed_set = Set.new
    while !open_set.empty?
        new_open_set = Set.new
        open_set.each { |program|
            exits = pipes[program]
            next if exits == nil
            exits.filter { |exit| !closed_set.include?(exit) }.each { |exit|
                new_open_set.add(exit)
            }
        }
        open_set.each { |program| closed_set.add(program) if pipes.key?(program) }
        open_set = new_open_set
    end
    closed_set
end

def get_pipes(input)
    pipes = {}
    input.each do |line|
        left, right = line.split(" <-> ")
        pipes[left.to_i] = right.split(", ").map(&:to_i)
    end
    pipes
end

def part1(input)
    pipes = get_pipes(input)
    get_group_for_program(0, pipes).length
end

def part2(input)
    pipes = get_pipes(input)
    groups = Set.new
    counter = 0
    while true
        new_group = get_group_for_program(counter, pipes)
        break if new_group.length == 0
        groups.add(new_group)
        counter += 1
    end
    groups.size
end

input = read_input("input")
test_input = read_input("test_input")

check(6, part1(test_input))
puts "Part 1: #{part1(input)}"

check(2, part2(test_input))
puts "Part 2: #{part2(input)}"