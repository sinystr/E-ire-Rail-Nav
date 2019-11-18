#import "StationModel.h"

@implementation StationModel

@synthesize location;

- (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longtitude];
}

@end
