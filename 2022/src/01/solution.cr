require "../utils.cr"

def part1(input)
    return input
        .slice_before{ |a| a == "" } # There must be a way to split by a separator by i couldn't find it
        .map{ |sublist| sublist
            .select { |elem| elem != "" }
            .map { |elem| elem.to_i }
            .sum 
        }
        .max
end

def part2(input)
    return input
    .slice_before{ |a| a == "" }
    .map{ |sublist| sublist
        .select { |elem| elem != "" }
        .map { |elem| elem.to_i }
        .sum 
    }
    .to_a
    .sort
    .reverse
    .first(3)
    .sum
end

test_input = read_input("input_test")
input = read_input("input")

check(24000, part1(test_input))
puts "Part 1: #{part1(input)}" # 70698

check(45000, part2(test_input))
puts "Part 2: #{part2(input)}" # 206643