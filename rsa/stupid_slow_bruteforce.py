def powMod(x, deg, module):
    if deg == 0:
        return 1
    if deg == 1:
        return x % module
    if deg == 2:
        return (x * x) % module
    if deg % 2 == 1:
        return (x * powMod(x, deg - 1, module)) % module
    return powMod(powMod(x, deg // 2, module), 2, module)

def invertMod(x, module):
    for i in range(1, module):
        if (x * i) % module == 1:
            return i

def getInput():
    print("module: ")
    module = int(input())
    print("public exponent: ")
    exponent = int(input())
    print("cypher text: ")
    cypher = int(input())
    return (module, exponent, cypher)

def factorizeModule(module):
    for i in range(2, module):
        if module % i == 0:
            return (i, module // i)

def decryptRSA(data):
    module, exponent, cypher = data
    prime1, prime2 = factorizeModule(module)
    print("first prime: %d" % (prime1))
    print("second prime: %d" % (prime2))
    euler = (prime1 - 1) * (prime2 - 1)
    print("phi(n): %d" % (euler))
    key = invertMod(exponent, euler)
    print("secret exponent: %d" % (key))
    result = powMod(cypher, key, module)
    return result
        
data = getInput()
text = decryptRSA(module, exponent, cypher)
print("message: %s" % (text))
