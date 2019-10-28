import csv
import random
import math

# Load csv file


def load_csv(filename):
    dataset = []
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


def initialize_means(n_clusters, n_dims, dataset):
    """
    Initialize random means according to the number of clusters and dimensions in the dataset.

    Args:
    - n_custers (int): Number of clusters the data is to be divided into
    - n_dims (int): Number of attributes in the dataset.

    Return:
    - means (2-D Array): The intitialized random means
    """
    means = []
    for i in range(0, n_clusters):
        temp_l = []
        for j in range(0, n_dims):
            min = 50
            max = 50
            # temp_l.append(random.randrange(0, 90))
            for k in range(len(dataset)):
                if dataset[k][j] < min:
                    min = dataset[k][j]
                if dataset[k][j] > max:
                    max = dataset[k][j]
            if i == 0:
                temp_l.append(min)
            else:
                temp_l.append(max)
        means.append(temp_l)
    return means

# Find distance between points


def calc_distance(x1, x2, n_dims):
    distance = 0
    for i in range(n_dims):
        distance += math.floor(math.pow(x1[i] - x2[i], 2))
    return math.floor(math.sqrt(distance))


def clusterify(dataset, means, n_dims):
    for i in range(len(dataset)):
        temp_distance = []
        # print("comparing means[0] and dataset[i][:44]")
        # print(means[0])
        # print(dataset[i][:44])

        temp_distance.append(calc_distance(
            means[0], dataset[i][:n_dims], n_dims))
        temp_distance.append(calc_distance(
            means[1], dataset[i][:n_dims], n_dims))
        # print("comparing distances:", temp_distance[0], "OR", temp_distance[1])
        if temp_distance[0] > temp_distance[1]:
            dataset[i][n_dims+1] = 1
        else:
            dataset[i][n_dims+1] = 0
        # print(dataset[i][n_dims+1], "1=point1")
    return dataset


def find_means(dataset, n_dims, n_clusters):
    means = []
    for k in range(n_clusters):
        count = 0
        avg = []
        for i in range(n_dims):
            avg.append(0)
        for i in range(len(dataset)):
            if dataset[i][n_dims+1] == k:
                count += 1
                for j in range(n_dims):
                    avg[j] += dataset[i][j]
            else:
                continue

        for i in range(n_dims):
            avg[i] = avg[i]/count
        means.append(avg)
        # print("avg /\/\/\/\/\/\/\/\/\/\/\/\/\/\//\/\/\/\/\\//")
        # print(avg)
    return means


def find_accuracy(dataset, n_dims):
    n_t = 0
    n_f = 0
    for i in range(len(dataset)):
        if dataset[i][n_dims] == dataset[i][n_dims+1]:
            n_t += 1
        else:
            n_f += 1
    return n_t / (n_t + n_f)


# Main algorithm


def evaluate_algorithm(dataset, n_clusters, n_epoch, n_dims):
    means = initialize_means(n_clusters, n_dims, dataset)
    # print(means)

    for i in range(n_epoch):
        print("----------------------------epoch",
              i, "-------------------------")
        dataset = clusterify(dataset, means, n_dims)
        accuracy = find_accuracy(dataset, n_dims)
        old_means = means
        means = find_means(dataset, n_dims, n_clusters)
        # print(means)
        print("accuracy:", accuracy)
        if (old_means == means):
            print("convergence")
            print("final acc:", accuracy*100, "%")
            break


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
            # print(row)

    n_dims = len(dataset[0]) - 2
    attributes = dataset[0]
    dataset = dataset[1:]
    for i in range(len(dataset[0])-2):
        str_column_to_float(dataset, i)
    # str_column_to_int(dataset, len(dataset[0])-2)
    # str_column_to_int(dataset, len(dataset[0])-1)
    # for i in range(len(dataset)):
    #     print(dataset[i])
    # for i in range(len(dataset)):
        # print(dataset[i])
    n_epoch = 500
    n_clusters = 2
    # n_dims = 44

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
