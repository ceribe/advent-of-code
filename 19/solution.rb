require_relative '../utils'
include Utils

def get_new_direction(map, direction, x, y)
  case direction
  when 'up', 'down'
    return 'right' if map[y][x + 1] != ' '
    return 'left' if map[y][x - 1] != ' '
    return nil
  when 'right', 'left'
    return 'down' if map[y + 1][x] != ' '
    return 'up' if map[y - 1][x] != ' '
    return nil
  end
end

def part1and2(map)
  seen_letters = ''
  steps = 0
  y = 0
  x = map[0].index('|')
  direction = 'down'
  while true
    case direction
    when 'down'
      y += 1
    when 'up'
      y -= 1
    when 'right'
      x += 1
    when 'left'
      x -= 1
    end
    char = map[y][x]
    steps += 1

    case char
    when '-', '|'
      next
    when '+'
      direction = get_new_direction(map, direction, x, y)
    when ' '
      break
    else
      seen_letters << char
    end
  end
  [seen_letters, steps]
end

input = read_input('input')
test_input = read_input('test_input')

test_res = part1and2(test_input)
res = part1and2(input)

check('ABCDEF', test_res[0])
puts "Part 1: #{res[0]}"

check(38, test_res[1])
puts "Part 2: #{res[1]}"
