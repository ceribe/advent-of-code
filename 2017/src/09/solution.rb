require_relative "../utils"
include Utils

def part1(input)
    garbage_mode = false
    ignore_next = false
    points = 0
    stack = 0
    input.chars.each { |char|
        if ignore_next
            ignore_next = false
            next
        end
        case char
            when '{'
                stack += 1 if !garbage_mode
            when '}'
                if !garbage_mode
                    points += stack
                    stack -= 1
                end
            when '<'
                garbage_mode = true
            when '>'
                garbage_mode = false
            when '!'
                ignore_next = true
        end
    }
    points
end

def part2(input)
    garbage_mode = false
    ignore_next = false
    garbage_count = 0
    input.chars.each { |char|
        if ignore_next
            ignore_next = false
            next
        end
        case char
            when '<'
                if !garbage_mode
                    garbage_mode = true
                    next
                end
            when '>'
                garbage_mode = false
                next
            when '!'
                ignore_next = true
                next
        end
        garbage_count += 1 if garbage_mode
    }
    garbage_count
end

input = read_first_line("input.txt")
test_input_1 = "{{<a!>},{<a!>},{<a!>},{<ab>}}"
test_input_2 = "{{<!!>},{<!!>},{<!!>},{<!!>}}"
test_input_3 = "{{{},{},{{}}}}"
test_input_4 = "{{},{}}"
test_input_5 = "<{o\"i!a,<{i<a>"
test_input_6 = "<random characters>"

check(3, part1(test_input_1))
check(9, part1(test_input_2))
check(16, part1(test_input_3))
check(5, part1(test_input_4))
puts "Part 1: #{part1(input)}"

check(10, part2(test_input_5))
check(17, part2(test_input_6))
puts "Part 2: #{part2(input)}"