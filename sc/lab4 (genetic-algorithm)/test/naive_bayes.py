import csv
import math
import random

# Global variables for Genetic Algorithm:

# Population:
POPULATION_SIZE = 100

# Valid genes
GENES = '''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890, .-;:_!"#%&/()=?@${[]}'''

# Target string to be generated
TARGET = "blah blah blah"


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


def bayes():
    filename = "/Users/adityakaria/code/5-Sem/sc/lab1 (native-bayes-10-fold)/SPECT.csv"
    attributes = []
    rows = []
    with open(filename, 'r') as csvfile:
        csvreader = csv.reader(csvfile)

        # attributes = csvreader.next()
        for row in csvreader:
            rows.append(row)
    k = 10
    row = row[1:]
    accuracy = []
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


class Individual(object):

    # Class representing individual in population
    def __init__(self, chromosome):
        self.chromosome = chromosome
        self.fitness = self.cal_fitness()

    @classmethod
    def mutated_genes(self):
        # create random genes for mutation
        global GENES
        gene = random.choice(GENES)
        return gene

    @classmethod
    def create_gnome(self):
        # create chromosome or string of genes
        global TARGET
        gnome_len = len(TARGET)
        return [self.mutated_genes() for _ in range(gnome_len)]

    def mate(self, par2):
        # Perform mating and produce new offspring chromosome for offspring
        child_chromosome = []
        for gp1, gp2 in zip(self.chromosome, par2.chromosome):

            # random probability
            prob = random.random()

            # if prob is less than 0.45, insert gene
            # from parent 1
            if prob < 0.45:
                child_chromosome.append(gp1)

            # if prob is between 0.45 and 0.90, insert
            # gene from parent 2
            elif prob < 0.90:
                child_chromosome.append(gp2)

            # otherwise insert random gene(mutate),
            # for maintaining diversity
            else:
                child_chromosome.append(self.mutated_genes())

        # create new Individual(offspring) using
        # generated chromosome for offspring
        return Individual(child_chromosome)

    def cal_fitness(self):
        # Calculate fittness score, it is the number of characters in string which differ from target string.
        global TARGET
        fitness = 0
        for gs, gt in zip(self.chromosome, TARGET):
            if gs != gt:
                fitness += 1
        return fitness


def ga():
    global POPULATION_SIZE

    # current generation
    generation = 1

    found = False
    population = []

    # create initial population
    for _ in range(POPULATION_SIZE):
        gnome = Individual.create_gnome()
        population.append(Individual(gnome))

    while not found:

        # sort the population in increasing order of fitness score
        population = sorted(population, key=lambda x: x.fitness)

        # if the individual having lowest fitness score ie.
        # 0 then we know that we have reached to the target
        # and break the loop
        if population[0].fitness <= 0:
            found = True
            break

        # Otherwise generate new offsprings for new generation
        new_generation = []

        # Perform Elitism, that mean 10% of fittest population
        # goes to the next generation
        s = int((10*POPULATION_SIZE)/100)
        new_generation.extend(population[:s])

        # From 50% of fittest population, Individuals
        # will mate to produce offspring
        s = int((90*POPULATION_SIZE)/100)
        for _ in range(s):
            parent1 = random.choice(population[:50])
            parent2 = random.choice(population[:50])
            child = parent1.mate(parent2)
            new_generation.append(child)

        population = new_generation

        print("Generation: {}\tString: {}\tFitness: {}".
              format(generation,
                     "".join(population[0].chromosome),
                     population[0].fitness))

        generation += 1

    print("Generation: {}\tString: {}\tFitness: {}".
          format(generation,
                 "".join(population[0].chromosome),
                 population[0].fitness))


def main():
    bayes()
    print("------------------------------------------")
    ga()


if __name__ == '__main__':
    main()
