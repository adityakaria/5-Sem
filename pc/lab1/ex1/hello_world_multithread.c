#include <stdio.h>
#include "omp.h"

int* modify_arr(int *arr, int i) {
    printf("\t%d\n", i);
    printf("%d", i);
    arr[i] = 1;    
}

int main(void) {
    int arr[1000] = {0};
    
    #pragma omp parallel num_threads(6)
    {
        int ID = omp_get_thread_num();
        // int ID = 0;
        // printf("HELLO(%d)", ID);
        // printf("WORLD(%d)\n", ID);
        modify_arr(arr, ID);
    }
    return 0;
}