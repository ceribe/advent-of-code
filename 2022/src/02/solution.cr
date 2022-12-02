require "../utils.cr"

def part1(input)
    points_map = Hash(String, Int32).new
    points_map["A X"] = 4
    points_map["A Y"] = 8
    points_map["A Z"] = 3
    points_map["B X"] = 1
    points_map["B Y"] = 5
    points_map["B Z"] = 9
    points_map["C X"] = 7
    points_map["C Y"] = 2
    points_map["C Z"] = 6

    return input.map { |line| points_map[line] }.sum    
end

def part2(input)
    points_map = Hash(String, Int32).new
    points_map["A X"] = 3
    points_map["A Y"] = 4
    points_map["A Z"] = 8
    points_map["B X"] = 1
    points_map["B Y"] = 5
    points_map["B Z"] = 9
    points_map["C X"] = 2
    points_map["C Y"] = 6
    points_map["C Z"] = 7

    return input.map { |line| points_map[line] }.sum    
end

test_input = read_input("input_test")
input = read_input("input")

check(15, part1(test_input))
puts "Part 1: #{part1(input)}"

check(12, part2(test_input))
puts "Part 2: #{part2(input)}"