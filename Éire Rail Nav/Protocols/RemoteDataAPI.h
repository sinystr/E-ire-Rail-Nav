#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RemoteDataAPI <NSObject>
-(void) getAllStations: (void (^)(NSData * _Nullable, NSError * _Nullable)) completionHandler;
-(void) getTrainsForStation:(NSString*)stationName completionHandler:(void (^)(NSData * _Nullable, NSError * _Nullable))completionHandler;
-(void) getTrainStops:(NSString*)trainCode completionHandler:(void (^)(NSData * _Nullable, NSError * _Nullable))completionHandler;
@end

NS_ASSUME_NONNULL_END
