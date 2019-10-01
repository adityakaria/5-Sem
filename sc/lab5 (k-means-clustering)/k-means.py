import csv
import random
import math

# Load csv file


def load_csv(filename):
    dataset = list()
    with open(filename, 'r') as file:
        csv_reader = reader(file)
        for row in csv_reader:
            if not row:
                continue
            dataset.append(row)
    return dataset


# Convert string column to float
def str_column_to_float(dataset, column):
    for row in dataset:
        row[column] = float(row[column])

# Convert string column to integer


def str_column_to_int(dataset, column):
    class_values = [row[column] for row in dataset]
    unique = set(class_values)
    lookup = dict()
    for i, value in enumerate(unique):
        lookup[value] = i
    for row in dataset:
        row[column] = lookup[row[column]]
    return lookup

# Intitialize Means


def initialize_means(n_clusters, n_dims):
    means = []
    for i in range(0, n_clusters):
        temp_l = list()
        for j in range(0, n_dims):
            temp_l.append(random.randrange(0, 100, 1))
        means.append(temp_l)
    return means

# Find distance between points


def calc_distance(x1, x2, n_dims):
    distance = 0
    for i in range(n_dims):
        distance += pow(x1[i] - x2[i], 2)
    return math.sqrt(distance)


def clusterify(dataset, means, n_dims):
    data_distance = list()
    for i in range(len(dataset)):
        temp_distance = list()
        temp_distance.append(calc_distance(
            means[0], dataset[i][:44], n_dims))
        temp_distance.append(calc_distance(
            means[1], dataset[i][:44], n_dims))
        if temp_distance[0] > temp_distance[1]:
            dataset[i][45] = 1
        else:
            dataset[i][45] = 0
    return dataset


def find_means(dataset, n_dims, n_clusters):
    means = list()
    for k in range(n_clusters):
        avg = list()
        for i in range(n_dims):
            avg.append(0)
        for i in range(len(dataset)):
            if dataset[i][45] == k:
                for j in range(n_dims):
                    avg[j] += dataset[i][j]
            else:
                continue

        for i in range(n_dims):
            avg[i] = avg[i]/len(dataset)
        means.append(avg)
    return means


def find_accuracy(dataset, n_dims):
    n_t = 0
    n_f = 0
    for i in range(len(dataset)):
        if dataset[i][n_dims] == dataset[i][n_dims+1]:
            n_t += 1
        else:
            n_f += 1
    return n_t / len(dataset)


# Main algorithm


def evaluate_algorithm(dataset, n_clusters, n_epoch, n_dims):
    means = initialize_means(n_clusters, n_dims)
    print(means)
    for i in range(n_epoch):
        dataset = clusterify(dataset, means, n_dims)
        accuracy = find_accuracy(dataset, n_dims)
        # print(accuracy)
        means = find_means(dataset, n_dims, n_clusters)
        print(means)


# Driver


def main():
    filename = "/Users/adityakaria/code/5-Sem/sc/lab5 (k-means-clustering)/SPECTF.csv"
    attributes = []
    dataset = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        for row in csvreader:
            row = row[1:] + [1 if row[0] == "Yes" else 0] + [2]
            # print(row)
            dataset.append(row)
    attributes = dataset[0]
    dataset = dataset[1:]
    for i in range(len(dataset[0])-1):
        str_column_to_float(dataset, i)
    str_column_to_int(dataset, len(dataset[0])-2)
    str_column_to_int(dataset, len(dataset[0])-1)
    # for i in range(len(dataset)):
    #     print(dataset[i])
    n_epoch = 500
    n_clusters = 2
    n_dims = 44

    scores = evaluate_algorithm(dataset, n_clusters, n_epoch, n_dims)
    # print('Scores:')
    # for i in range(len(scores)):
    #     print(i+1, ": ", scores[i])
    # print('Mean Accuracy: %.3f%%' % (sum(scores)/float(len(scores))))
    # ttp = 0
    # ttn = 0
    # tfp = 0
    # tfn = 0
    # for i in range(len(prec)):
    #     ttp += prec[i][0]
    #     ttn += prec[i][1]
    #     tfp += prec[i][2]
    #     tfn += prec[i][3]
    # print(ttp, ttn, tfp, ttn)
    # print('Precision: ', ttp / (ttp + tfp))
    # print('Recall: ', ttp / (ttp + tfn))


if __name__ == '__main__':
    main()
