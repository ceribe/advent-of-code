require_relative "../utils"
include Utils

def part1(input)
    components = input.map { |line| line.split("/").map(&:to_i) }
    best_bridge = 0
    build_bridge = lambda do |bridge, components|
        score = bridge.map { |component| component.sum }.sum 
        if score > best_bridge
            best_bridge = score
        end
        components.each do |component|
            if bridge.last[1] == component[0]
                build_bridge.call(bridge + [component], components - [component])
            end
            if bridge.last[1] == component[1]
                build_bridge.call(bridge + [component.reverse], components - [component])
            end
        end
    end
    components.each do |component|
        if component[0] == 0
            build_bridge.call([component], components - [component])
        end
    end
    best_bridge
end

def part2(input)
    components = input.map { |line| line.split("/").map(&:to_i) }
    best_bridge = 0
    longest_bridge = 0
    build_bridge = lambda do |bridge, components|
        score = bridge.map { |component| component.sum }.sum 
        if score > best_bridge && bridge.length >= longest_bridge
            best_bridge = score
            longest_bridge = bridge.length
        end
        components.each do |component|
            if bridge.last[1] == component[0]
                build_bridge.call(bridge + [component], components - [component])
            end
            if bridge.last[1] == component[1]
                build_bridge.call(bridge + [component.reverse], components - [component])
            end
        end
    end
    components.each do |component|
        if component[0] == 0
            build_bridge.call([component], components - [component])
        end
    end
    best_bridge
end

input = read_input("input")
test_input = read_input("test_input")

check(31, part1(test_input))
puts "Part 1: #{part1(input)}"

check(19, part2(test_input))
puts "Part 2: #{part2(input)}"