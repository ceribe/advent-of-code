require_relative "../utils"
include Utils

Instruction = Struct.new(:type, :register, :param)

def part1(input)
  a, b, c, d, e, f, g, h = 0, 0, 0, 0, 0, 0, 0, 0
  instructions = input.map { |line| Instruction.new(*line.split(' ')) }
  mul_count = 0
  pos = 0
  while true
    instruction = instructions[pos]
    case instruction.type
    when "set"
      eval("#{instruction.register}=#{instruction.param}")
    when "sub"
      eval("#{instruction.register}-=#{instruction.param}")
    when "mul"
      eval("#{instruction.register}*=#{instruction.param}")
      mul_count += 1
    when "jnz"
      pos += eval(instruction.param) - 1 if eval(instruction.register) != 0
    end
    pos += 1
    break if pos < 0 || pos >= instructions.size
  end
  mul_count
end

def is_prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).each { |i| return false if n % i == 0 }
  true
end

def part2
  (109_900..126_900).step(17).to_a.count { |n| !is_prime?(n) }
end

input = read_input("input")
puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2()}"