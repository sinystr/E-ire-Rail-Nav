#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InternalDataManager <NSObject>

-(void) saveStations:(NSArray*)stations completionHandler:(void (^)(NSError * _Nullable))completionHandler;
-(void) getAllStations: (void (^)(NSArray * , NSError *)) completionHandler;
-(void)addRouteFromStation:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation isBidirectional:(BOOL)bidirectional completionBlock:(nonnull void (^)(NSError * _Nullable))completionBlock;
-(void) getAllRoutes: (void (^)(NSArray * _Nullable, NSError * _Nullable)) completionHandler;

@end
    
NS_ASSUME_NONNULL_END
