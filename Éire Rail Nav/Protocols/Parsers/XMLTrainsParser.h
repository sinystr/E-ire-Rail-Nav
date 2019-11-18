#import <Foundation/Foundation.h>
#import "TrainModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XMLTrainsParser <NSObject>
- (void)parseTrainsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<TrainModel*>*, NSError *))completionHandler;
@end

NS_ASSUME_NONNULL_END
