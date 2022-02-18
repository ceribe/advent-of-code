module Utils
  def read_input(name)
    File.read("#{name}.txt").lines
  end

  def check(expected, actual)
    if expected != actual
      puts "Expected #{expected}, but got #{actual}"
    end
  end
end