#import "NearbyPresenter.h"

@implementation NearbyPresenter

- (instancetype)initWithInterface:(id<NearbyViewProtocol>)interface
                       interactor:(id<NearbyInteractorInputProtocol>)interactor
                           router:(id<NearbyRouterProtocol>)router {
    if (self = [super init]) {
        self.interactor = interactor;
        self.router = router;
        self.view = interface;
    }
    [self.interactor retrieveNearbyRoutesAndStations];
    [self.view showLoadingIndicator];
    return self;
}

- (void)allRoutesRetrieved:(NSArray *_Nullable)routes error:(NSError *_Nullable)error {
    [self.view showAllRoutes:routes];
}

- (void)allStationsRetrieved:(NSArray *_Nullable)stations error:(NSError *_Nullable)error {
    if (error != nil) {
        NSLog(@"Error handling");
        return;
    }
    
    [self.view hideLoadingIndicator];
    [self.view showAllStations:[self stationsSortedByName:stations]];
}

- (void)nearbyRoutesAndStationsRetrieved:(NSArray *_Nullable)stations routes:(NSArray *_Nullable)routes error:(NSError *_Nullable)error {
    [self.view hideLoadingIndicator];
    [self.view showNearbyRoutes:routes andStations:[self stationsSortedByName:stations]];
}

- (void)addRouteAction {
    [self.router presentAddRouteScreenFromView:self.view];
}

- (void)showAllRoutesAction {
    [self.interactor retrieveAllRoutes];
}

- (void)showAllStationsAction {
    [self.view showLoadingIndicator];
    [self.interactor retrieveAllStations];
}

- (void)showRouteDetailsAction:(nonnull RouteModel *)route {
    [self.router presentTrainsScreenForRoute:route fromView:self.view];
}

- (void)showStationDetailsAction:(nonnull StationModel *)station {
    [self.router presentTrainsScreenForStation:station fromView:self.view];
}

- (void)showNearbyRoutesAndStationsAction {
    [self.interactor retrieveNearbyRoutesAndStations];
    [self.view showLoadingIndicator];
}

- (NSArray<StationModel *> *)stationsSortedByName:(NSArray<StationModel *> *) stations {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [stations sortedArrayUsingDescriptors:@[sort]];
}

@end
