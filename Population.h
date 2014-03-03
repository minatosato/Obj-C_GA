
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
- (void) insert: (int) index : (Individual*) ind;
- (void) printMaxIndividual;
- (void) crossover:(int) index;
- (void) applyCrossover;
- (Individual*) selectOffspring;

@end