import random
import math

def file_ops(lines):
    f = open("output.txt", "a")
    for line in lines:
        print(line)
        f.write(line + '\n')
    f.write('\n')
    f.close()
    return

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

def euclidean_gcd(a,b):
    r1 = a 
    r2 = b 
    while r2 > 0:
        q = int(r1/r2)
        r = r1 - (q*r2)
        r1 = r2
        r2 = r
    
    return r1

def check_if_square(n):
    n_root = int(math.sqrt(n))
    return n_root*n_root == n

def difference_square_factorization(k,n):
    kN = k*n 
    b = 0
    lines = []
    flag = 1

    while(b<=int(n/2)):
        b_2 = b*b
        if check_if_square(kN + b_2):
            flag = 0
            break
        b += 1
    
    if(flag):
        lines.append("Cannot determine a and b (where b <= (n/2)) such that (k*n) + (b^2) == (a^2). Terminating")
        file_ops(lines)
        return

    a = int(math.sqrt(kN + b_2))

    lines.append("Values of a and b such that (k*n) + (b^2) == (a^2):")
    lines.append("a: " + str(a))
    lines.append("b: " + str(b))
    
    factor_1 = euclidean_gcd(n, abs(a-b))
    factor_2 = euclidean_gcd(n, a+b)

    lines.append("GCD of n and a-b: " + str(factor_1))
    lines.append("GCD of n and a+b: " + str(factor_2))

    prime_factors_1 = prime_factorize(factor_1)
    prime_factors_2 = prime_factorize(factor_2)

    if prime_factors_1:
        lines.append("Prime factors of gcd(n,a-b): " + ','.join([str(f) for f in prime_factors_1]))
    else:
        lines.append("Prime factors of gcd(n,a-b): N/A")

    
    if prime_factors_2:
        lines.append("Prime factors of gcd(n,a+b): " + ','.join([str(f) for f in prime_factors_2]))
    else:
        lines.append("Prime factors of gcd(n,a+b): N/A")

    prime_factors = list(set(prime_factors_1 + prime_factors_2))
    prime_factors.sort()

    lines.append("Prime factors of n using Difference of Squares method: " + ','.join([str(f) for f in prime_factors]))

    file_ops(lines)

    return

def main():
    n = int(input("Enter the positive integer n: "))
    k = int(input("Enter the positive integer k: "))
    lines = []
    
    if (n < 1):
        lines.append((str(n) + " is not positive! Terminating"))
        file_ops(lines)
        return 0
    if (k < 1):
        lines.append((str(k) + " is not positive! Terminating"))
        file_ops(lines)
        return 0
    if (n == 1):
        lines.append((str(n) + " does not have any prime factors."))
        file_ops(lines)
        return 0
    if (n == 2):
        lines.append((str(n) + " is the only prime factor of itself."))
        file_ops(lines)
        return 0
    
    
    difference_square_factorization(k,n)

if __name__=='__main__':
	main()