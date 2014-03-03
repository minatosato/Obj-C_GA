
#import <Foundation/Foundation.h>
#import <stdio.h>
#import <Cocoa/Cocoa.h>
#define ARC4RANDOM_MAX 0x100000000

float randDouble(float b);

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
