
#import "Population.h"

int main(int argc, char const *argv[])
{
    @autoreleasepool
    {
        Population *pop = [[[Population alloc] init] autorelease];
        
        for (int i = 0; i < 50; ++i)
        {
            [pop applyCrossover];
            [pop sort];
        }
        
        [pop printPopulation];
    }
    return 0;
}