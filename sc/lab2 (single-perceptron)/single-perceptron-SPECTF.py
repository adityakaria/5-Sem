import csv
import random
import csv
import math
import os

# Load a CSV file


prec = []
rec = []
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
        row[column] = float(row[column].strip())

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

# Split a dataset into k folds


def cross_validation_split(dataset, n_folds):
    dataset_split = list()
    dataset_copy = list(dataset)
    fold_size = int(len(dataset) / n_folds)
    for i in range(n_folds):
        fold = list()
        while len(fold) < fold_size:
            index = random.randrange(len(dataset_copy))
            fold.append(dataset_copy.pop(index))
        dataset_split.append(fold)
    return dataset_split

# Calculate accuracy percentage


def accuracy_metric(actual, predicted):
    correct = 0
    for i in range(len(actual)):
        if actual[i] == predicted[i]:
            correct += 1
        true_positive = 0
        false_positive = 0
        true_negative = 0
        false_negative = 0
        if actual[i] == 1 and predicted[i] == 1:
            true_positive += 1
        if actual[i] == 1 and predicted[i] == 0:
            false_negative += 1
        if actual[i] == 0 and predicted[i] == 1:
            false_positive += 1
        if actual[i] == 0 and predicted[i] == 0:
            true_negative += 1
    prec.append([true_positive, true_negative, false_positive, false_negative])
    return correct / float(len(actual)) * 100.0

# Make a prediction with weights


def predict(row, weights):
    activation = weights[0]
    for i in range(len(row)-1):
        activation += weights[i + 1] * row[i]
    return 1.0 if activation >= 0.0 else 0.0

# Estimate Perceptron weights using stochastic gradient descent


def train_weights(train, l_rate, n_epoch):
    weights = [round(random.uniform(0, 1), 2) for i in range(len(train[0]))]
    for epoch in range(n_epoch):
        # print("epoch ", epoch)
        for row in train:
            prediction = predict(row, weights)
            # print("\tweights:", weights)
            # print("\ty:", prediction, "--- z:", row[-1])
            error = row[-1] - prediction
            weights[0] = weights[0] + l_rate * error
            for i in range(len(row)-1):
                weights[i + 1] = weights[i + 1] + l_rate * error * row[i]
    return weights

# Perceptron Algorithm With Stochastic Gradient Descent


def perceptron(train, test, l_rate, n_epoch):
    predictions = list()
    weights = train_weights(train, l_rate, n_epoch)
    for row in test:
        prediction = predict(row, weights)
        predictions.append(prediction)
    return(predictions)

# Evaluate an algorithm using a cross validation split


def evaluate_algorithm(dataset, algorithm, n_folds, *args):
    folds = cross_validation_split(dataset, n_folds)
    scores = list()
    for fold in folds:
        train_set = list(folds)
        train_set.remove(fold)
        train_set = sum(train_set, [])
        test_set = list()
        for row in fold:
            row_copy = list(row)
            test_set.append(row_copy)
            row_copy[-1] = None
        predicted = algorithm(train_set, test_set, *args)
        actual = [row[-1] for row in fold]
        accuracy = accuracy_metric(actual, predicted)
        scores.append(accuracy)
    return scores

# Driver


def main():
    filename = "/home/student/203/5-Sem/sc/lab2 (single-perceptron)/SPECTF.csv"
    attributes = []
    dataset = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        # attributes = csvreader.next()
        for row in csvreader:
            row = row[1:] + [1 if row[0] == "Yes" else 0]
            # print(row)
            dataset.append(row)
    attributes = dataset[0]
    dataset = dataset[1:]
    for i in range(len(dataset[0])-1):
        str_column_to_float(dataset, i)
    str_column_to_int(dataset, len(dataset[0])-1)
    # for i in range(len(dataset)):
    #     print(dataset[i])
    n_folds = 10
    l_rate = 0.3
    n_epoch = 500
    scores = evaluate_algorithm(dataset, perceptron, n_folds, l_rate, n_epoch)
    print('Scores:')
    for i in range(len(scores)):
        print(i+1, ": ", scores[i])
    print('Mean Accuracy: %.3f%%' % (sum(scores)/float(len(scores))))
    ttp = 0
    ttn = 0
    tfp = 0
    tfn = 0
    for i in range(len(prec)):
        ttp += prec[i][0]
        ttn += prec[i][1]
        tfp += prec[i][2]
        tfn += prec[i][3]
    print(ttp, ttn, tfp, ttn)
    print('Precision: ', ttp / (ttp + tfp))
    print('Recall: ', ttp / (ttp + tfn))


if __name__ == '__main__':
    main()
