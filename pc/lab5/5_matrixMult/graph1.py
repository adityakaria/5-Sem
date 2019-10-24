import matplotlib.pyplot as plt
import sys


def main():
    x_axis, y_axis = [], []

    with open('/Users/adityakaria/code/5-Sem/pc/lab5/5_matrixMult/op5_1.txt', 'r') as f:
        lines = f.readlines()
        for line in lines:
            listx = line.split()
            x_axis.append(int(listx[0]))
            y_axis.append(float(listx[1]))
            pass

    plt.plot(x_axis, y_axis)
    plt.xlabel('block dimension')
    plt.ylabel('Execution time (s)')

    plt.show()


if __name__ == '__main__':
    main()
