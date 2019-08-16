// C++ program for Check whether a number can be 
// represented by sum of two squares using binary search. 
#include<iostream> 
#include<cmath> 
using namespace std; 

// Function for binary search. 
bool binary_search(int num2, int se, int num, int k) 
{ 
	int mid; 
	int ss=0; 

	while(ss<=se) 
	{ 
		// Calculating mid. 
		mid=(ss+se)/2; 
		if (pow(num2,2) - (pow(mid,2))==num) 
		{ 
			return true; 
		} 
		else if ((pow(num2,2) - (pow(mid,2))) >num )
		{ 
			se=mid-1; 
		} 
		else
		{ 
			ss=mid+1; 
		} 
	} 
	return false; 
} 

// Driver code 
int main() 
{ 
	int rt; 
	int num=203299; 
    int k = 3;
	rt=sqrt(num); 
	bool flag=false; 
	for (int i = rt; i >=0; --i) 
	{ 
		if (binary_search(i,i,num, k)) 
		{ 
			flag=true; 
			break; 
		} 
	} 
	if (flag) 
	{ 
		cout<<"true"; 
	} 
	else cout<<"false"; 
	return 0; 
} 
