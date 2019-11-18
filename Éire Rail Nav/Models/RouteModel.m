#import "RouteModel.h"

@implementation RouteModel

@synthesize distance;

- (double)distance {
    return self.fromStation.distance;
}

@end
