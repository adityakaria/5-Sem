#include <bits/stdc++.h> 
using namespace std; 
int modExp(int x, unsigned int y, int p);
bool mainTest(int d, int n);
bool checkPrime(int n, int k);

int main() { 
	int k = 4;
    int n;
    cout << "Enter Number to test for primarility:\t";
    cin >> n;
    if (checkPrime(n, k)) 
		cout << "Prime" << endl;
    else
		cout << "Not Prime" << endl;
	

	return 0; 
} 

int modExp(int x, unsigned int y, int p) { 
	int res = 1;
	x = x % p;
	while (y > 0) {
		if (y & 1) 
			res = (res*x) % p; 
		y = y>>1;
		x = (x*x) % p; 
	} 
	return res; 
} 

bool mainTest(int d, int n) {
	int a = 2 + rand() % (n - 4); 
	int x = modExp(a, d, n);
	if (x == 1 || x == n-1) 
	return true; 

	while (d != n-1) { 
		x = (x * x) % n; 
		d *= 2; 
		if (x == 1)	 return false; 
		if (x == n-1) return true; 
	} 

	// Return composite 
	return false; 
} 

bool checkPrime(int n, int k) { 
	if (n <= 1) return false; 
	if (n == 4) return false; 
	if (n <= 3) return true; 

	int d = n - 1;
	while (d % 2 == 0)
		d /= 2;

	for (int i = 0; i < k; i++) 
		if (!mainTest(d, n)) 
			return false; 

	return true; 
} 