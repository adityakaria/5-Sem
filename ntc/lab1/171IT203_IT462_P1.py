import random

def miller(n,m,k):
	a = random.randint(2,n-2)
	x = pow(a,m)%n
	if (x==1) or (x==n-1):
		return True

	for i in range(k-1):
		x = (x*x)%n
		m *= 2

		if (x==1):
			return False
		if (x==n-1):
			return True

	return False

def main():
	n = int(input("Enter any positive integer: "))

	# Base cases:

	if (n < 1):
		print(n,"is not positive! Terminating")
		return 0

	if (n == 1):
		print(n,"is not prime.")
		return 0

	if (n == 2) or (n == 3):
		print(n,"is prime.")
		return 0

	if (n > 2) and (n%2 == 0):
		print(n,"is even and greater than 2 => not prime.")
		return 0

	m = n-1
	k = 0
	while(m%2):
		m = m/2
		k += 1

	if (miller(n,m,k)):
		print(n,"is prime.")
	else:
		print(n,"is not prime.")

if __name__=='__main__':
	main()