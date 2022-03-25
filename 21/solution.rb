require_relative '../utils'
include Utils

INITIAL_IMAGE = [%w[. # .], %w[. . #], %w[# # #]]

def parse_rules(input)
  rules = {}

  add_rule =
    lambda do |rule_input, rule_output|
      if rules.key?(rule_input) && rules[rule_input] != rule_output
        raise 'Rule already exists with different value'
      end
      rules[rule_input] = rule_output
    end

  input.each do |line|
    rule_input, _, rule_output = line.split
    rule_input = rule_input.split('/').map(&:chars)
    rule_output = rule_output.split('/').map(&:chars)
    add_rule.call(rule_input, rule_output)

    # To not waste time constantly rotating squares when trying to find the matching rule
    # rotate and flip each rule beforehand
    4.times do
      rule_input = rule_input.reverse
      add_rule.call(rule_input, rule_output)
      rule_input = rule_input.reverse

      rule_input = rule_input.map(&:reverse)
      add_rule.call(rule_input, rule_output)
      rule_input = rule_input.reverse
      add_rule.call(rule_input, rule_output)
      rule_input = rule_input.reverse
      rule_input = rule_input.map(&:reverse)

      rule_input = rule_input.transpose.map(&:reverse)
    end
  end
  rules
end

def apply_rules(image, rules)
  square_size = image.size.even? ? 2 : 3
  new_square_size = square_size + 1

  size = image.size
  new_size = size * new_square_size / square_size
  new_image = Array.new(new_size) { Array.new(new_size) }
  number_of_squares = image.size / square_size
  number_of_squares.times do |y|
    number_of_squares.times do |x|
      square = Array.new(square_size) { Array.new(square_size) }
      square_size.times do |i|
        square_size.times do |j|
          square[i][j] = image[y * square_size + i][x * square_size + j]
        end
      end
      new_square = rules[square]
      raise "Missing rule for #{square}" if new_square.nil?

      new_square_size.times do |i|
        new_square_size.times do |j|
          new_image[y * new_square_size + i][x * new_square_size + j] =
            new_square[i][j]
        end
      end
    end
  end

  new_image
end

def count_turned_on_pixels(image)
  image.map { |line| line.count('#') }.sum
end

def part1and2(input, iterations_count)
  image = INITIAL_IMAGE
  rules = parse_rules(input)
  iterations_count.times { image = apply_rules(image, rules) }
  count_turned_on_pixels(image)
end

input = read_input('input')
test_input = read_input('test_input')

check(12, part1and2(test_input, 2))
puts "Part 1: #{part1and2(input, 5)}"
puts "Part 2: #{part1and2(input, 18)}"
