require "../utils.cr"

class Point
    property x : Int32
    property y : Int32

    def initialize
        @x = 0
        @y = 0
    end
end

def move_knot_if_needed(rope, i)
    head_pos = rope[i]
    tail_pos = rope[i + 1]
    distance_on_x = (tail_pos.x - head_pos.x).abs
    distance_on_y = (tail_pos.y - head_pos.y).abs

    if distance_on_x < 2 && distance_on_y < 2
        return
    end

    if tail_pos.x == head_pos.x
        if tail_pos.y < head_pos.y
            tail_pos.y += 1
        else
            tail_pos.y -= 1
        end
    elsif tail_pos.y == head_pos.y
        if tail_pos.x < head_pos.x
            tail_pos.x += 1
        else
            tail_pos.x -= 1
        end
    else
        if tail_pos.x < head_pos.x
            tail_pos.x += 1
        else
            tail_pos.x -= 1
        end
        if tail_pos.y < head_pos.y
            tail_pos.y += 1
        else
            tail_pos.y -= 1
        end
    end
end

def part1and2(input, length)
    rope = Array(Point).new
    length.times { rope << Point.new }

    visited_positions = Set(String).new
    visited_positions << "0,0"

    input.map { |line| line.split(" ") }.each { |words|
        direction = words[0]
        distance = words[1].to_i

        distance.times {
            case direction
            when "R"
                rope[0].x += 1
            when "L"
                rope[0].x -= 1
            when "U"
                rope[0].y += 1
            when "D"
                rope[0].y -= 1
            end

            (length - 1).times { |i|
                move_knot_if_needed(rope, i)
            }
            visited_positions << "#{rope[length - 1].x},#{rope[length - 1].y}"
        }
    }
    return visited_positions.size
end

test_input_1 = read_input("input_test_1")
test_input_2 = read_input("input_test_2")
input = read_input("input")

check(13, part1and2(test_input_1, 2))
puts "Part 1: #{part1and2(input, 2)}"

check(1, part1and2(test_input_1, 10))
check(36, part1and2(test_input_2, 10))
puts "Part 2: #{part1and2(input, 10)}"