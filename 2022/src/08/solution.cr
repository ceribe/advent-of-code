require "../utils.cr"

def part1(input)
    visible_trees = Set(String).new
    height = input.size
    width = input[0].size

    # Yeah I know this is ugly and breaks DRY but i'm too lazy to make it better
    (0...height).each do |y|
        current_max_tree_height = -1
        (0...width).each do |x|
            tree_height = input[y][x].to_i
            if tree_height > current_max_tree_height
                visible_trees << "#{x},#{y}"
                current_max_tree_height = tree_height
            end
        end
    end

    (0...height).each do |y|
        current_max_tree_height = -1
        (0...width).to_a.reverse.each do |x|
            tree_height = input[y][x].to_i
            if tree_height > current_max_tree_height
                visible_trees << "#{x},#{y}"
                current_max_tree_height = tree_height
            end
        end
    end

    (0...width).each do |x|
        current_max_tree_height = -1
        (0...height).each do |y|
            tree_height = input[y][x].to_i
            if tree_height > current_max_tree_height
                visible_trees << "#{x},#{y}"
                current_max_tree_height = tree_height
            end
        end
    end

    (0...width).each do |x|
        current_max_tree_height = -1
        (0...height).to_a.reverse.each do |y|
            tree_height = input[y][x].to_i
            if tree_height > current_max_tree_height
                visible_trees << "#{x},#{y}"
                current_max_tree_height = tree_height
            end
        end
    end

    return visible_trees.size
end

def calculate_scenic_score(input, tree_x, tree_y)
    height = input.size
    width = input[0].size

    main_tree_height = input[tree_y][tree_x].to_i
    total_scenic_score = 1

    number_of_seen_trees = 0
    (0...tree_y).reverse_each do |y|
        tree_height = input[y][tree_x].to_i
        number_of_seen_trees += 1
        if tree_height >= main_tree_height
            break
        end
    end
    total_scenic_score *= number_of_seen_trees

    number_of_seen_trees = 0
    (tree_y + 1...height).each do |y|
        tree_height = input[y][tree_x].to_i
        number_of_seen_trees += 1
        if tree_height >= main_tree_height
            break
        end
    end
    total_scenic_score *= number_of_seen_trees

    number_of_seen_trees = 0
    (0...tree_x).reverse_each do |x|
        tree_height = input[tree_y][x].to_i
        number_of_seen_trees += 1
        if tree_height >= main_tree_height
            break
        end
    end
    total_scenic_score *= number_of_seen_trees

    number_of_seen_trees = 0
    (tree_x + 1...width).each do |x|
        tree_height = input[tree_y][x].to_i
        number_of_seen_trees += 1
        if tree_height >= main_tree_height
            break
        end
    end
    total_scenic_score *= number_of_seen_trees

    return total_scenic_score
end

def part2(input)
    height = input.size
    width = input[0].size

    max_scenic_score = 0
    (0...height).each do |y|
        (0...width).each do |x|
            scenic_score = calculate_scenic_score(input, x, y)
            if scenic_score > max_scenic_score
                max_scenic_score = scenic_score
            end
        end
    end

    return max_scenic_score 
end

test_input = read_input("input_test")
input = read_input("input")

check(21, part1(test_input))
puts "Part 1: #{part1(input)}"

check(8, part2(test_input))
puts "Part 2: #{part2(input)}"