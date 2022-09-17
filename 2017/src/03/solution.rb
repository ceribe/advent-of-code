require_relative "../utils"
include Utils

def part1(input)
  x = 1
  y = 0
  spiral_size = 8
  travelled_in_ring = 1
  travelled_up = 1
  travelled_left = 0
  travelled_down = 0
  travelled_right = 0
  travelled_total = 2
  while travelled_total != input
    if travelled_in_ring == spiral_size
      x += 1
      travelled_in_ring = 1
      spiral_size += 8
      travelled_up = 1
      travelled_left = 0
      travelled_down = 0
      travelled_right = 0
    else
      if travelled_up < (spiral_size / 4)
        y += 1
        travelled_up += 1
      elsif travelled_left < (spiral_size / 4)
        x -= 1
        travelled_left += 1
      elsif travelled_down < (spiral_size / 4)
        y -= 1
        travelled_down += 1
      elsif travelled_right < (spiral_size / 4)
        x += 1
        travelled_right += 1
      end
      travelled_in_ring += 1
    end
    travelled_total += 1
  end
  x.abs + y.abs
end

def part2(input)
  spiral = Hash.new
  spiral["#{0}, #{0}"] = 1
  spiral["#{1}, #{0}"] = 1
  spiral.default = 0
  x = 1
  y = 0
  spiral_size = 8
  travelled_in_ring = 1
  curr_num = 1
  travelled_up = 1
  travelled_left = 0
  travelled_down = 0
  travelled_right = 0
  travelled_total = 2
  while curr_num <= input
    if travelled_in_ring == spiral_size
      x += 1
      travelled_in_ring = 1
      spiral_size += 8
      travelled_up = 1
      travelled_left = 0
      travelled_down = 0
      travelled_right = 0
    else
      if travelled_up < (spiral_size / 4)
        y += 1
        travelled_up += 1
      elsif travelled_left < (spiral_size / 4)
        x -= 1
        travelled_left += 1
      elsif travelled_down < (spiral_size / 4)
        y -= 1
        travelled_down += 1
      elsif travelled_right < (spiral_size / 4)
        x += 1
        travelled_right += 1
      end
      travelled_in_ring += 1
    end
    travelled_total += 1
    curr_num = spiral["#{x - 1}, #{y + 1}"] + spiral["#{x}, #{y + 1}"] + spiral["#{x + 1}, #{y + 1}"] + spiral["#{x - 1}, #{y}"] + spiral["#{x + 1}, #{y}"] + spiral["#{x - 1}, #{y - 1}"] + spiral["#{x}, #{y - 1}"] + spiral["#{x + 1}, #{y - 1}"]
    spiral["#{x}, #{y}"] = curr_num
  end
  curr_num
end

input = 312051
test_input_2 = 12
test_input_3 = 23
test_input_4 = 1024

check(3, part1(test_input_2))
check(2, part1(test_input_3))
check(31, part1(test_input_4))
puts "Part 1: #{part1(input)}" # 430
puts "Part 2: #{part2(input)}" # 312453