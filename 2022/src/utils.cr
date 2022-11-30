def read_input(filename)
    File.read(filename+".txt").lines
end

def read_first_line(filename)
    read_input(filename).first
end

def check(expected, actual)
    if expected != actual
        raise "Expected #{expected}, got #{actual}"
    end
end
