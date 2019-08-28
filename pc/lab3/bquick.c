#include <omp.h>
#include <stdio.h> 
#include <stdlib.h>

#define lld long long int

// A utility function to swap two elements 
void swap(lld* a, lld* b) 
{ 
	lld t = *a; 
	*a = *b; 
	*b = t; 
} 

void printArray(lld arr[], lld size) 
{ 
	lld i; 
	for (i=0; i < size; i++) 
		printf("%lld ",arr[i]); 
	printf("\n"); 
} 

/* This function takes last element as pivot, places 
the pivot element at its correct position in sorted 
	array, and places all smaller (smaller than pivot) 
to left of pivot and all greater elements to right 
of pivot */
lld partition (lld arr[], lld low, lld high) 
{ 
	lld pivot = arr[high]; // pivot 
	lld i = (low - 1); // Index of smaller element 

	for (lld j = low; j <= high- 1; j++) 
	{ 
		// If current element is smaller than the pivot 
		if (arr[j] < pivot) 
		{ 
			i++; // increment index of smaller element 
			swap(&arr[i], &arr[j]); 
		} 
	} 
	swap(&arr[i + 1], &arr[high]); 
	return (i + 1); 
} 

/* The main function that implements QuickSort 
arr[] --> Array to be sorted, 
low --> Starting index, 
high --> Ending index */
void quickSort(lld arr[], lld low, lld high) 
{ 
	if (low < high) 
	{ 
		/* pi is partitioning index, arr[p] is now 
		at right place */
		lld pi = partition(arr, low, high); 

		// Separately sort elements before 
		// partition and after partition 
		quickSort(arr, low, pi - 1); 
		quickSort(arr, pi + 1, high); 
	} 
} 

/* The main function that implements QuickSort 
arr[] --> Array to be sorted, 
low --> Starting index, 
high --> Ending index */
void quickSortP(lld arr[], lld low, lld high) 
{ 
	if (low < high) 
	{ 
		// pi is partitioning index, arr[p] is now at right place
		lld pi;
		#pragma omp task shared(pi)
		pi = partition(arr, low, high); 

		// Separately sort elements before partition
		#pragma omp taskwait
		quickSortP(arr, low, pi - 1); 

		// Separately sort elements after partition
		#pragma omp taskwait
		quickSortP(arr, pi + 1, high); 
	} 
} 

/* Function to prlld an array */


lld check_correctness(lld arr[], lld n){
	lld i,error=0;
	for(i=0;i<n-1;++i){
		if(arr[i+1]<arr[i])
			++error;
	}
	return error;
}

// Driver program to test above functions 
lld main() 
{ 
	double start_time,time_taken;
	lld i,n,input,error;
	printf("Enter array size: ");
	scanf("%lld",&n);
	lld arr[n],arr2[n];
	// printf("Enter array elements one by one");

	for(i=0;i<n;++i){
		// scanf("%lld",&input);
		// arr[i] = input;
		// arr2[i] = input;
		arr[i] = n-i;
		arr2[i] = n-i;
	}

	start_time = omp_get_wtime();
	quickSort(arr, 0, n-1); 
	time_taken = omp_get_wtime()-start_time;
	error = check_correctness(arr,n);

	printf("Sorted array: \n"); 
	// printArray(arr, n); 
	printf("Time taken for serial approach is %lf s\n",time_taken);
	if(error)
		printf("Error obtained: %lld\n",error);
	else
		printf("The output obtained is correct and has no errors.\n");
	printf("\n");


	start_time = omp_get_wtime(); 
	quickSortP(arr2, 0, n-1); 
	time_taken = omp_get_wtime()-start_time;
	error = check_correctness(arr2,n);

	printf("Sorted array: \n"); 
	// printArray(arr2, n); 
	printf("Time taken for parallel approach is %lf s\n",time_taken);
	if(error)
		printf("Error obtained: %lld\n",error);
	else
		printf("The output obtained is correct and has no errors.\n");
	printf("\n");

	return 0; 
} 