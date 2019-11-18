#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMLTrainStopsParser <NSObject>
- (void)parseTrainStopsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<NSString*>*, NSError *))completionHandler;
@end

NS_ASSUME_NONNULL_END
