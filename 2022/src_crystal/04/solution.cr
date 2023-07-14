require "../utils.cr"

def part1(input)
    count = 0
    input.each do |line|
        left_range_string, right_range_string = line.split(",")
        left_range = left_range_string.split("-").map(&.to_i)
        right_range = right_range_string.split("-").map(&.to_i)
        is_right_range_contained_in_left = left_range[0] <= right_range[0] && left_range[1] >= right_range[1]
        is_left_range_contained_in_right = right_range[0] <= left_range[0] && right_range[1] >= left_range[1]
        if is_right_range_contained_in_left || is_left_range_contained_in_right
            count += 1
        end
    end
    return count
end

def part2(input)
    count = 0
    input.each do |line|
        left_range_string, right_range_string = line.split(",")
        left_range = left_range_string.split("-").map(&.to_i)
        right_range = right_range_string.split("-").map(&.to_i)
        do_ranges_overlap = 
            left_range[1] >= right_range[0] && right_range[1] >= left_range[0] || 
            right_range[1] >= left_range[0] && left_range[1] >= right_range[0]
        if do_ranges_overlap
            count += 1
        end
    end
    return count
end

test_input = read_input("input_test")
input = read_input("input")

check(2, part1(test_input))
puts "Part 1: #{part1(input)}" # 464

check(4, part2(test_input))
puts "Part 2: #{part2(input)}" # 770