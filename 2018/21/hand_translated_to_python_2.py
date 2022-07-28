a,b,c,d,e,f = 0,0,0,0,0,0
already_seen = set()
already_printed = set()
while True:
    c = b | 65536
    b = 10605201
    while True:
        f = c & 255
        b += f
        b = b & 16777215
        b *= 65899
        b = b & 16777215
        if 256 > c:
            if b in already_seen and b not in already_printed:
                print(b)
                already_printed.add(b)
            already_seen.add(b)
            break
        c = c // 256