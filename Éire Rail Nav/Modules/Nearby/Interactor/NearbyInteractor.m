#import "NearbyInteractor.h"
#import "LocationManager.h"
#import "Config.h"

@implementation NearbyInteractor

- (NSArray<StationModel *> *)filterStations:(NSArray<StationModel *> *)stations within:(double)meters
{
    NSMutableArray<StationModel *> *filteredStations = [NSMutableArray new];
    CLLocation *currentLocation = [LocationManager getCurrentLocation];
    for (StationModel *station in stations) {
        double distance = [station.location distanceFromLocation:currentLocation];
        if (distance < meters) {
            [filteredStations addObject:station];
            station.distance = distance;
        }
    }
    return filteredStations;
}

- (NSArray<RouteModel *> *)filterRoutes:(NSArray<RouteModel *> *)routes within:(double)meters
{
    NSMutableArray<RouteModel *> *filteredRoutes = [NSMutableArray new];
    CLLocation *currentLocation = [LocationManager getCurrentLocation];
    for (RouteModel *route in routes) {
        double distance = [route.fromStation.location distanceFromLocation:currentLocation];
        if (distance < meters) {
            [filteredRoutes addObject:route];
            route.fromStation.distance = distance;
        }
    }
    return filteredRoutes;
}

- (void)retrieveAllStations {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] getAllStations:^(NSArray *_Nullable stations, NSError *_Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
                           CLLocation *currentLocation = [LocationManager getCurrentLocation];
                           for (StationModel *station in stations) {
                               station.distance = [station.location distanceFromLocation:currentLocation];
                           }
                           [weakSelf.output allStationsRetrieved:stations error:error];
                       });
    }];
}

- (void)retrieveNearbyRoutesAndStations {
    __weak __typeof__(self) weakSelf = self;

    [[EntityManager sharedInstance] getAllStations:^(NSArray *_Nullable stations, NSError *_Nullable error) {
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                               [weakSelf.output nearbyRoutesAndStationsRetrieved:nil routes:nil error:error];
                           });
            return;
        }

        [[EntityManager sharedInstance] getAllRoutes:^(NSArray *_Nonnull routes, NSError *_Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                               NSArray *filteredStations = [self filterStations:stations within:NEARBY_DISTANCE];
                               NSArray *filteredRoutes = [self filterRoutes:routes within:NEARBY_DISTANCE];
                               [weakSelf.output nearbyRoutesAndStationsRetrieved:filteredStations routes:filteredRoutes error:error];
                           });
        }];
    }];
}

- (void)retrieveAllRoutes {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] getAllRoutes:^(NSArray *_Nonnull routes, NSError *_Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
                            CLLocation *currentLocation = [LocationManager getCurrentLocation];
                            for (RouteModel *route in routes) {
                                route.fromStation.distance = [route.fromStation.location distanceFromLocation:currentLocation];
                            }
                           [weakSelf.output allRoutesRetrieved:routes error:error];
                       });
    }];
}

@end
