import sys
from math import cos
if len(sys.argv) != 2:
    print("Usage: python3 {} \"TEXT\"".format(sys.argv[0]))
    exit(0)
clrs = [31, 33, 32, 36, 34, 35]
s = sys.argv[1]
half = len(s) // 2
colshift = 0
for k in range(100):
    print(" " * int(half * (1 + cos(k / 4))), end = "")
    j = 0
    for i in range(len(s)):
        print("\x1b[{}m{}".format(clrs[(j + colshift) % len(clrs)], s[i]), end = "")
        j += (s[i] != ' ')
    colshift = (colshift + 1) % len(clrs)
    print()
