
#import <Foundation/Foundation.h>
#import <stdio.h>
#import <Cocoa/Cocoa.h>
#define ARC4RANDOM_MAX 0x100000000
#define POP_SIZE 50
#define MAX_ITER 50
#define GENE_LENGTH 20
#define MAX_WEIGHT 553

float randDouble(float b);

@interface Individual:NSObject
{
@public
    int array[GENE_LENGTH];
    int profit[GENE_LENGTH];
    int weight[GENE_LENGTH];
@private
    int fitness;
}
@property int fitness;
- (id) init;
- (void) dealloc;
- (Individual*) deepCopy;
- (void) printIndividual;
- (void) calcFitness;
- (void) mutation;
- (NSComparisonResult) compare:(Individual*) ind;
@end
