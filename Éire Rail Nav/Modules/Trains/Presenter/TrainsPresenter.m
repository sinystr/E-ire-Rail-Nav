#import "TrainsPresenter.h"

@implementation TrainsPresenter
{
    id entity;
}

- (instancetype)initWithInterface:(id<TrainsViewProtocol>)interface
                       interactor:(id<TrainsInteractorInputProtocol>)interactor
                           router:(id<TrainsRouterProtocol>)router
                           entity:(id)entity {
    if (self = [super init]) {
        self.interactor = interactor;
        self.router = router;
        self.view = interface;
        self->entity = entity;
    }
    return self;
}

- (void)viewDidLoad {
    if ([self->entity isKindOfClass:[StationModel class]]) {
        [self.interactor retrieveTrainsForStation:(StationModel *)self->entity];
    } else if ([self->entity isKindOfClass:[RouteModel class]]) {
        [self.interactor retrieveTrainsForRoute:(RouteModel *)self->entity];
    }
    [self.view showLoadingIndicator];
}

- (void)trainsRetrieved:(NSArray<TrainModel *> *_Nullable)trains forRoute:(nonnull RouteModel *)route error:(NSError *_Nullable)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideLoadingIndicator];
        if (error != nil) {
            // Error handling
        }

        [self.view setupHeadlineForRoute:route];
        [self.view showTrains:trains];
    });
}

- (void)trainsRetrieved:(NSArray<TrainModel *> *_Nullable)trains forStation:(nonnull StationModel *)station error:(NSError *_Nullable)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view hideLoadingIndicator];
        if (error != nil) {
            // Error handling
        }
        [self.view setupHeadlineForStation:station];
        [self.view showTrains:trains];
    });
}

@end
