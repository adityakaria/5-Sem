import random
import csv
import math
import sys
import numpy as np
from operator import add


def find_dist(row, centroid):
    result = 0
    for i in range(len(row)):
        result += math.pow(row[i]-centroid[i], 2)
    result = math.sqrt(result)
    return result


def fuzzy_clustering(dataset, n_attr, c, m):
    prev_centroids = [[random.uniform(0, 90)
                       for j in range(n_attr)] for i in range(c)]
    next_centroids = list()

    iterations = 0

    while iterations < 500:
        membership_matrix = [
            [0 for i in range(c)] for j in range(len(dataset))]
        clusters = [[] for i in range(c)]

        # Calculating membership matrix
        for row_index in range(len(dataset)):
            # hardcoding
            x_m_c1 = find_dist(dataset[row_index][:-1], prev_centroids[0])
            x_m_c2 = find_dist(dataset[row_index][:-1], prev_centroids[1])

            u_x_c1 = 1/(1 + math.pow(x_m_c1/x_m_c2, 2/(m-1)))
            u_x_c2 = 1/(1 + math.pow(x_m_c2/x_m_c1, 2/(m-1)))

            membership_matrix[row_index][0] = u_x_c1
            membership_matrix[row_index][1] = u_x_c2

            if u_x_c1 > u_x_c2:
                clusters[0].append(row_index)
            else:
                clusters[1].append(row_index)

        for cluster_index in range(len(clusters)):
            numerator = [0 for i in range(n_attr)]
            denominator = 0
            for row_index in clusters[cluster_index]:
                u_i_j_m = math.pow(
                    membership_matrix[row_index][cluster_index], m)
                num_temp = [x*u_i_j_m for x in dataset[row_index][:-1]]
                numerator = list(map(add, numerator, num_temp))
                denominator += u_i_j_m

            if denominator == 0:
                denominator = 1
            centroid = [math.floor(x/denominator) for x in numerator]
            next_centroids.append(centroid)

        if(prev_centroids == next_centroids):
            break

        prev_centroids = next_centroids[::]
        next_centroids = list()

    correct = 0
    incorrect = 0
    ttp = 0
    ttn = 0
    tfp = 0
    tfn = 0
    # Assuming first cluster is class 0, second is class 1
    for actual_class in range(len(clusters)):
        for row_index in clusters[actual_class]:
            if (dataset[row_index][-1] == actual_class):
                correct += 1
            else:
                incorrect += 1

            if actual_class == 1 and dataset[row_index][-1] == 1:
                # print("ttp")
                ttp += 1
            elif actual_class == 0 and dataset[row_index][-1] == 1:
                # print("tfp")
                tfp += 1
            elif actual_class == 0 and dataset[row_index][-1] == 0:
                # print("ttn")
                ttn += 1
            elif actual_class == 1 and dataset[row_index][-1] == 0:
                # print("tfn")
                tfn += 1

    # print(correct,incorrect)
    accuracy = correct / (incorrect+correct)
    scores = [accuracy, ttp, tfp, ttn, tfn]
    return scores


def main():
    filename = '/Users/adityakaria/code/5-Sem/sc/lab5 (k-means-clustering)/SPECTF.csv'
    dataset = []
    n_attr = 0

    with open(filename, 'r') as file:
        len_attributes = 0
        i = 0
        for line in file:
            if (i == 0):
                i = 1
                continue
            row_ = line.split(',')

            if(n_attr == 0):
                n_attr = len(row_) - 1

            if(len_attributes == 0):
                len_attributes = len(row_) - 1

            if row_[0] == 'No':
                row_[0] = '0.0'
            else:
                row_[0] = '1.0'

            # Use if class at start
            row_ = row_[1:] + [row_[0]]

            row = [float(x) for x in row_]
            dataset.append(row)

    c = 2
    m = 2

    scores = fuzzy_clustering(dataset, n_attr, c, m)
    accuracy = scores[0]
    if (accuracy < 0.5):
        accuracy = 1 - accuracy
    # print('Accuracy is ' + str(accuracy*100) + '%')
    print("\tRESULTS:\n----------------------------------------------\n")
    print("\tAccuracy: " + str(accuracy*100) + '%')
    print()
    print("\tTP:", scores[1], "\t", "FP: ", scores[2])
    print("\tTN:", scores[3], "\t\t", "FN:", scores[4])
    print()
    print('\tPrecision: ', scores[1] / (scores[1] + scores[2]))
    print('\tRecall: ', scores[1] / (scores[1] + scores[4]))


if __name__ == '__main__':
    main()
