#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RouteModel.h"
#import "StationModel.h"

#ifndef NearbyModuleProtocols_h
#define NearbyModuleProtocols_h

NS_ASSUME_NONNULL_BEGIN

// VIEW
@protocol NearbyViewProtocol <NSObject>
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
// PRESENTER -> VIEW
- (void)showNearbyRoutes:(NSArray<RouteModel *> *)routes andStations:(NSArray<StationModel *> *)stations;
- (void)showAllRoutes:(NSArray <RouteModel*> *)routes;
- (void)showAllStations:(NSArray <StationModel*> *)stations;
// USER ACTIONS
- (void)addRouteAction;
- (void)showAllRoutesAction;
- (void)showAllStationsAction;
- (void)showNearbyRoutesAndStationsAction;
- (void)showRouteDetailsAction:(RouteModel *)route;
- (void)showStationDetailsAction:(StationModel *)station;
@end

@protocol NearbyEntitiesViewProtocol <NSObject>
- (void)showAllRoutes:(NSArray *)routes;
- (void)showAllStations:(NSArray *)stations;
- (void)showNearbyRoutes:(NSArray *)routes andStations:(NSArray *)stations;
- (void)addButtonPressedForSection:(NSInteger)sectionNumber;
- (void)seeAllButtonPressedForSection:(NSInteger)sectionNumber;
@end

// PRESENTER
@protocol NearbyPresenterProtocol <NSObject>
- (void)addRouteAction;
- (void)showAllRoutesAction;
- (void)showAllStationsAction;
- (void)showNearbyRoutesAndStationsAction;
- (void)showRouteDetailsAction:(RouteModel *)route;
- (void)showStationDetailsAction:(StationModel *)station;
@end

// INTERACTOR INPUT
@protocol NearbyInteractorInputProtocol <NSObject>
- (void)retrieveNearbyRoutesAndStations;
- (void)retrieveAllStations;
- (void)retrieveAllRoutes;
@end

// INTERACTOR OUTPUT
@protocol NearbyInteractorOutputProtocol <NSObject>
- (void)nearbyRoutesAndStationsRetrieved:(NSArray *_Nullable)stations routes:(NSArray *_Nullable)routes error:(NSError *_Nullable)error;
- (void)allStationsRetrieved:(NSArray *_Nullable)stations error:(NSError *_Nullable)error;
- (void)allRoutesRetrieved:(NSArray *_Nullable)routes error:(NSError *_Nullable)error;
@end

// ROUTER
@protocol NearbyRouterProtocol <NSObject>
+ (UIViewController *)createNearbyModule;
- (void)presentAddRouteScreenFromView:(id<NearbyViewProtocol>)view;
- (void)presentTrainsScreenForStation:(StationModel *)station fromView:(id<NearbyViewProtocol>)view;
- (void)presentTrainsScreenForRoute:(RouteModel *)route fromView:(id<NearbyViewProtocol>)view;
@end

NS_ASSUME_NONNULL_END

#endif
