import csv
import random
import math

POPULATION_SIZE = 30
SELECTION_RATE = 0.95
CROSSOVER_RATE = 0.25
MUTATION_RATE = 0.1


def loadCsv(filename, start, end):
    lines = csv.reader(open(filename, "r"))
    dataset = list(lines)
    dataset = dataset[1:]
    for i in range(len(dataset)):
        for j in range(start, end):
            dataset[i][j] = float(dataset[i][j])

    # print(dataset)
    return dataset


def splitDataset(dataset, start, end):
    yCount, nCount = 0, 0
    test = dataset[start:end]
    trainSet = dataset[:start] + dataset[end:]
    for i in range(len(trainSet)):
        if trainSet[i][len(dataset[0])-1] in ["Yes", "Iris-setosa"]:
            yCount += 1
        else:
            nCount += 1
    if yCount == 0 or nCount == 0:
        return (None, None, yCount, nCount)
    return (trainSet, test, yCount, nCount)


def population(attributeLength):
    chromosomes = [[1 if random.random() > 0.5 else 0 for _ in range(
        attributeLength)] for _ in range(POPULATION_SIZE)]
    return chromosomes


def crossover(chromosomes, originalChromosomes):
    POINT_OF_CROSSOVER = random.randint(1, len(chromosomes[0])//2)
    maxPossible = int(len(chromosomes) * SELECTION_RATE)
    start = random.randint(
        0, maxPossible - int(math.ceil(maxPossible * CROSSOVER_RATE) - 1))
    end = min(start + int(math.ceil(start * CROSSOVER_RATE)) +
              1, len(chromosomes))
    # print("Crossover", start, end, POINT_OF_CROSSOVER, len(chromosomes))
    for q in range(0, len(chromosomes)//2):
        if q+1 >= end:
            break
        chromosome_1 = chromosomes[q]
        chromosome_2 = chromosomes[q+1]
        chromosome_1 = chromosome_1[:POINT_OF_CROSSOVER] + \
            chromosome_2[POINT_OF_CROSSOVER:]
        chromosome_2 = chromosome_2[:POINT_OF_CROSSOVER] + \
            chromosome_1[POINT_OF_CROSSOVER:]
        chromosomes[q+len(chromosomes)//2 - 1] = chromosome_1
        chromosomes[q+len(chromosomes)//2] = chromosome_2
    return chromosomes


def mutation(chromosomes):
    start = random.randint(0, len(chromosomes) -
                           int(len(chromosomes) * MUTATION_RATE) - 1)
    end = start + int(math.ceil(start * MUTATION_RATE))
    # print("Mutation",start, end)
    for i in range(start, end):
        index = random.randint(0, len(chromosomes[0])-1)
        # print("Index",index)
        chromosomes[i][index] = 0 if chromosomes[i][index] == 1 else 1
    return chromosomes


def featureSelection(start, classColumn, dataset, chromosome):
    datasetSelectedFeatures = []
    for j in range(len(dataset)):
        dataList = []
        for i in range(len(chromosome)):
            if chromosome[i] == 1:
                dataList.append(dataset[j][start+i])
        dataList.append(dataset[j][classColumn])
        datasetSelectedFeatures.append(dataList)
    return datasetSelectedFeatures


def constructFrequencyTable(dataset):
    frequencyTable = {}
    classColumn = len(dataset[0])-1
    for j in range(len(dataset[0])):
        # print("Attribute",j)
        for i in range(len(dataset)):
            if j not in frequencyTable:
                frequencyTable[j] = [1 for _ in range(4)]
            # print("Value",dataset[i][j], "Yes/No :",dataset[i][classColumn])
            if dataset[i][classColumn] == "Yes":
                if dataset[i][j] == 0:
                    frequencyTable[j][0] += 1
                else:
                    frequencyTable[j][1] += 1
            if dataset[i][classColumn] == "No":
                if dataset[i][j] == 0:
                    frequencyTable[j][2] += 1
                else:
                    frequencyTable[j][3] += 1
    # print(frequencyTable)
    return frequencyTable


def constructLikelihoodTable(frequencyTable):
    likelihoodTable = {}
    for k in frequencyTable.keys():
        if k not in likelihoodTable:
            likelihoodTable[k] = [0, 0, 0, 0]
        total = frequencyTable[k][0]+frequencyTable[k][1] + \
            frequencyTable[k][2]+frequencyTable[k][3]
        # P(0/Yes)
        likelihoodTable[k][0] = frequencyTable[k][0] / \
            (frequencyTable[k][0]+frequencyTable[k][1])
        # P(1/Yes)
        likelihoodTable[k][1] = frequencyTable[k][1] / \
            (frequencyTable[k][0]+frequencyTable[k][1])
        # P(0/No)
        likelihoodTable[k][2] = frequencyTable[k][2] / \
            (frequencyTable[k][2]+frequencyTable[k][3])
        # P(1/No)
        likelihoodTable[k][3] = frequencyTable[k][3] / \
            (frequencyTable[k][2]+frequencyTable[k][3])
    # print(likelihoodTable)
    return likelihoodTable


def predict(dataset, likelihoodTable, yCount, nCount):
    count = 0
    classColumn = len(dataset[0])-1
    for row in dataset:
        yes = 1
        no = 1
        for i in range(0, len(row)-1):
            if row[i] == 0:
                yes *= likelihoodTable[i][0]
            if row[i] == 1:
                yes *= likelihoodTable[i][1]
            if row[i] == 0:
                no *= likelihoodTable[i][2]
            if row[i] == 1:
                no *= likelihoodTable[i][3]
        # print(yes,no)
        yes *= (yCount)/(yCount+nCount)
        no *= (nCount)/(yCount+nCount)
        # print(yes,no)
        resYes = yes/(yes+no)
        resNo = no/(yes+no)
        if float(resYes) >= float(resNo):
            if row[classColumn] == "Yes":
                count += 1
        if float(resYes) < float(resNo):
            if row[classColumn] == "No":
                count += 1
    return count/len(dataset)*100


def runner(fileName, start, end, classColumn):
    EPOCH = 100
    CROSSFOLD_K = 10
    dataset = loadCsv(fileName, start, end)
    kFoldSize = len(dataset)//CROSSFOLD_K
    random.shuffle(dataset)
    chromosomes = population(end-start)
    totalAverage = 0
    for iteration in range(EPOCH):
        chromosomeFitness = []
        # print("Generation",iteration)
        for chromosome in chromosomes:
            selectedDataset = featureSelection(
                start, classColumn, dataset, chromosome)
            kFoldStart = 0
            accuracy = 0
            kFoldCount = 0
            for _ in range(CROSSFOLD_K):
                trainSet, test, yCount, nCount = splitDataset(
                    selectedDataset, kFoldStart, kFoldStart + kFoldSize)
                if trainSet is not None and test is not None:
                    kFoldCount += 1
                    frequencyTable = constructFrequencyTable(trainSet)
                    likelihoodTable = constructLikelihoodTable(frequencyTable)
                    accuracyForK = predict(
                        test, likelihoodTable, yCount, nCount)
                    accuracy += accuracyForK
                    # print("Iteration", kFoldCount, len(trainSet), len(test), accuracyForK)
                kFoldStart = kFoldStart+kFoldSize
            chromosomeFitness.append(
                (chromosome, accuracy/kFoldCount, len(selectedDataset[0])))
        originalChromosomeFitness = chromosomeFitness[:]
        chromosomeFitness.sort(key=lambda x: x[1], reverse=True)
        p = 1
        # for pair in chromosomeFitness:
        #     print(p,pair[2],pair[0], pair[1])
        #     p+=1
        average = 0
        for chromosome in chromosomeFitness:
            average += chromosome[1]
        average = average/len(chromosomeFitness)
        totalAverage += average
        # print("Average for this gen", average, chromosomeFitness[0][1])

        # Prepare for next generation
        chromosomes = [chromosome[0] for chromosome in chromosomeFitness]
        originalChromosomes = [chromosome[0]
                               for chromosome in originalChromosomeFitness]
        # Perform selection
        # chromosomes = chromosomes[:int(len(chromosomes) * SELECTION_RATE)]
        # print("Ok", len(chromosomes))
        if len(chromosomes) == 0:
            break
        # Perform crossover
        chromosomes = crossover(chromosomes, originalChromosomes)
        # Perform mutation
        chromosomes = mutation(chromosomes)
    print("Final Average :", totalAverage/EPOCH)


def spect():
    runner("SPECT.csv", 1, 23, 0)
    # runner("SPECTF.csv", 1, 45, 0)
    # runner("IRIS.csv", 0, 4, 4)


def main():
    spect()


if __name__ == "__main__":
    main()
