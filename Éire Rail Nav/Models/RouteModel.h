#import <Foundation/Foundation.h>
#import "StationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RouteModel : NSObject

@property (atomic, strong) StationModel *fromStation;
@property (atomic, strong) StationModel *toStation;
@property (nonatomic, readonly) double distance;

@end

NS_ASSUME_NONNULL_END
