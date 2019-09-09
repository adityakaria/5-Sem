import pandas as pd
import csv
import math
import random

# Plain Naive bayes


def train(train_set, test_set):
    len_features = len(train_set[0])
    n_yes = 0
    n_no = 0
    yes_string = 'Yes'
    no_string = 'No'

    for i in range(len(train_set)):
        if train_set[i][-1] == yes_string:
            n_yes += 1
        elif train_set[i][-1] == no_string:
            n_no += 1

    prob_yes = float(n_yes/(n_yes+n_no))
    prob_no = float(n_no/(n_yes+n_no))

    f1_yes = [0]*(len_features)
    f1_no = [0]*(len_features)
    f0_no = [0]*(len_features)
    f0_yes = [0]*(len_features)

    for j in range(len(train_set)):
        for i in range(0, len_features):
            if train_set[j][i] == '1' and train_set[j][-1] == yes_string:
                f1_yes[i] += 1
            elif train_set[j][i] == '1' and train_set[j][-1] == no_string:
                f1_no[i] += 1
            elif train_set[j][i] == '0' and train_set[j][-1] == yes_string:
                f0_yes[i] += 1
            elif train_set[j][i] == '0' and train_set[j][-1] == no_string:
                f0_no[i] += 1

    for i in range(len(f1_yes)):
        f1_no[i] = f1_no[i]/float(n_no)
        f1_yes[i] = f1_yes[i]/float(n_yes)
        f0_no[i] = f0_no[i]/float(n_no)
        f0_yes[i] = f0_yes[i]/float(n_yes)

    accuracy = 0

    for j in range(len(test_set)):
        yes_p = prob_yes
        no_p = prob_no
        for i in range(0, len_features):
            if test_set[j][i] == '0':
                yes_p *= f0_yes[i]
                no_p *= f0_no[i]
            elif test_set[j][i] == '1':
                yes_p *= f1_yes[i]
                no_p *= f1_no[i]

        if yes_p > no_p:
            max_prob = yes_string
        else:
            max_prob = no_string

        if test_set[j][-1] == max_prob:
            accuracy += 1

    result = float(accuracy/len(test_set))
    result *= 100
    return result


def fold(dataset, i, k):
    l = len(dataset)
    start_index_test = l*(i-1)//k
    end_index_test = l*i//k
    if start_index_test == 0:
        start_index_train = end_index_test
        end_index_train = l
        return [dataset[start_index_train:end_index_train], dataset[start_index_test:end_index_test]]
    elif end_index_test == l:
        start_index_train = 0
        end_index_train = start_index_test
        return [dataset[start_index_train:end_index_train], dataset[start_index_test:end_index_test]]
    else:
        start_index_train_first = 0
        end_index_train_first = start_index_test
        start_index_train_second = end_index_test
        end_index_train_second = l
        new_dataset = []
        for i in range(start_index_test):
            new_dataset.append(dataset[i])
        for j in range(end_index_test, l):
            new_dataset.append(dataset[j])

        return [new_dataset, dataset[start_index_test:end_index_test]]


def naive_bayes_classifier(dataset, len_features, chromosome):
    rows = []
    k = 10
    avg_acc = 0.0

    # change based on dataset, 0 or -1
    class_index = 0

    for row in dataset:
        # print(row)
        new_row = []
        if class_index == -1:
            new_row = [row[i]
                       for i in range(0, len_features) if (chromosome[i] == 1)]
            class_ele = row[class_index]
        else:
            new_row = [row[i+1]
                       for i in range(0, len_features) if (chromosome[i] == 1)]
            class_ele = row[class_index]
        new_row.append(class_ele)
        rows.append(new_row)

    random.shuffle(rows)

    # assume classes are at end
    for i in range(1, k+1):
        after_fold = fold(rows, i, k)
        train_set = after_fold[0]
        test_set = after_fold[1]

        # print(train_set[0])
        acc = train(train_set, test_set)
        avg_acc += acc

    avg_acc /= 10

    return avg_acc


def selection(fitness):
    total = sum(fitness)
    probability = [(f/total) for f in fitness]
    probability.insert(0, 0.0)
    cumulation = [probability[0]]
    for i in range(1, len(probability)):
        cumulation.append(probability[i] + cumulation[-1])

    selection_ranks = []

    pred_rand = [random.uniform(0, 1) for i in range(len(fitness))]

    for pred in pred_rand:
        for i in range(1, len(cumulation)):
            if (pred > cumulation[i-1]) and (pred < cumulation[i]):
                selection_ranks.append(i-1)
                break

    return selection_ranks


def crossover(chromosomes):
    len_chromosome = len(chromosomes[0])
    no_of_chromosomes = len(chromosomes)
    for i in range(no_of_chromosomes//2):
        chromosome_1 = chromosomes[i]
        chromosome_2 = chromosomes[i+1]
        # swap the last 25% of both
        start_index = int((3*len_chromosome)/4)
        for i in range(start_index, len_chromosome):
            chromosome_1[i], chromosome_2[i] = chromosome_2[i], chromosome_1[i]


def mutation(chromosomes):
    len_chromosome = len(chromosomes[0])
    # no_of_flips = len(len_chromosome/10)
    no_of_flips = 2
    for chromosome in chromosomes:
        for i in range(no_of_flips):
            index = random.randint(0, len_chromosome-1)
            chromosome[index] = (chromosome[index] + 1) % 2


def genetic_algorithm(pop_size, num_features, dataset, len_features):
    # Generating initial chromosomes
    old_chromosomes = [
        [random.randint(0, 1) for i in range(num_features)] for j in range(pop_size)
    ]

    k = 1
    best_chromosome = [0 for i in range(num_features)]
    best_fitness = 0.0
    same_acc = 0
    while (k < 100):
        fitness = []
        for chromosome in old_chromosomes:
            acc = naive_bayes_classifier(dataset, len_features, chromosome)

            if(acc > best_fitness):
                same_acc = 0
                # print(k)
                best_fitness = acc
                best_chromosome = chromosome
            else:
                same_acc += 1
            fitness.append(acc)

        selection_ranks = selection(fitness)
        new_chromosomes = [old_chromosomes[rank][::]
                           for rank in selection_ranks]
        crossover(new_chromosomes)

        mutation(new_chromosomes)

        k += 1

    # print('final', best_chromosome, best_fitness)
    return best_fitness


def main():
    filename = 'SPECT.csv'
    features = []
    dataset = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        features = next(csvreader)
        for row in csvreader:
            dataset.append(row)

    len_features = len(features) - 1

    test_chromosome = [1 for i in range(len_features)]
    print('NB Without GA: ')
    print('\tAccuracy: ', naive_bayes_classifier(
        dataset, len_features, test_chromosome))

    print('NB using GA: ')
    print('\tAccuracy: ', genetic_algorithm(
        30, len_features, dataset, len_features))


if __name__ == '__main__':
    main()
