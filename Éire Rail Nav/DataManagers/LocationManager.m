#import "LocationManager.h"
#import "StationModel.h"
#import "RouteModel.h"

@implementation LocationManager

+ (CLLocation *)getCurrentLocation {
    return [[CLLocation alloc] initWithLatitude:53.228430 longitude:-6.204864];
}

@end
