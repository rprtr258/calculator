print("n(module): ")
n = int(input())
print("e(public exponent): ")
e = int(input())
print("c(cypher text): ")
c = int(input())
p, q = 0, 0
for i in range(2, n):
	if n % i == 0:
		p, q = i, n // i
		break;
print("p:", p)
print("q:", q)
phi = (p - 1) * (q - 1)
print("phi(n):", phi)
d = 0
for i in range(1, phi - 1):
	if (e * i) % phi == 1:
		d = i
		break
print("d(secret exponent):", d)
def pw(x, deg):
	if deg == 0:
		return 1
	if deg == 1:
		return x % n
	if deg == 2:
		return (x * x) % n
	if deg % 2 == 1:
		return (x * pw(x, deg - 1)) % n
	return pw(pw(x, deg // 2), 2)
print("message:", pw(c, d))
