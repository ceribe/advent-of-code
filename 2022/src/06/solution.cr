require "../utils.cr"

class String
    def is_unique?
        self.chars.uniq.size == self.size
    end
end

def part1and2(input, chars_num)
    (0..input.size-chars_num+1).each do |i|
        if input[i..i+chars_num-1].is_unique?
            return i+chars_num
        end
    end
end

test_input_1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
test_input_2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
test_input_3 = "nppdvjthqldpwncqszvftbrmjlhg"
test_input_4 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
test_input_5 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
input = read_first_line("input")

check(7, part1and2(test_input_1, 4))
check(5, part1and2(test_input_2, 4))
check(6, part1and2(test_input_3, 4))
check(10, part1and2(test_input_4, 4))
check(11, part1and2(test_input_5, 4))
puts "Part 1: #{part1and2(input, 4)}"

check(19, part1and2(test_input_1, 14))
check(23, part1and2(test_input_2, 14))
check(23, part1and2(test_input_3, 14))
check(29, part1and2(test_input_4, 14))
check(26, part1and2(test_input_5, 14))
puts "Part 2: #{part1and2(input, 14)}"