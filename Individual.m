
#import "Individual.h"

float randDouble(float b)
{
    return ((b)*((double)arc4random()/ARC4RANDOM_MAX));
}

@implementation Individual
@synthesize fitness;

- (id) init
{
    if ([super init])
    {
        int pr[20] = {32,52,69,42,19,12,39,72,35,74,96,24,82,82,84,60,73,100,88,56};
        int we[20] = {20,80,49,95,68,32,100,69,65,73,18,44,25,37,90,75,11,83,15,57};
        
        for (int i = 0; i < sizeof(array)/sizeof(array[0]); ++i)
        {
            profit[i] = pr[i];
            weight[i] = we[i];
            array[i] = rand()%2;
        }
        [self calcFitness];
    }
    return self;
}
- (Individual*) deepCopy
{
    Individual *cp = [[[Individual alloc] init] autorelease];
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
    for (int i = 0; i < sizeof(array)/sizeof(array[0]); ++i)
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
        fitness /= 100;
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
- (NSComparisonResult) compare:(Individual*) ind
{
    if (self.fitness > ind.fitness)
    {
        return NSOrderedDescending;
    }
    else if (self.fitness < ind.fitness)
    {
        return NSOrderedAscending;
    }
    else
    {
        return NSOrderedSame;
    }
}
@end