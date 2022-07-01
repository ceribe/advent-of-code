require_relative '../utils'
include Utils

class Particle
  attr_reader :position, :velocity, :acceleration, :idx
  def initialize(line, idx)
    @idx = idx
    @position, @velocity, @acceleration =
      line
        .delete('><pva=')
        .split(', ')
        .map { |sublist| sublist.split(',').map(&:to_i) }
  end

  def tick
    @velocity[0] += @acceleration[0]
    @velocity[1] += @acceleration[1]
    @velocity[2] += @acceleration[2]
    @position[0] += @velocity[0]
    @position[1] += @velocity[1]
    @position[2] += @velocity[2]
  end

  def manhattan_dist_from_0_0_0
    position.map(&:abs).sum
  end
end

def part1(input)
  particles = input.map.with_index { |line, idx| Particle.new(line, idx) }
  1_000.times { particles.each(&:tick) }
  particles.sort_by(&:manhattan_dist_from_0_0_0).first.idx
end

def part2(input)
  particles = input.map.with_index { |line, idx| Particle.new(line, idx) }
  1_000.times do
    particles.each(&:tick)
    particles =
      particles
        .group_by(&:position)
        .reject { |_, v| v.count > 1 }
        .values
        .map(&:first)
  end
  particles.length
end

input = read_input('input')
test_input = read_input('test_input')

check(0, part1(test_input))
puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"
