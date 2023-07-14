require "../utils.cr"

def get_priority(char)
    char.ord - (char == char.upcase ? ('A'.ord - 27) : ('a'.ord - 1))
end

def part1(input)
    input.map { |line|
        first_compartment = line.chars.first((line.size/2).to_i)
        second_compartment = line.chars[(line.size/2).to_i..-1]
        (first_compartment & second_compartment).map { |c| get_priority(c) }.sum
    }.sum
end

def part2(input)
    sum = 0
    input.each_slice(3) { |lines|
        common_char = lines[0].chars & lines[1].chars & lines[2].chars
        sum += get_priority(common_char[0])
    }
    return sum
end

test_input = read_input("input_test")
input = read_input("input")

check(157, part1(test_input))
puts "Part 1: #{part1(input)}" # 7824

check(70, part2(test_input))
puts "Part 2: #{part2(input)}" # 2798