require_relative "../utils"
include Utils

def part1(input)
  names = input.map { |line| line.split(" ")[0] }
  right_sides = input.flat_map { |line| (line.split("->")[1] || "").strip.split(", ") }
  names.find { |name| !right_sides.include? name }
end

class Disc
  attr_reader :name, :weight,:children
  def initialize(line)
    @name = line.split(" ")[0]
    @weight = line.split(" ")[1][1..-2].to_i
    @children = (line.split("->")[1] || "").strip.split(", ")
  end
end

def find_disc_with_name(name, discs)
  discs.find { |disc| disc.name == name }
end

def part2(input)
  discs = input.map { |line| Disc.new line }
  base = find_disc_with_name(part1(input), discs)
  new_weight = 0
  found = false
  search = lambda { |disc|
    children = disc.children.map { |child| find_disc_with_name(child, discs) }
    child_weights = children.map { |child| search.call(child) }
    # Because recursive search goes from the leafs of the tree the first found new_weight is the correct one
    # Code below is not optimal and different disc could be found faster
    if child_weights.length > 0 && child_weights.max != child_weights.min && !found
      idx_of_different = child_weights.index { |elem| child_weights.count(elem) == 1 }
      weight_diff = (child_weights[idx_of_different] - child_weights[(idx_of_different + 1) % child_weights.length]).abs
      new_weight = children[idx_of_different].weight - weight_diff
      found = true
    end
    disc.weight + child_weights.sum
  }
  search.call(base)
  new_weight
end

input = read_input("input")
test_input = read_input("test_input")

check("tknk", part1(test_input))
puts "Part 1: #{part1(input)}"

check(60, part2(test_input))
puts "Part 2: #{part2(input)}"