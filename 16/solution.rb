require_relative '../utils'
include Utils

def part1(input, programs)
  input
    .split(',')
    .each do |instruction|
      case instruction[0]
      when 's'
        programs = programs.rotate(-instruction[1..-1].to_i)
      when 'x'
        pos_1, pos_2 = instruction[1..-1].split('/').map(&:to_i)
        programs[pos_1], programs[pos_2] = programs[pos_2], programs[pos_1]
      when 'p'
        name_1 = instruction[1]
        name_2 = instruction[3]
        pos_1 = programs.index(name_1)
        pos_2 = programs.index(name_2)
        programs[pos_1], programs[pos_2] = programs[pos_2], programs[pos_1]
      end
    end
  programs.join
end

def part2(input, programs)
  seen_so_far = []
  loop_size = 0
  while true
    programs_string = part1(input, programs)
    programs = programs_string.chars
    break if seen_so_far.include?(programs_string)
    seen_so_far.append(programs_string)
    loop_size += 1
  end
  seen_so_far[(1_000_000_000 % loop_size) - 1]
end

input = read_input('input')[0]
test_input = read_input('test_input')[0]

check('baedc', part1(test_input, ('a'..'e').to_a))
puts "Part 1: #{part1(input, ('a'..'p').to_a)}"
puts "Part 2: #{part2(input, ('a'..'p').to_a)}"
