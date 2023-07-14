require "../utils.cr"

class Monkey 
    property items : Array(Int64)
    property operation : Array(String)
    property divisible_by : Int32
    property test_true_monkey_id : Int32
    property test_false_monkey_id : Int32
    property items_inpected_count : Int64 = 0

    def initialize(items, operation, divisible_by, test_true_monkey_id, test_false_monkey_id)
        @items = items
        @operation = operation
        @divisible_by = divisible_by
        @test_true_monkey_id = test_true_monkey_id
        @test_false_monkey_id = test_false_monkey_id
    end
end

def get_monkeys(input)
    input
        .slice_after { |line| line == "" }
        .map { |lines|
            items = lines[1].split(":")[1].split(", ").map { |item| item.to_i64 }
            operation = lines[2].split(" ")[6..7]
            divisible_by = lines[3].split(" ")[5].to_i
            test_true_monkey_id = lines[4].split(" ")[9].to_i
            test_false_monkey_id = lines[5].split(" ")[9].to_i
            Monkey.new(items, operation, divisible_by, test_true_monkey_id, test_false_monkey_id)
        }.to_a
end

def part1and2(input, part)
    monkeys = get_monkeys(input)
    big_modulo = monkeys.map { |monkey| monkey.divisible_by }.reduce { |a, b| a * b }
    (part == 1 ? 20 : 10000).times {
        monkeys.each { |monkey|
            while (!monkey.items.empty?)
                monkey.items_inpected_count += 1
                item = monkey.items.shift

                if (monkey.operation[0] == "+")
                    item += monkey.operation[1].to_i
                elsif (monkey.operation[1] == "old")
                    item *= item
                else
                    item *= monkey.operation[1].to_i
                end

                if part == 1
                    item = (item / 3).floor.to_i64
                else
                    item %= big_modulo
                end

                if (item % monkey.divisible_by == 0)
                    monkeys[monkey.test_true_monkey_id].items << item
                else
                    monkeys[monkey.test_false_monkey_id].items << item
                end
            end
        }
    }
    # The array has at max 7 elements so whatever
    monkeys.sort_by! { |monkey| monkey.items_inpected_count }.reverse! 
    return monkeys[0].items_inpected_count.to_i64 * monkeys[1].items_inpected_count.to_i64
end

test_input = read_input("input_test")
input = read_input("input")

check(10605, part1and2(test_input, 1))
puts "Part 1: #{part1and2(input, 1)}" # 120384

check(2713310158, part1and2(test_input, 2))
puts "Part 2: #{part1and2(input, 2)}" # 32059801242