/*
**  PROGRAM: Quick sort
**
**  PURPOSE: This is a program to sort an array using the Quick sort algorithm.
**           Quick sort sorts an array by picking a pivot element and swapping elements to the left of it with elements to the right, if elements on the left are greater than pivot.
**			 The first two numbers in the series are 0 and 1.
**           Example of the first 10 numbers in the Fibonacci series:
**
**                0,1,1,2,3,5,8,13,21,34
**
**           We use a recursive function to find the previous two elements, taking n as input. 
**           If n goes below 2, then we return n.
**           Else, we return the sum of the values returned by the functions taking n-1 and n-2 as input.
**
**  USAGE:   cd "/path/to/file" && gcc-<your_version> <filename>.c -fopenmp -o <filename> && ./<filename>;
**
**  HISTORY: Written by Aditya J Karia, Aug 2019
*/
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

// Macros
#define lld long long int

// Function Declarations
lld check_correctness(lld arr[], lld n);
void swap(lld *a, lld *b);
void printArray(lld arr[], lld size);
void quickSort(lld arr[], lld low, lld high);
void quickSort_parallel(lld arr[], lld low, lld high);

// Driver program to test above functions
int main()
{
	double start_time, time_taken;
	lld i, n, input, error;

	// initialize array size
	printf("Enter array size: ");
	scanf("%lld", &n);
	lld arr[n], arr2[n];

	// Initialize array contents
	for (i = 0; i < n; ++i)
	{
		arr[i] = n - i;
		arr2[i] = n - i;
	}

	// Serial snippet
	start_time = omp_get_wtime();
	quickSort(arr, 0, n - 1);
	time_taken = omp_get_wtime() - start_time;
	error = check_correctness(arr, n);

	// Error Checking
	printf("Time taken for serial approach is %lf s\n", time_taken);
	if (error)
		printf("Error obtained\n");
	else
		printf("Checked for correctness\n");
	printf("\n");

	// Parallel Snippet
	start_time = omp_get_wtime();
	quickSort_parallel(arr2, 0, n - 1);
	time_taken = omp_get_wtime() - start_time;
	error = check_correctness(arr2, n);

	// Error Checking
	printf("Time taken for parallel approach is %lf s\n", time_taken);
	if (error)
		printf("Error obtained\n");
	else
		printf("Checked for correctness\n");
	printf("\n");

	// End of main function
	return 0;
}

// A function to swap two long long int elements given their pointers
void swap(lld *a, lld *b)
{
	lld t = *a;
	*a = *b;
	*b = t;
}

// Program to print an array
void printArray(lld arr[], lld size)
{
	lld i;
	for (i = 0; i < size; i++)
		printf("%lld ", arr[i]);
	printf("\n");
}

/* This function takes last element as pivot, places 
the pivot element at its correct position in sorted 
	array, and places all smaller (smaller than pivot) 
to left of pivot and all greater elements to right 
of pivot */
lld partition(lld arr[], lld low, lld high)
{
	lld pivot = arr[high]; // pivot
	lld i = (low - 1);	 // Index of smaller element

	for (lld j = low; j <= high - 1; j++)
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
void quickSort_parallel(lld arr[], lld low, lld high)
{
	if (low < high)
	{

		lld pi;
#pragma omp task shared(pi)
		pi = partition(arr, low, high);

#pragma omp taskwait
		quickSort_parallel(arr, low, pi - 1);
		printf("%d\n", omp_get_thread_num());

#pragma omp taskwait
		quickSort_parallel(arr, pi + 1, high);
		printf("%d\n", omp_get_thread_num());
	}
}

/* Function to check if an array is sorted rightly or not an array */
lld check_correctness(lld arr[], lld n)
{
	lld i, error = 0;
	for (i = 0; i < n - 1; ++i)
	{
		if (arr[i + 1] < arr[i])
			return 1;
	}
	return 0;
}
