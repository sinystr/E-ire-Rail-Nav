#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

+ (CLLocation *)getCurrentLocation;

@end

NS_ASSUME_NONNULL_END
