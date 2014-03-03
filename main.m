
#import "Population.h"

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