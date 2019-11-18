#import "TrainsInteractor.h"

@implementation TrainsInteractor
{
}

- (void)retrieveTrainsForStation:(nonnull StationModel *)station {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] getTrainsForStation:station completionBlock:^(NSArray *_Nullable trains, NSError *_Nullable error) {
        [weakSelf.output trainsRetrieved:trains forStation:station error:error];
    }];
}

- (void)retrieveTrainsForRoute:(nonnull RouteModel *)route {
    __weak __typeof__(self) weakSelf = self;
    [[EntityManager sharedInstance] getTrainsForStation:route.fromStation completionBlock:^(NSArray *_Nullable trains, NSError *_Nullable error) {
        if (error != nil) {
            [weakSelf.output trainsRetrieved:nil forRoute:route error:error];
            return;
        }

        dispatch_group_t group = dispatch_group_create();
        NSMutableArray<TrainModel *> *returnTrains = [NSMutableArray new];
        __block NSError *returnError;

        for (TrainModel *train in trains) {
            dispatch_group_enter(group);
            [[EntityManager sharedInstance] getTrainStops:train.code completionHandler:^(NSArray<NSString *> *_Nullable stops, NSError *_Nullable error) {
                returnError = error;
                BOOL initialStopFound = false;
                for (NSString *stop in stops) {
                    if ([stop isEqualToString:route.fromStation.name]) {
                        initialStopFound = true;
                    }

                    if ([stop isEqualToString:route.toStation.name]) {
                        if(initialStopFound) {
                            @synchronized (returnTrains) {
                                [returnTrains addObject:train];
                            }
                        }
                        break;
                    }
                }
                dispatch_group_leave(group);
            }];
        }

        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                                  if (returnError != nil) {
                                      [weakSelf.output trainsRetrieved:nil forRoute:route error:returnError];
                                      return;
                                  }
                                  [weakSelf.output trainsRetrieved:returnTrains forRoute:route error:nil];
                              });
    }];
}

@end
