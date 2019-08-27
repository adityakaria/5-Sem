import random
import math


def file_ops(lines):
    f = open("program_output.txt", "a")
    for line in lines:
        print(line)
        f.write(line + '\n')
    f.write('\n')
    f.close()
    return


def gcd(a, b):
    if (b == 0):
        return a
    return gcd(b, a % b)


def check_if_square(n):
    n_root = int(math.sqrt(n))
    return n_root*n_root == n


def prime_factors(num):
    prime_factors = []
    if(num % 2 == 0):
        prime_factors.append(2)
    while(num % 2 == 0):
        num = num / 2
    for i in range(3, math.ceil(math.sqrt(num))):
        if(num % i == 0):
            prime_factors.append(i)
        while(num % i == 0):
            num = num / i
    if(num > 2):
        prime_factors.append(int(num))
    return prime_factors


def isSmooth(num, b, fb):
    pf = prime_factors(num)
    print
    for i in pf:
        if i > b:
            return False
    return True


def identity_matrix(height):
    return [[1 if i == j else 0 for j in range(height)] for i in range(height)]

# getting a set of vectors from vector_list where multiplication of corresponding Q(a[i])s forms a perfect square


def find_linear_combination(vector_list):
    height = len(vector_list)
    width = len(vector_list[0])
    combinations = identity_matrix(height)

    for offset in range(width):
        if vector_list[offset][offset] == 0:
            for x in range(width):
                if vector_list[offset][x] != 0:
                    break
            else:
                return combinations[offset]

            for y in range(offset + 1, height):
                if vector_list[y][offset] != 0:
                    vector_list[y], vector_list[offset] = vector_list[offset], vector_list[y]
                    combinations[y], combinations[offset] = combinations[offset], combinations[y]
                    break
            else:
                continue

        for y in range(offset + 1, height):
            if vector_list[y][offset] == 0:
                continue
            for x in range(width):
                vector_list[y][x] *= -1
                vector_list[y][x] += vector_list[offset][x]
                vector_list[y][x] %= 2

            for x in range(height):
                combinations[y][x] *= -1
                combinations[y][x] += combinations[offset][x]
                combinations[y][x] %= 2
    return combinations[-1]


# only for odd_primes and 2
def check_quad_residue(num, p):
    if num == 1 and p == 2:
        return True

    if num % p == 0:
        return False
    else:
        res = num ** ((p - 1) / 2)
        res = res % p
        if res == 1:
            return True
        else:
            return False


def check_prime(num):
    if num == 2:
        return True
    if num % 2 == 0:
        return False
    mx = math.ceil(math.sqrt(num))
    for i in range(2, mx):
        if num % i == 0:
            return False
    return True


def quad_sieve(n, b):
    # populating the factor base
    lines = []
    factor_base = [-1]

    for i in range(2, b+1):
        if check_prime(i):
            mod = n % i
            if check_quad_residue(mod, i):
                factor_base.append(i)

    lines.append("\nB-smooth factor base: " +
                 ','.join([str(f) for f in factor_base]))
    lines.append("Q(x) is defined as (a*a - N)\n")

    fb_len = len(factor_base)
    q = []
    a = []
    i = 1
    while len(a) != fb_len:
        #root(n) + i
        temp = i + math.floor(math.sqrt(n))
        # Q(a[i]) = a[i]^2 - n
        q_temp = temp ** 2 - n
        if isSmooth(abs(q_temp), b, factor_base):
            q.append(q_temp)
            a.append(temp)

        if len(q) == fb_len:
            break

        #root(n) - i
        temp = -i + math.floor(math.sqrt(n))
        # Q(a[i]) = a[i]^2 - n
        q_temp = temp ** 2 - n
        if isSmooth(abs(q_temp), b, factor_base):
            q.append(int(q_temp))
            a.append(temp)
        i += 1

    lines.append("Values of a close to n^(0.5): " +
                 ','.join([str(f) for f in a]))
    lines.append("B-Smooth Q(a): " + ','.join([str(f) for f in q]) + "\n")

    # exponent vectors
    exp_vec = []
    for i in range(len(q)):
        vec = [-1 for _ in range(len(factor_base))]
        num = q[i]
        if q[i] < 0:
            vec[0] = 1
            num = abs(num)
        else:
            vec[0] = 0

        for j in range(1, len(factor_base)):
            count = 0
            while num % factor_base[j] == 0:
                count += 1
                num = num / factor_base[j]
            count = count % 2
            vec[j] = count
        exp_vec.append(vec)

    lines.append("Corresponding exponent vectors:")

    for vec in exp_vec:
        lines.append(','.join([str(f) for f in vec]))
    lines.append("")

    lc_list = find_linear_combination(exp_vec)
    x = 1
    y2 = 1
    lines.append('Exponent vectors chosen')
    for i in range(len(lc_list)):
        if lc_list[i] == 1:
            lines.append('a[i] = ' + str(a[i]) + '  Q(a[i]) = ' + str(q[i]))
            x *= a[i]
            y2 *= q[i]
    y = int(math.sqrt(y2))
    x = x % n
    y = y % n

    lines.append(
        "x and y chosen such that x^2 is congruent to y^2(mod n): " + str(x) + "," + str(y))

    f = int(gcd(x - y, n))
    g = int(gcd(x + y, n))

    if(f != 1 and g != 1):
        lines.append("Final factors f and g such that f = gcd(x+y,n), g = gcd(x-y,n), n = f*g and 1 < (f,g) < n: " +
                     str(f) + "," + str(g) + "\n")
    else:
        lines.append(
            "Unable to determine f and g such that f = gcd(x+y,n), g = gcd(x-y,n), n = f*g and 1 < (f,g) < n.\n")

    file_ops(lines)


def main():
    N = int(input("Enter the positive integer N: "))
    B = int(input("Enter the positive integer B: "))
    lines = []

    if (N < 1):
        lines.append(("Error: N (=" + str(N) + ") needs to be positive"))
        file_ops(lines)
        return 0
    if (B < 1):
        lines.append(("Error: N (=" + str(B) + ") needs to be positive"))
        file_ops(lines)
        return 0
    if (N == 1):
        lines.append((str(N) + " does not have any prime factors."))
        file_ops(lines)
        return 0
    if (N == 2):
        lines.append((str(N) + " is the only prime factor of itself."))
        file_ops(lines)
        return 0

    quad_sieve(N, B)


if __name__ == '__main__':
    main()
