#!/bin/bash
gcc-9 strongly_scalable_matrix_multiplication.c -fopenmp -o strongly_scalable_matrix_multiplication
./strongly_scalable_matrix_multiplication
gcc-9 weakly_scalable_pi_computation.c -fopenmp -o weakly_scalable_pi_computation
./weakly_scalable_pi_computation
# python3 graph1.py
# python3 graph2.py