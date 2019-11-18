#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Eire_Rail_Nav-Swift.h>
#import "NearbyRouter.h"
#import "NearbyInteractor.h"
#import "NearbyPresenter.h"
#import "NearbyModuleProtocols.h"
#import "AddRouteRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyRouter : NSObject <NearbyRouterProtocol>
+ (nonnull UIViewController *)createNearbyModule;

@end

NS_ASSUME_NONNULL_END
