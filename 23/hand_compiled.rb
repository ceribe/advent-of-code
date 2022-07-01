a, d, e, f, g, h = 1, 0, 0, 0, 0, 0
# value of b and c comes from first 8 lines of input file
b = 109_900
c = 126_900
while true
    f = 1
    d = 2
    while d < b
        e = 2
        while e < b
            f = 0 if e * d == b
            e += 1
        end
        d += 1
    end
    h += 1 if f == 0
    break if b == c
    b += 17
end
