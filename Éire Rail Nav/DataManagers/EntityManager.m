#import "EntityManager.h"

@implementation EntityManager

+ (id)sharedInstance {
    static EntityManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntityManager alloc] init];
    });

    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _remoteAPI = [IrishRailRemoteDataAPI new];
        _coreDataManager = [CoreDataIDM new];
    }

    return self;
}

- (void)getAllRoutes:(nonnull void (^)(NSArray *_Nonnull routes, NSError *_Nonnull error))completionBlock {
    [_coreDataManager getAllRoutes:completionBlock];
    return;
}

- (void)getAllStations:(nonnull void (^)(NSArray *_Nullable, NSError *_Nullable))completionHandler {
    __weak __typeof__(self) weakSelf = self;
    [_coreDataManager getAllStations:^(NSArray *_Nonnull stations, NSError *_Nonnull error) {
        if ([stations count] > 0 && error == nil) {
            completionHandler(stations, error);
            return;
        }

        [weakSelf.remoteAPI getAllStations:^(NSData *_Nonnull data, NSError *_Nonnull error) {
            if (error) {
                completionHandler(nil, error);
                return;
            }

            id<XMLStationsParser> stationsParser = [NSXMLStationsParser new];
            [stationsParser parseStationsFrom:data completionHandler:^(NSMutableArray<StationModel *> *_Nonnull stations, NSError *_Nonnull error) {
                if (error != nil) {
                    completionHandler(nil, error);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.coreDataManager saveStations:stations completionHandler:^(NSError *_Nullable err) {
                        completionHandler(stations, nil);
                    }];
                });
            }];
        }];
    }];
}

- (void)getTrainsForStation:(StationModel *)station completionBlock:(void (^)(NSArray *_Nullable, NSError *_Nullable))completionBlock {
    [_remoteAPI getTrainsForStation:station.name completionHandler:^(NSData *_Nonnull trainsData, NSError *_Nonnull error) {
        if (error != nil) {
            completionBlock(nil, error);
            return;
        }

        id<XMLTrainsParser> trainsParser = [NSXMLTrainsParser new];
        [trainsParser parseTrainsFrom:trainsData completionHandler:^(NSMutableArray<TrainModel *> *_Nonnull trains, NSError *_Nonnull error) {
            completionBlock(trains, nil);
        }];
    }];
}

- (void)addRouteFromStation:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation isBidirectional:(BOOL)bidirectional completionBlock:(nonnull void (^)(NSError *_Nullable))completionBlock {
    [_coreDataManager addRouteFromStation:fromStation toStation:toStation isBidirectional:bidirectional completionBlock:completionBlock];
}

- (void)getTrainStops:(nonnull NSString *)trainCode completionHandler:(nonnull void (^)(NSArray<NSString *> *_Nullable, NSError *_Nullable))completionHandler {
    [_remoteAPI getTrainStops:trainCode completionHandler:^(NSData *_Nullable data, NSError *_Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }

        id<XMLTrainStopsParser> trainStopsParser = [NSXMLTrainStopsParser new];
        [trainStopsParser parseTrainStopsFrom:data completionHandler:completionHandler];
    }];
}

@end
