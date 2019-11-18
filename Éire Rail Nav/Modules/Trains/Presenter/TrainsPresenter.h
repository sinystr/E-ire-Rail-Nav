#import <Foundation/Foundation.h>
#import "TrainsModuleProtocols.h"
#import "StationModel.h"
#import "RouteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainsPresenter : NSObject <TrainsInteractorOutputProtocol, TrainsPresenterProtocol>

@property (nonatomic, weak, nullable) id<TrainsViewProtocol> view;
@property (nonatomic) id<TrainsInteractorInputProtocol> interactor;
@property (nonatomic, weak) id<TrainsRouterProtocol> router;

@end

NS_ASSUME_NONNULL_END
