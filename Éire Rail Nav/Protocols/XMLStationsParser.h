#import <Foundation/Foundation.h>
#import "StationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XMLStationsParser <NSObject>
-(void)parseStationsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<StationModel*>*, NSError*))completionHandler;
@end

NS_ASSUME_NONNULL_END
