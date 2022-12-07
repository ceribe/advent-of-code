require "../utils.cr"

def parse_initial_towers(input)
    towers = Hash(String, Array(Char)).new
    max_line_length = input.last.size
    tower_number = 1
    index = 0
    while index < max_line_length
        if input.last[index] != ' ' 
            towers[tower_number.to_s] = [] of Char
            (input.size - 2).downto(0).each { |i|
                if input[i][index] != ' '
                    towers[tower_number.to_s] << input[i][index]
                end
            }
            tower_number += 1
        end
        index += 1
    end
    return towers
end

def part1(input)
    towers_input = input.take_while { |line| line != "" }
    instructions = input.skip_while { |line| line != "" }.select { |line| line != "" }
    towers = parse_initial_towers(towers_input)
    instructions.each { |instruction|
        words = instruction.split(' ')
        count = words[1].to_i
        from_tower = words[3]
        to_tower = words[5]
        count.times {
            towers[to_tower] << towers[from_tower].pop
        }
    }
    return towers.map { |name, tower| tower.last }.join
end

def part2(input)
    towers_input = input.take_while { |line| line != "" }
    instructions = input.skip_while { |line| line != "" }.select { |line| line != "" }
    towers = parse_initial_towers(towers_input)
    instructions.each { |instruction|
        words = instruction.split(' ')
        count = words[1].to_i
        from_tower = words[3]
        to_tower = words[5]
        towers[to_tower] = towers[to_tower] + towers[from_tower].pop(count)
    }
    return towers.map { |name, tower| tower.last }.join
end

test_input = read_input("input_test")
input = read_input("input")

check("CMZ", part1(test_input))
puts "Part 1: #{part1(input)}" # TLNGFGMFN

check("MCD", part2(test_input))
puts "Part 2: #{part2(input)}" # FGLQJCMBD