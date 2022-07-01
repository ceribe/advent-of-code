require_relative "../utils"
include Utils
require "set"

State = Struct.new(:val_0, :offset_0, :state_0, :val_1, :offset_1, :state_1)

def part1(input)
    input = input.map { |line| line.delete(".:") }
    tape = Set.new
    states = {}
    pos = 0
    # Input parsing
    current_state_name = input[0].split(" ")[3]
    steps = input[1].split(" ")[5].to_i
    input.drop(2).each_slice(10) do |lines|
        state_name = lines[1].split(" ")[2]
        
        val_0 = lines[3].split(" ")[4].to_i
        offset_0 = lines[4].split(" ")[6] == "left" ? -1 : 1
        state_0 = lines[5].split(" ")[4]

        val_1 = lines[7].split(" ")[4].to_i
        offset_1 = lines[8].split(" ")[6] == "left" ? -1 : 1
        state_1 = lines[9].split(" ")[4]

        states[state_name] = State.new(val_0, offset_0, state_0, val_1, offset_1, state_1)
    end
    # Simulate the turing machine
    steps.times do
        current_state = states[current_state_name]
        tape_value = tape.include?(pos) ? 1 : 0
        if tape_value == 0
            current_state.val_0 == 1 ? tape.add(pos) : tape.delete(pos)
            pos += current_state.offset_0
            current_state_name = current_state.state_0
        else
            current_state.val_1 == 1 ? tape.add(pos) : tape.delete(pos)
            pos += current_state.offset_1
            current_state_name = current_state.state_1
        end
    end
    tape.size
end

input = read_input("input")
test_input = read_input("test_input")
check(3, part1(test_input))
puts "Part 1: #{part1(input)}"