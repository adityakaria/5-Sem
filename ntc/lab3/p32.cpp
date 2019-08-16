#include <bits/stdc++.h> 
using namespace std; 

bool sumSquare(int n) 
{ 
	for (long i = 1; i * i <= n; i++) 
		for (long j = 1; j * j <= n; j++) 
			if (i * i + j * j == n) { 
				cout << i << "^2 + "
					<< j << "^2" << endl; 
				return true; 
			} 
	return false; 
} 

int main() 
{ 
    int k, n;
	int n = 25; 
    int k = 3;
	if (sumSquare(n)) 
		cout << "Yes"; 
	else
		cout << "No"; 
} 
