require "../utils.cr"

def part1(input)
    return "1"
end

def part2(input)
    return "1"
end

input = read_input("input")

check(7, part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb"))
check(5, part1("bvwbjplbgvbhsrlpgdmjqwftvncz"))
check(6, part1("nppdvjthqldpwncqszvftbrmjlhg"))
check(10, part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"))
check(11, part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))
puts "Part 1: #{part1(input)}"

check(0, part2(test_input))
puts "Part 2: #{part2(input)}"