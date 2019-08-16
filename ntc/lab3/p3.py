import math

def gcd(x, y):
	while(y): 
		x, y = y, x % y 
	return x 

def sumSquare(n, k) :
	i = 1
	for i in range(n//2):
		number = (k*n) + math.pow(i, 2)
		root = math.sqrt(number)
		if int(root + 0.5) ** 2 == number:
			# print(root, "^2 - ", i , "^2" )
			return [root, i]
	return False

def prime_factorize(n):
    factors = []
    if (n % 2 == 0):
        factors.append(2)
    while (n % 2 == 0):
        n = n / 2

    for i in range(3, int(math.sqrt(n)+1), 2):
        if (n % i == 0):
            factors.append(int(i))
        while (n % i == 0):
            n = n / i
    if (n > 2):
      factors.append(int(n))
    
    return factors

def findFactors(n, k):
	if (n <=0 or k <= 0):
		print("ERROR: Invalid input")
		return
	print("n =", str(n) + ", k =", k)
	res = sumSquare(n, k)
	if (res is False) :
		print( "\tN cannot be factorized (no a and b found with k =", k)
	else :
		r1 = res[0]
		r2 = res[1]
		print("\ta =", r1)
		print("\tb =", r2)
		factor_1 = gcd(n, r1+r2)
		factor_2 = gcd(n, r1-r2)
		print("\t", factor_1)
		print("\t", factor_2)
		print()
		prime_factors_1 = prime_factorize(factor_1)
		prime_factors_2 = prime_factorize(factor_2)

		if prime_factors_1:
			print("Prime factors of gcd(n,a-b): " + ','.join([str(f) for f in prime_factors_1]))
		else:
			print("Prime factors of gcd(n,a-b): N/A")

		
		if prime_factors_2:
			print("Prime factors of gcd(n,a+b): " + ','.join([str(f) for f in prime_factors_2]))
		else:
			print("Prime factors of gcd(n,a+b): N/A")

		prime_factors = list(set(prime_factors_1 + prime_factors_2))
		prime_factors.sort()

		print("Prime factors of n using Difference of Squares method: " + ','.join([str(f) for f in prime_factors]))
	
# Sample:
# n = 203299
# k = 3
findFactors(203299, 3)

# Test Case 1:
# n = 99400897
# k = 3
findFactors(99400897, 3)

# Test Case 2:
# n = 96177233
# k = 5
findFactors(96177233, 5)

# Test Case 3:
# n = 783221
# k = 3
findFactors(783221, 3)

# Test Case 4:
# n = 627239
# k = 5
findFactors(627239, 5)

# Test Case 5:
# n = 381397
# k = 3
findFactors(381397, 3)
