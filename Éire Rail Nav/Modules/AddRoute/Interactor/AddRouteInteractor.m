#import "AddRouteInteractor.h"

@implementation AddRouteInteractor

- (void)retrieveAllStations {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] getAllStations:^(NSArray *_Nullable stations, NSError *_Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
                           [weakSelf.output allStationsRetrieved:stations error:error];
                       });
    }];
}

- (void)addRouteWith:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation bidirectional:(BOOL)bidirectional {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] addRouteFromStation:fromStation toStation:toStation isBidirectional:bidirectional completionBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
                           [weakSelf.output routeAdded:error];
                       });
    }];
}

@end
