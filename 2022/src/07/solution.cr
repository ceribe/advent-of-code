require "../utils.cr"

class Node
    property name : String
    property size : Int32
    property children : Array(Node)
    property parent : Node?

    def initialize(name, size)
        @name = name
        @size = size
        @children = Array(Node).new
        @parent = nil
    end

    def add_child_if_needed(child_name, size)
        child = @children.find { |c| c.name == child_name }
        if child.nil?
            child = Node.new(child_name, size)
            @children << child
        end
        child.parent = self
        return child
    end

    def get_total_size
        return size + children.map { |c| c.get_total_size.as(Int32) }.sum
    end

    def get_total_size_of_directories_recursively
        if children.empty?
            return 0
        end

        total_child_size = children.map { |c| c.get_total_size }.sum
        
        if size + total_child_size > 100000
            return children.map { |c| c.get_total_size_of_directories_recursively.as(Int32) }.sum
        else
            return total_child_size + size + children.map { |c| c.get_total_size_of_directories_recursively.as(Int32) }.sum
        end
    end
end

def create_filesystem(input)
    root = Node.new("/", 0)
    current_node = root
    input.skip(1).each do |line|
        words = line.split(" ")
        unless current_node.nil?
            if words[0] == "$" && words[1] == "cd"
                if words[2] == ".."
                    current_node = current_node.parent
                else
                    current_node = current_node.add_child_if_needed(words[2], 0)
                end
            elsif words[0] != "$" 
                if words[0] == "dir"
                    current_node.add_child_if_needed(words[1], 0)
                else
                    current_node.add_child_if_needed(words[1], words[0].to_i)
                end
            end
        end
    end
    return root
end

def part1(input)
    root = create_filesystem(input)
    return root.get_total_size_of_directories_recursively
end

def part2(input)
    root = create_filesystem(input)
    amount_of_free_space = 70000000 - root.get_total_size
    minimum_freed_space = 30000000 - amount_of_free_space
    current_smallest_directory = root
    find_smallest_directory = uninitialized Proc(Node, Nil)
    find_smallest_directory = ->(node: Node) { 
        if node.children.empty?
            return
        end
        node_size = node.get_total_size
        if node_size > minimum_freed_space && node_size < current_smallest_directory.get_total_size
            current_smallest_directory = node
        end
        node.children.each { |c| find_smallest_directory.call(c) }
    }
    find_smallest_directory.call(root)
    return current_smallest_directory.get_total_size
end

test_input = read_input("input_test")
input = read_input("input")

check(95437, part1(test_input))
puts "Part 1: #{part1(input)}"

check(24933642, part2(test_input))
puts "Part 2: #{part2(input)}"