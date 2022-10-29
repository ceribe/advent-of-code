require_relative "../utils"
include Utils

def part1(lengths, no_elements)
    position = 0
    skip_size = 0
    numbers = (0...no_elements).to_a
    lengths = lengths.split(",").map(&:to_i)
    lengths.each { |length|
        numbers.rotate!(position)
        numbers[0...length] = numbers[0...length].reverse
        numbers.rotate!(-position)
        position += (length + skip_size) % no_elements
        skip_size += 1
    }
    numbers[0] * numbers[1]
end

def part2(input)
    calculate_knot_hash(input) 
end

input = read_first_line("input.txt")

check(12, part1("3, 4, 1, 5", 5))
puts "Part 1: #{part1(input, 256)}"

check("3efbe78a8d82f29979031a4aa0b16a9d", part2("1,2,3"))
check("63960835bcdc130f0b66d7ff4f6a5a8e", part2("1,2,4"))
check("33efeb34ea91902bb2f59c9920caa6cd", part2("AoC 2017"))
puts "Part 2: #{part2(input)}"