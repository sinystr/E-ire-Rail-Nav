#ifndef EntityManagerProtocol_h
#define EntityManagerProtocol_h

#import <Foundation/Foundation.h>
#import "RouteModel.h"
#import "StationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EntityManagerProtocol <NSObject>

-(void)getAllStations:(void(^)(NSArray* _Nullable stations, NSError * _Nullable)) completionHandler;
-(void)getAllRoutes:(void(^)(NSArray* routes, NSError * _Nonnull)) completionBlock;
-(void)addRouteFromStation:(NSString*)fromStation toStation:(NSString*)toStation isBidirectional:(BOOL)bidirectional completionBlock:(void(^)(NSError * _Nullable  error)) completionBlock;
- (void)getTrainsForStation:(nonnull StationModel *)station completionBlock:(nonnull void (^)(NSArray * _Nullable, NSError* _Nullable))completionBlock;
-(void) getTrainStops:(NSString*)trainCode completionHandler:(void (^)(NSArray<NSString*>* _Nullable, NSError * _Nullable))completionHandler;

@end

NS_ASSUME_NONNULL_END


#endif
