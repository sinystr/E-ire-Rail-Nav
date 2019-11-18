#import "TrainsRouter.h"

@implementation TrainsRouter

+ (nonnull UIViewController *)createTrainsModuleForEntity:(id)entity {
    TrainsViewController *trainsViewController = [[TrainsViewController alloc] initWithNibName:@"TrainsViewController" bundle:nil];
    TrainsInteractor *interactor = [TrainsInteractor new];
    TrainsRouter *router = [TrainsRouter new];
    TrainsPresenter *presenter = [[TrainsPresenter alloc] initWithInterface:trainsViewController interactor:interactor router:router entity:entity];
    trainsViewController.presenter = presenter;
    interactor.output = presenter;
    return trainsViewController;
}

@end
