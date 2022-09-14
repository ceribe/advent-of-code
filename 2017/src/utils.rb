module Utils
  def read_input(filename)
    File.read(filename).lines
  end

  def read_first_line(filename)
    read_input(filename).first
  end

  def check(expected, actual)
    if expected != actual
      throw "Expected #{expected}, got #{actual}"
    end
  end

  def calculate_knot_hash(input)
    input = input.chars.map(&:ord)
    lengths = input + [17, 31, 73, 47, 23]
    position = 0
    skip_size = 0
    numbers = (0...256).to_a
    64.times { 
        lengths.each { |length|
            numbers.rotate!(position)
            numbers[0...length] = numbers[0...length].reverse
            numbers.rotate!(-position)
            position += (length + skip_size) % 256
            skip_size += 1
        }
    }
    numbers
        .each_slice(16)
        .map { |arr| arr.reduce(:^).to_s(16).rjust(2, '0') }
        .join("")
  end
end