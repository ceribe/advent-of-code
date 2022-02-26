require_relative "../utils"
include Utils

def part1(input)
  seen_states = {}
  count = 0
  banks = input[0].split.map(&:to_i)
  until seen_states[banks.join(",")]
    # Save current state
    seen_states[banks.join(",")] = true
    # Find biggest bank
    idx = banks.index(banks.max)
    # Redistribute the biggest bank
    blocks = banks[idx]
    banks[idx] = 0
    blocks.times do |i|
      banks[(idx + 1 + i) % banks.length] += 1
    end
    count += 1
  end
  count
end

def part2(input)
  seen_states = {}
  count = 0
  banks = input[0].split.map(&:to_i)
  times_found = 0
  until times_found == 2
    # Save current state
    seen_states[banks.join(",")] = true
    # Find biggest bank
    idx = banks.index(banks.max)
    # Redistribute the biggest bank
    blocks = banks[idx]
    banks[idx] = 0
    blocks.times do |i|
      banks[(idx + 1 + i) % banks.length] += 1
    end
    count += 1
    if seen_states[banks.join(",")]
      seen_states.clear
      times_found += 1
      if times_found == 1
        count = 0
      end
    end
  end
  count
end

input = read_input("input")
test_input = read_input("test_input")

check(5, part1(test_input))
puts "Part 1: #{part1(input)}"

check(4, part2(test_input))
puts "Part 2: #{part2(input)}"