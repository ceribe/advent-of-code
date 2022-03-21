require_relative '../utils'
include Utils

Instruction = Struct.new(:type, :register, :param)

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

def part1(input)
  instructions = input.map { |line| Instruction.new(*line.split(' ')) }
  registers = {}
  registers.default = 0
  last_sound = 0
  pos = 0
  while true
    instruction = instructions[pos]
    param =
      if instruction.param == nil || instruction.param.is_integer?
        instruction.param.to_i
      else
        registers[instruction.param]
      end

    case instruction.type
    when 'snd'
      last_sound = registers[instruction.register]
    when 'set'
      registers[instruction.register] = param
    when 'add'
      registers[instruction.register] += param
    when 'mul'
      registers[instruction.register] *= param
    when 'mod'
      registers[instruction.register] %= param
    when 'rcv'
      break if registers[instruction.register] != 0
    when 'jgz'
      pos += param - 1 if registers[instruction.register] > 0
    end

    pos += 1
  end
  last_sound
end

def part2(input)
  instructions = input.map { |line| Instruction.new(*line.split(' ')) }
  registers = [{}, {}]
  registers[0].default = 0
  registers[1].default = 0
  registers[1]['p'] = 1

  #It turns out that jump can be called with a number instead of a register :)
  registers[0]['1'] = 3
  registers[1]['1'] = 3

  pos = [0, 0]
  locked = [false, false]
  queue = [[], []]
  aid = 0 #active program's ID
  count = 0
  while true
    break if locked[0] && locked[1]
    instruction = instructions[pos[aid]]
    param =
      if instruction.param == nil || instruction.param.is_integer?
        instruction.param.to_i
      else
        registers[aid][instruction.param]
      end

    case instruction.type
    when 'snd'
      value_to_send = registers[aid][instruction.register]
      queue[(aid + 1) % 2].push(value_to_send)
      count += 1 if aid == 1
    when 'set'
      registers[aid][instruction.register] = param
    when 'add'
      registers[aid][instruction.register] += param
    when 'mul'
      registers[aid][instruction.register] *= param
    when 'mod'
      registers[aid][instruction.register] %= param
    when 'rcv'
      if queue[aid].empty?
        locked[aid] = true
        aid = (aid + 1) % 2
        next
      else
        registers[aid][instruction.register] = queue[aid].shift
        locked[aid] = false
      end
    when 'jgz'
      pos[aid] += param - 1 if registers[aid][instruction.register] > 0
    end

    pos[aid] += 1
    aid = (aid + 1) % 2
  end
  count
end

input = read_input('input')
test_input = read_input('test_input')
test_input_2 = read_input('test_input_2')

check(4, part1(test_input))
puts "Part 1: #{part1(input)}"
check(3, part2(test_input_2))
puts "Part 2: #{part2(input)}"
