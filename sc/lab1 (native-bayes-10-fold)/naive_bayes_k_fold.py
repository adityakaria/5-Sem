import csv
import math


def train(Rows, attributes, test_set):
    nyes = 0
    nno = 0
    for i in range(len(Rows)):
        if Rows[i][0] == "Yes":
            nyes += 1
        if Rows[i][0] == "No":
            nno += 1

    proYes = float(nyes)/(nyes+nno)
    proNo = float(nno)/(nyes+nno)

    p1yes = [0]*(len(attributes)-1)
    p1no = [0]*(len(attributes)-1)
    p0no = [0]*(len(attributes)-1)
    p0yes = [0]*(len(attributes)-1)
    for j in range(len(Rows)):
        for i in range(1, len(attributes)):
            if Rows[j][i] == '1' and Rows[j][0] == "Yes":
                p1yes[i-1] += 1
            if Rows[j][i] == '1' and Rows[j][0] == "No":
                p1no[i-1] += 1
            if Rows[j][i] == '0' and Rows[j][0] == "Yes":
                p0yes[i-1] += 1
            if Rows[j][i] == '0' and Rows[j][0] == "No":
                p0no[i-1] += 1

    for i in range(len(p1yes)):
        p1no[i] = p1no[i]/float(nno)
        p1yes[i] = p1yes[i]/float(nyes)
        p0no[i] = p0no[i]/float(nno)
        p0yes[i] = p0yes[i]/float(nyes)

    acc = 0
    for j in range(len(test_set)):
        yes_p = proYes
        no_p = proNo
        for i in range(1, len(attributes)):
            if test_set[j][i] == '0':
                yes_p *= p0yes[i-1]
                no_p *= p0no[i-1]
            elif test_set[j][i] == '1':
                yes_p *= p1yes[i-1]
                no_p *= p1no[i-1]

        if yes_p > no_p:
            max_prob = 'Yes'
        else:
            max_prob = 'No'
        if test_set[j][0] == max_prob:
            acc += 1

    result = float(acc)/len(test_set)
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


def main():
    filename = "/Users/adityakaria/code/5-Sem/sc/lab1 (native-bayes-10-fold)/IRIS.csv"
    attributes = []
    rows = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)

        # attributes = csvreader.next()
        for row in csvreader:
            rows.append(row)
    k = 10
    accuracy = []
    rows = rows[1:]
    avg_acc = 0.0

    for i in range(1, k+1):
        after_fold = fold(rows, i, k)
        train_set = after_fold[0]
        test_set = after_fold[1]
        acc = train(train_set, attributes, test_set)
        accuracy.append(acc)
    print("The Accuracy for each fold is as follows : ")
    numb = 1
    for i in accuracy:
        print(numb, math.ceil(i))
        avg_acc = avg_acc + float(math.ceil(i))
        numb += 1
    avg_acc = avg_acc/10

    print("Average accuracy is " + str(avg_acc))


if __name__ == '__main__':
    main()
