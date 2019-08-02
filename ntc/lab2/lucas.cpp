#include <bits/stdc++.h> 
using namespace std; 
#define ll long long
 
void primeFactors(ll n, vector<ll>& factors);
string lucasTest(ll n);
ll modular_exponentiation(ll base, ll exponent, int modulus);

int main(void) { 
    cout << "-------------------" << endl;
	cout << 2047 << ": " << lucasTest(2047) << endl; 
    cout << "-------------------" << endl;
	cout << 65537 << ": " << lucasTest(65537) << endl; 
    cout << "-------------------" << endl;
	cout << 17 << ": " << lucasTest(17) << endl; 
    cout << "-------------------" << endl;
	cout << 561 << ": " << lucasTest(561) << endl; 
    cout << "-------------------" << endl;
	cout << 1117 << ": " << lucasTest(1117) << endl; 
    cout << "-------------------" << endl;
	return 0; 
} 


string lucasTest(ll n) {
    cout << "\n\tTesting for " << n  << "...." << endl;
    if (n <= 0)
        return "Error: not a positive number";
	if (n == 1) 
		return "Result: neither prime nor composite"; 
	if (n == 2) 
		return "Result: prime"; 
	if (n % 2 == 0) 
		return "Result: composite"; 

	vector<ll> factors; 
	primeFactors(n - 1, factors);
    cout << "\t- Prime factors of " << n-1 <<  " are:  ";
    for (int i = 0; i < factors.size(); i++) {
        if (i == 0) {
             cout << factors[i];
        }
        else {
            cout << ", " << factors[i];
        }
    }
    cout << endl;
	ll random[n - 3]; 
	for (ll i = 0; i < n - 2; i++) 
		random[i] = i + 2; 
		
	shuffle(random, random + n - 3, default_random_engine(time(0))); 

	for (ll i = 0; i < n - 2; i++) { 
		ll a = random[i]; 
        cout << "\t- Random No. (a): = " << a << endl;
        cout << "\t  -> LHS = a^(n-1)mod(n) = " << modular_exponentiation(a, n - 1, n);
		if (modular_exponentiation(a, n - 1, n) != 1) {
			cout << " (!= 1)" << endl;
            return "Result: composite"; 
        }
        cout << endl;
		bool flag = true; 
        // cout << "\tfactors.size(): " << factors.size() << endl;
		for (int k = 0; k < factors.size(); k++) { 
			// if a^((n-1)/q) equal 1 
            cout << "\t\t-> "  << "q: " << factors[k] << ", RHS = " << modular_exponentiation(a, (n - 1) / factors[k], n) <<   endl;
			if (modular_exponentiation(a, (n - 1) / factors[k], n) == 1) { 
				flag = false; 
				break; 
			} 
		} 

		if (flag) 
			return "Result: prime"; 
	} 
	return "Result: probably composite"; 
} 

void primeFactors(ll n, vector<ll>& factors) { 
	// if 2 is a factor 
	if (n % 2 == 0) 
		factors.push_back(2); 
	while (n % 2 == 0) 
		n = n / 2; 
		
	// if prime > 2 is factor 
	for (ll i = 3; i <= sqrt(n); i += 2) { 
		if (n % i == 0) 
			factors.push_back(i); 
		while (n % i == 0) 
			n = n / i; 
	} 
	if (n > 2) 
	factors.push_back(n); 
} 

ll modular_exponentiation(ll base, ll exponent, int modulus) {
    ll result = 1;
    while (exponent > 0) {
        if (exponent % 2 == 1)
            result = (result * base) % modulus;
        exponent = exponent >> 1;
        base = (base * base) % modulus;
    }
    return result;
}