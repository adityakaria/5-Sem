import math
import quantumrandom
import random
import os
import sys
list = ['A', 'B', 'C', 'D']
dataset = []

f = open("dataset.csv", 'w')


for i in range(100):
    temp = []
    temp.append(int(quantumrandom.randint(0, 100)))
    temp.append(int(quantumrandom.randint(0, 100)))
    temp.append(random.choice(list))
    f.write(str(temp[0]) + ',')
    f.write(str(temp[1]) + ',')
    f.write(str(temp[2]) + '\n')
    print(temp)
    dataset.append(temp)
