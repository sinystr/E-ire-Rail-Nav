#import <Foundation/Foundation.h>
#import "StationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RouteModel : NSObject

@property (nonatomic, strong) StationModel *fromStation;
@property (nonatomic, strong) StationModel *toStation;
@property (nonatomic, readonly) double distance;

@end

NS_ASSUME_NONNULL_END
