require_relative '../utils'
include Utils

GENERATOR_A_FACTOR = 16_807
GENERATOR_B_FACTOR = 48_271
DIVISOR = 2_147_483_647

def do_lowest_16_bits_match?(num_1, num_2)
  num_1.lowest_16_bits == num_2.lowest_16_bits
end

class Integer
  def lowest_16_bits
    self.to_s(2).rjust(16, '0')[-16..-1]
  end
end

def part1(generator_a_value, generator_b_value)
  count = 0
  40_000_000.times do
    generator_a_value = (generator_a_value * GENERATOR_A_FACTOR) % DIVISOR
    generator_b_value = (generator_b_value * GENERATOR_B_FACTOR) % DIVISOR
    count += 1 if do_lowest_16_bits_match?(generator_a_value, generator_b_value)
  end
  count
end

def part2(generator_a_value, generator_b_value)
  count = 0
  5_000_000.times do
    loop do
      generator_a_value = (generator_a_value * GENERATOR_A_FACTOR) % DIVISOR
      break if generator_a_value % 4 == 0
    end
    loop do
      generator_b_value = (generator_b_value * GENERATOR_B_FACTOR) % DIVISOR
      break if generator_b_value % 8 == 0
    end
    count += 1 if do_lowest_16_bits_match?(generator_a_value, generator_b_value)
  end
  count
end

input = [591, 393]
test_input = [65, 8921]

check(588, part1(*test_input))
puts "Part 1: #{part1(*input)}"

check(309, part2(*test_input))
puts "Part 2: #{part2(*input)}"
