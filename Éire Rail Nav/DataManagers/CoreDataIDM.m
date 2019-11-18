#import "CoreDataIDM.h"
#import "AppDelegate.h"

@implementation CoreDataIDM

- (void)saveStations:(NSArray *)stations completionHandler:(void (^)(NSError *_Nullable))completionHandler {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:context];

    for (StationModel *station in stations) {
        NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:description insertIntoManagedObjectContext:context];
        [object setValue:station.name forKey:@"name"];
        [object setValue:[NSNumber numberWithDouble:station.latitude] forKey:@"latitude"];
        [object setValue:[NSNumber numberWithDouble:station.longtitude] forKey:@"longitude"];
        [context insertObject:object];
    }

    NSError *error = nil;
    [context save:&error];
    completionHandler(error);
}

- (void)getAllStations:(void (^)(NSArray *_Nullable, NSError *_Nullable))completionHandler {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Station"];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    if ([results count] == 0 || error != nil) {
        completionHandler(results, error);
        return;
    }
    NSMutableArray *stationModelArray = [NSMutableArray new];

    for (NSManagedObject *obj in results) {
        StationModel *stationModel = [StationModel new];
        stationModel.name = (NSString *)[obj valueForKey:@"name"];
        stationModel.latitude = [[obj valueForKey:@"latitude"] doubleValue];
        stationModel.longtitude = [[obj valueForKey:@"longitude"] doubleValue];
        [stationModelArray addObject:stationModel];
    }

    completionHandler(stationModelArray, error);
}

- (void)addRouteFromStation:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation isBidirectional:(BOOL)bidirectional completionBlock:(nonnull void (^)(NSError *_Nullable))completionBlock {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:context];

    // Get FROM Station
    NSFetchRequest *requestfromStation = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
    requestfromStation.predicate = [NSPredicate predicateWithFormat:@"name == %@", fromStation];
    NSError *error = nil;
    NSArray *fromStationResults = [context executeFetchRequest:requestfromStation error:&error];

    if (error != nil) {
        completionBlock(error);
        return;
    }
    // Get TO Station
    NSFetchRequest *requstToStation = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
    requstToStation.predicate = [NSPredicate predicateWithFormat:@"name == %@", toStation];
    NSArray *toStationResults = [context executeFetchRequest:requstToStation error:&error];

    if (error != nil) {
        completionBlock(error);
        return;
    }

    NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:description insertIntoManagedObjectContext:context];
    [object setValue:fromStationResults[0] forKey:@"station1"];
    [object setValue:toStationResults[0] forKey:@"station2"];
    [object setValue:bidirectional ? @YES : @NO forKey:@"bidirectional"];
    [context insertObject:object];
    [context save:&error];
    completionBlock(error);
}

- (void)getAllRoutes:(void (^)(NSArray *_Nullable, NSError *_Nullable))completionHandler {
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Route"];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if ([results count] == 0 || error != nil) {
        completionHandler(results, error);
        return;
    }
    NSMutableArray *routeModelArray = [NSMutableArray new];
    for (NSManagedObject *obj in results) {
        [routeModelArray addObjectsFromArray:[self routesFromNSMO:obj]];
    }

    completionHandler(routeModelArray, error);
}

- (StationModel *)stationFromNSMO:(NSManagedObject *)stationManagedObject {
    StationModel *stationModel = [StationModel new];
    stationModel.name = (NSString *)[stationManagedObject valueForKey:@"name"];
    stationModel.latitude = [[stationManagedObject valueForKey:@"latitude"] doubleValue];
    stationModel.longtitude = [[stationManagedObject valueForKey:@"longitude"] doubleValue];
    return stationModel;
}

- (NSArray<RouteModel *> *)routesFromNSMO:(NSManagedObject *)routeManagedObject {
    NSMutableArray *routes = [NSMutableArray new];
    RouteModel *routeModel = [RouteModel new];
    NSManagedObject *station1 = (NSManagedObject *)[routeManagedObject valueForKey:@"station1"];
    NSManagedObject *station2 = (NSManagedObject *)[routeManagedObject valueForKey:@"station2"];
    routeModel.fromStation = [self stationFromNSMO:station1];
    routeModel.toStation = [self stationFromNSMO:station2];
    [routes addObject:routeModel];
    if ([routeManagedObject valueForKey:@"bidirectional"]) {
        routeModel = [RouteModel new];
        routeModel.fromStation = [self stationFromNSMO:station2];
        routeModel.toStation = [self stationFromNSMO:station1];
        [routes addObject:routeModel];
    }

    return routes;
}

@end
