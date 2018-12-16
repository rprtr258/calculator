import sys
from math import cos
if len(sys.argv) != 2:
    print("Usage: python3 {} \"TEXT\"".format(sys.argv[0]))
    exit(0)
clrs = [31, 33, 32, 36, 34, 35]
ss = sys.argv[1]

def p(s):
    #s = " ".join(s)
    half = len(s) // 2
    shift = 0
    colshift = 0
    dir = 1
    for k in range(100):
        print(" " * shift, end = "")
        j = 0
        for i in range(len(s)):
            print("\x1b[{}m{}".format(clrs[(j + colshift) % len(clrs)], s[i % len(s)]), end = "")
            j += 1
            if s[i] == ' ':
                j -= 1
        colshift = (colshift + 1) % len(clrs)
        print()
        shift = half + int(half * cos(k / 4))
p(ss)
