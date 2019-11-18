#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrainModel : NSObject

@property (nonatomic) NSString *code;
@property (nonatomic) NSString *expectedArrivalTime;
@property (nonatomic) NSString *expectedDepartureTime;
@property (nonatomic) NSString *originStationName;
@property (nonatomic) NSString *destinationStationName;

@end

NS_ASSUME_NONNULL_END
