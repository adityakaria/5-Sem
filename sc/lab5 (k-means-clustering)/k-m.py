import random
import csv
import math
import sys
import numpy as np


def find_least_dist_cluster(centroids, x):
    least_dist = sys.maxsize
    cluster = -1

    j = 0
    for c in centroids:
        dist = 0
        for i in range(len(c)):
            dist += math.floor(math.pow(x[i] - c[i], 2))
        dist = math.floor(math.sqrt(dist))
        if dist < least_dist:
            least_dist = dist
            cluster = j
        j += 1

    return cluster


def kmeans(rows, n_attr, k):
    old_centroids = [[random.randrange(0, 100)
                      for j in range(n_attr)] for i in range(k)]
    new_centroids = list()

    iterations = 0

    while iterations < 500:
        clusters = [[] for i in range(k)]

        for row_index in range(len(rows)):
            cluster_index = find_least_dist_cluster(
                old_centroids, rows[row_index])
            clusters[cluster_index].append(row_index)

        for cluster in clusters:
            rows_in_cluster = []
            for row_index in cluster:
                rows_in_cluster.append(rows[row_index][:-1])

            np_arr = np.array(rows_in_cluster)
            centroid_float = list(np.floor(np.average(np_arr, 0)))
            centroid = [int(x) for x in centroid_float]
            new_centroids.append(centroid)

        if(old_centroids == new_centroids):
            break

        old_centroids = new_centroids[::]
        new_centroids = list()

    correct = 0
    incorrect = 0
    # Assuming first cluster is class 0, second is class 1
    for actual_class in range(len(clusters)):
        for row_index in clusters[actual_class]:
            if (rows[row_index][-1] == actual_class):
                correct += 1
            else:
                incorrect += 1

    # print(correct,incorrect)

    return (correct/(incorrect+correct))


def main():
    filename = "/Users/adityakaria/code/5-Sem/sc/lab5 (k-means-clustering)/SPECTF.csv"
    rows = []
    n_attr = 0
    with open(filename, 'r') as file:
        flag = 0
        for line in file:
            if (flag == 0):
                flag = 1
                continue
            row_ = line.split(',')

            if(n_attr == 0):
                n_attr = len(row_) - 1

            if row_[0] == 'Yes':
                row_[0] = 1
            else:
                row_[0] = 0

            row_ = row_[1:] + [row_[0]]

            row = [int(x) for x in row_]
            rows.append(row)

    k = 2

    accuracy = kmeans(rows, n_attr, k)
    print('Accuracy is ' + str(accuracy*100) + '%')


if __name__ == '__main__':
    main()
