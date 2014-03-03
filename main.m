
#import <Foundation/Foundation.h>
#import <stdio.h>
#import <Cocoa/Cocoa.h>
#define ARC4RANDOM_MAX 0x100000000


float randDouble(float b)
{
    return ((b)*((double)arc4random()/ARC4RANDOM_MAX));
}

@interface Individual:NSObject
{
@public
    int array[20];
    int fitness;
    int profit[20];
    int weight[20];
}
- (id) init;
- (Individual*) deepCopy;
- (void) printIndividual;
- (void) calcFitness;
- (void) mutation;
@end

@implementation Individual
- (id) init
{
    [super init];
    int pr[20] = {32,52,69,42,19,12,39,72,35,74,96,24,82,82,84,60,73,100,88,56};
    int we[20] = {20,80,49,95,68,32,100,69,65,73,18,44,25,37,90,75,11,83,15,57};

    for (int i = 0; i < sizeof(array)/sizeof(array[0]); i++)
    {
        profit[i] = pr[i];
        weight[i] = we[i];
        array[i] = rand()%2;
    }
    [self calcFitness];
    return self;
}
- (Individual*) deepCopy
{
    Individual *cp = [[Individual alloc] init];
    for (int i = 0; i < 20; ++i)
    {
        cp -> array[i] = array[i];
        cp -> profit[i] = profit[i];
        cp -> weight[i] = weight[i];
    }
    [cp calcFitness];
    return cp;
}
- (void) printIndividual
{
    for (int i = 0; i < sizeof(array)/sizeof(array[0]); i++)
    {
        printf("%d ", array[i]);
    }
    printf(": %d\n", fitness);
}
- (void) calcFitness
{
    fitness = 0;
    int w = 0;
    for (int i = 0; i < sizeof(array)/sizeof(array[0]); ++i)
    {
        if (array[i] == 1)
        {
            fitness += profit[i];
            w += weight[i];
        }
    }
    if (w > 553)
    {
        fitness /= 10;
    }
}
- (void) mutation
{
    for (int i = 0; i < sizeof(array)/sizeof(array[0]); ++i)
    {
        if (rand()%20 == 0)
        {
            if (array[i]==0)
            {
                array[i] = 1;
            }
            else
            {
                array[i] = 0;
            }
        }
    }
    [self calcFitness];
}
@end

@interface Population:NSObject
{
@private
    NSMutableArray *inds;
}
- (id) init;
- (void) printPopulation;
- (void) calcPopFitness;
- (void) mutation;
@end

@implementation Population
- (id) init
{
    [super init];
    inds = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50; ++i)
    {
        [inds addObject:[[Individual alloc] init]];
    }
    return self;
}
- (void) printPopulation
{
    for (int i = 0; i < 50; ++i)
    {
        Individual *ind = [inds objectAtIndex:i];
        [ind printIndividual];
    }
}
- (void) calcPopFitness
{
    for (int i = 0; i < 50; ++i)
    {
        [[inds objectAtIndex:i] calcFitness];
    }
}
- (void) mutation
{
    for (int i = 0; i < 50; ++i)
    {
        [[inds objectAtIndex:i] mutation];
    }
}
- (void) sort
{
    [inds sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}
- (void) insert: (Individual*) ind
{
    int min = 1000;
    int index = 0;
    for (int i = 0; i < 50; ++i)
    {
        Individual *ind = [inds objectAtIndex:i];
        if (ind->fitness<min)
        {
            min = ind->fitness;
            index = i;
        }
    }
    [inds replaceObjectAtIndex:index withObject:ind];
}
- (void) printMaxIndividual
{
    int max = 0;
    int index = 0;
    for (int i = 0; i < 50; ++i)
    {
        Individual *ind = [inds objectAtIndex:i];
        if (ind->fitness > max)
        {
            max = ind->fitness;
            index = i;
        }
    }
    [[inds objectAtIndex:index] printIndividual];
}
- (void) crossover
{
    Individual *parent1 = [self selectOffspring];
    Individual *parent2 = [self selectOffspring];
    Individual *child1 = [parent1 deepCopy];
    Individual *child2 = [parent2 deepCopy];
    int sep1 = rand()%17 + 1;
    int sep2 = rand()%17 + 1;
    if (sep1 > sep2)
    {
        int tmp = sep1;
        sep1 = sep2;
        sep2 = tmp;
    }
    else if (sep1 == sep2)
    {
        sep2++;
    }
    for (int i = sep1; i < sep2; ++i)
    {
        int tmp = child1 -> array[i];
        child1 -> array[i] = child2 -> array[i];
        child2 -> array[i] = tmp;
    }
    [child1 mutation];
    [child2 mutation];
    [child1 calcFitness];
    [child2 calcFitness];
    [self insert:child1];
    [self insert:child2];
}
- (Individual*) selectOffspring
{
    int fitSum = 0;
    for (int i = 0; i < 50; ++i)
    {
        Individual *ind = [inds objectAtIndex:i];
        fitSum += ind->fitness;
    }
    double random = randDouble(1.0);
    double checkPoint = fitSum * random;
    fitSum = 0;
    for (int i = 0; i < 50; ++i)
    {
        Individual *ind = [inds objectAtIndex:i];
        fitSum += ind->fitness;
        if (fitSum > checkPoint)
        {
            return ind;
        }
    }
    return NULL;
}
@end

int main(int argc, char const *argv[])
{
    @autoreleasepool
    {
        printf("Hello\n");
        Population *pop = [[Population alloc] init];
        [pop mutation];
        for (int i = 0; i < 3000; ++i)
        {
            [pop crossover];
            // [pop printMaxIndividual];
        }
        [pop printMaxIndividual];
    }
    return 0;
}