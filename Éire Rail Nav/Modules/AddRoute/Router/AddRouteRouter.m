#import "AddRouteRouter.h"

@implementation AddRouteRouter

+ (nonnull UIViewController *)createAddRouteModule {
    AddRouteViewController *addRouteViewController = [[AddRouteViewController alloc] initWithNibName:@"AddRouteViewController" bundle:nil];
    AddRouteInteractor *interactor = [AddRouteInteractor new];
    AddRouteRouter *router = [AddRouteRouter new];
    AddRoutePresenter *presenter = [[AddRoutePresenter alloc] initWithInterface:addRouteViewController interactor:interactor router:router];
    addRouteViewController.presenter = presenter;
    interactor.output = presenter;
    return addRouteViewController;
}

@end
