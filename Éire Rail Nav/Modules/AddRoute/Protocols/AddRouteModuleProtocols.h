#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RouteModel.h"
#import "StationModel.h"

#ifndef AddRouteModuleProtocols_h
#define AddRouteModuleProtocols_h

NS_ASSUME_NONNULL_BEGIN

// VIEW
@protocol AddRouteViewProtocol <NSObject>
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)showSuccessMessageAndDismiss;
// PRESENTER -> VIEW
- (void)setupViewWithStations:(NSArray<StationModel *> *)stations;
@end

// PRESENTER
@protocol AddRoutePresenterProtocol <NSObject>
- (void)viewDidLoad;
- (void)addRouteWith:(NSString *)fromStation toStation:(NSString *)toStation bidirectional:(BOOL)bidirectional;
@end

// INTERACTOR INPUT
@protocol AddRouteInteractorInputProtocol <NSObject>
- (void)retrieveAllStations;
- (void)addRouteWith:(NSString *)fromStation toStation:(NSString *)toStation bidirectional:(BOOL)bidirectional;
@end

// INTERACTOR OUTPUT
@protocol AddRouteInteractorOutputProtocol <NSObject>
- (void)routeAdded:(NSError *_Nullable)error;
- (void)allStationsRetrieved:(NSArray *_Nullable)stations error:(NSError *_Nullable)error;
@end

// ROUTER
@protocol AddRouteRouterProtocol <NSObject>
+ (UIViewController *)createAddRouteModule;
@end

NS_ASSUME_NONNULL_END

#endif
