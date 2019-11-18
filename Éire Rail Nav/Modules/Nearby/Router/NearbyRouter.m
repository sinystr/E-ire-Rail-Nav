#import "NearbyRouter.h"
#import "TrainsRouter.h"

@implementation NearbyRouter

+ (nonnull UIViewController *)createNearbyModule {
    NearbyViewController * nearbyViewController = [[NearbyViewController alloc] initWithNibName:@"NearbyViewController" bundle:nil];
    NearbyInteractor * interactor = [NearbyInteractor new];
    NearbyRouter * router = [NearbyRouter new];
    NearbyPresenter * presenter = [[NearbyPresenter alloc] initWithInterface:nearbyViewController interactor:interactor router:router];
    nearbyViewController.presenter = presenter;
    interactor.output = presenter;
    return nearbyViewController;
}

-(void)presentAddRouteScreenFromView:(id<NearbyViewProtocol>)view {
    UIViewController* viewController = (UIViewController*)view;
    UIViewController* addRouteViewController = [AddRouteRouter createAddRouteModule];
    [viewController.navigationController pushViewController:addRouteViewController animated:NO];
}

-(void)presentTrainsScreenForStation:(StationModel*)station fromView:(id<NearbyViewProtocol>)view {
    UIViewController* viewController = (UIViewController*)view;
    UIViewController* stationTrainsViewController = [TrainsRouter createTrainsModuleForEntity:station];
    [viewController.navigationController pushViewController:stationTrainsViewController animated:NO];
}

-(void)presentTrainsScreenForRoute:(RouteModel*)route fromView:(id<NearbyViewProtocol>)view {
    UIViewController* viewController = (UIViewController*)view;
    UIViewController* routeTrainsViewController = [TrainsRouter createTrainsModuleForEntity:route];
    [viewController.navigationController pushViewController:routeTrainsViewController animated:NO];
}


@end
