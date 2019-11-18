#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RouteModel.h"
#import "StationModel.h"
#import "TrainModel.h"

#ifndef TrainsModuleProtocols_h
#define TrainsModuleProtocols_h

NS_ASSUME_NONNULL_BEGIN

// VIEW
@protocol TrainsViewProtocol <NSObject>
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
// PRESENTER -> VIEW
- (void)setupHeadlineForStation:(StationModel *)station;
- (void)setupHeadlineForRoute:(RouteModel *)route;
- (void)showTrains:(NSArray *)trains;
@end

// INTERACTOR INPUT
@protocol TrainsInteractorInputProtocol <NSObject>
- (void)retrieveTrainsForStation:(StationModel *)station;
- (void)retrieveTrainsForRoute:(RouteModel *)route;
@end

// INTERACTOR OUTPUT
@protocol TrainsInteractorOutputProtocol <NSObject>
- (void)trainsRetrieved:(NSArray<TrainModel *> *_Nullable)trains forStation:(StationModel *)station error:(NSError *_Nullable)error;
- (void)trainsRetrieved:(NSArray<TrainModel *> *_Nullable)trains forRoute:(RouteModel *)station error:(NSError *_Nullable)error;
@end

// ROUTER
@protocol TrainsRouterProtocol <NSObject>
+ (nonnull UIViewController *)createTrainsModuleForEntity:(id)entity;
@end

// PRESENTER
@protocol TrainsPresenterProtocol <NSObject>
- (void)viewDidLoad;
- (instancetype)initWithInterface:(id<TrainsViewProtocol>)interface
                       interactor:(id<TrainsInteractorInputProtocol>)interactor
                           router:(id<TrainsRouterProtocol>)router
                           entity:(id)entity;
@end

NS_ASSUME_NONNULL_END

#endif
