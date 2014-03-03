
#import "Individual.h"

@interface Population:NSObject
{
@public
    NSMutableArray *inds;
}
- (id) init;
- (void) printPopulation;
- (void) calcPopFitness;
- (void) mutation;
- (void) sort;
- (void) insert: (Individual*) ind;
- (void) printMaxIndividual;
- (void) crossover;
- (Individual*) selectOffspring;

@end