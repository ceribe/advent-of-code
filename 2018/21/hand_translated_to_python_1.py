a,b,c,d,e,f = 0,0,0,0,0,0
already_seen = {}
while True:
    c = 65536
    b = 10605201
    while True:
        f = c & 255
        b += f
        b = b & 16777215
        b *= 65899
        b = b & 16777215
        if 256 > c:
            print(b)
        f = 0

        while True:
            e = f + 1
            e *= 256
            e = 1 if e > c else 0
            if e != 1:
                f += 1
            if e == 1:
                break

        c = f
