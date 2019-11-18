#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "InternalDataManager.h"
#import "StationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataIDM : NSObject <InternalDataManager>
- (void)saveStations:(NSArray *)stations completionHandler:(void (^)(NSError *_Nullable))completionHandler;
- (void)getAllStations:(void (^)(NSArray *, NSError *))completionHandler;
- (void)addRouteFromStation:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation isBidirectional:(BOOL)bidirectional completionBlock:(nonnull void (^)(NSError *_Nullable))completionBlock;
@end

NS_ASSUME_NONNULL_END
