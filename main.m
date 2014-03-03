
#import "Population.h"

int main(int argc, char const *argv[])
{
    @autoreleasepool
    {
        Population *pop = [[Population alloc] init];
        
        for (int i = 0; i < 10; ++i)
        {
            [pop applyCrossover];
            [pop sort];
        }
//        [pop sort];
        
//        [pop printMaxIndividual];
        [pop printPopulation];
    }
    return 0;
}