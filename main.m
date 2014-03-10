
#import "Population.h"

int main(int argc, char const *argv[])
{
    @autoreleasepool
    {
        Population *pop = [[Population alloc] init];
        
        for (int i = 0; i < MAX_ITER; ++i)
        {
            [pop applyCrossover];
            
            [pop sort];
        }
        
        [pop printPopulation];
        
        [pop release];
    }
    
    return 0;
}