require "../utils.cr"

def get_register_values(input)
    values = Array(Int32).new
    values << 1
    input.map { |line| line.split(" ") }.each do |words|
        if words[0] == "addx"
            values << values.last
            values << words[1].to_i + values.last
        else
            values << values.last
        end
    end
    values
end

def part1(input)
    values = get_register_values(input)
    return [20, 60, 100, 140, 180, 220].map { |i| values[i-1] * i }.sum
end

def part2(input)
    values = get_register_values(input)
    output = ""
    (0..239).each { |i|
        x_pos = i % 40
        if x_pos == 0
            output += "\n"
        end

        if values[i] == x_pos || values[i] + 1 == x_pos || values[i] - 1 == x_pos
            output += "#"
        else
            output += "."
        end
    }
    return output
end

test_input = read_input("input_test")
input = read_input("input")

check(13140, part1(test_input))
puts "Part 1: #{part1(input)}" # 14560

puts "Part 2 Test: #{part2(test_input)}"
puts "Part 2: #{part2(input)}" # EKRHEPUZ