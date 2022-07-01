require_relative "../utils"
include Utils

def reduce_opposite(dirs, dir1, dir2)
    if dirs[dir1] > dirs[dir2]
        dirs[dir1] -= dirs[dir2]
        dirs[dir2] = 0
    else
        dirs[dir2] -= dirs[dir1]
        dirs[dir1] = 0
    end
end

def reduce_diagonal(dirs, dir1, dir2, dir3)
    min = [dirs[dir1], dirs[dir2]].min
    dirs[dir1] -= min
    dirs[dir2] -= min
    dirs[dir3] += min
end

def part1(input)
    dirs = {}
    dirs.default = 0
    input.split(",").each { |char|
        dirs[char] += 1
    }
    prev_values = []
    while dirs.values != prev_values 
        prev_values = dirs.values
        reduce_diagonal(dirs, "n", "se", "ne")
        reduce_diagonal(dirs, "ne", "s", "se")
        reduce_diagonal(dirs, "se", "sw", "s")
        reduce_diagonal(dirs, "s", "nw", "sw")
        reduce_diagonal(dirs, "sw", "n", "nw")
        reduce_diagonal(dirs, "nw", "ne", "n")
    end
    reduce_opposite(dirs, "n", "s")
    reduce_opposite(dirs, "ne", "sw")
    reduce_opposite(dirs, "nw", "se")
    dirs.values.sum
end

def part2(input)
    steps = input.split(",")
    # This is really inefficient, but it works
    (1...steps.length).map { |i| part1(steps[0..i].join(","))}.max
end

input = read_input("input")[0]

check(3, part1("ne,ne,ne"))
check(0, part1("ne,ne,sw,sw"))
check(2, part1("ne,ne,s,s"))
check(3, part1("se,sw,se,sw,sw"))
puts "Part 1: #{part1(input)}"
puts "Part 2: #{part2(input)}"