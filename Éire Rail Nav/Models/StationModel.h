#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StationModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) double latitude;
@property (nonatomic) double longtitude;
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic) double distance;

@end

NS_ASSUME_NONNULL_END
