#import "AddRoutePresenter.h"

@implementation AddRoutePresenter

- (instancetype)initWithInterface:(id<AddRouteViewProtocol>)interface
                       interactor:(id<AddRouteInteractorInputProtocol>)interactor
                           router:(id<AddRouteRouterProtocol>)router {
    if (self = [super init]) {
        self.interactor = interactor;
        self.router = router;
        self.view = interface;
    }
    return self;
}

- (void)viewDidLoad {
    [self.interactor retrieveAllStations];
    [self.view showLoadingIndicator];
}

- (void)allStationsRetrieved:(NSArray *_Nullable)stations error:(NSError *_Nullable)error {
    if (error != nil) {
        NSLog(@"Error handling");
        return;
    }

    [self.view hideLoadingIndicator];
    [self.view setupViewWithStations:[self stationsSortedByName:stations]];
}

- (void)routeAdded:(NSError *)error {
    if (error != nil) {
        //error handling
        return;
    }

    [self.view hideLoadingIndicator];
    [self.view showSuccessMessageAndDismiss];
}

- (void)addRouteWith:(nonnull NSString *)fromStation toStation:(nonnull NSString *)toStation bidirectional:(BOOL)bidirectional {
    [self.interactor addRouteWith:fromStation toStation:toStation bidirectional:bidirectional];
}


- (NSArray<StationModel *> *)stationsSortedByName:(NSArray<StationModel *> *) stations {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [stations sortedArrayUsingDescriptors:@[sort]];
}

@end
