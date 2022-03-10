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

class Integer
    def to_hex
        self.to_s(16).rjust(2, '0')
    end
end

def part2(input)
    input = input.chars.map(&:ord)
    lengths = input + [17, 31, 73, 47, 23]
    position = 0
    skip_size = 0
    numbers = (0...256).to_a
    64.times { 
        lengths.each { |length|
            numbers.rotate!(position)
            numbers[0...length] = numbers[0...length].reverse
            numbers.rotate!(-position)
            position += (length + skip_size) % 256
            skip_size += 1
        }
    }
    numbers
        .each_slice(16)
        .map { |arr| arr.reduce(:^).to_hex }
        .join("")
end

input = read_input("input")[0]

check(12, part1("3, 4, 1, 5", 5))
puts "Part 1: #{part1(input, 256)}"

check("3efbe78a8d82f29979031a4aa0b16a9d", part2("1,2,3"))
check("63960835bcdc130f0b66d7ff4f6a5a8e", part2("1,2,4"))
check("33efeb34ea91902bb2f59c9920caa6cd", part2("AoC 2017"))
puts "Part 2: #{part2(input)}"