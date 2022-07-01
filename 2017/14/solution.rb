require_relative '../utils'
include Utils

def part1(input)
  (0..127).map do |i|
    calculate_knot_hash("#{input}-#{i}").hex.to_s(2).count('1')
  end.sum
end

def part2(input)
  disk =
    (0..127).map do |i|
      calculate_knot_hash("#{input}-#{i}")
        .chars
        .map { |char| char.hex.to_s(2).rjust(4, '0') }
        .join
        .chars
        .map(&:to_i)
    end
  group_count = 0
  128.times do |x|
    128.times do |y|
      created_new_group = try_to_add_to_group(disk, group_count + 2, x, y)
      group_count += 1 if created_new_group
    end
  end
  group_count
end

def try_to_add_to_group(disk, group_number, x, y)
  return false if x < 0 || x > 127 || y < 0 || y > 127 || disk[x][y] != 1
  disk[x][y] = group_number
  try_to_add_to_group(disk, group_number, x, y - 1)
  try_to_add_to_group(disk, group_number, x, y + 1)
  try_to_add_to_group(disk, group_number, x - 1, y)
  try_to_add_to_group(disk, group_number, x + 1, y)
  return true
end

input = 'wenycdww'
test_input = 'flqrgnkx'

check(8108, part1(test_input))
puts "Part 1: #{part1(input)}"

check(1242, part2(test_input))
puts "Part 2: #{part2(input)}"
