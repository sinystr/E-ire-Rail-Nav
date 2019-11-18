#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Eire_Rail_Nav-Swift.h>
#import "AddRouteRouter.h"
#import "AddRouteInteractor.h"
#import "AddRoutePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddRouteRouter : NSObject <AddRouteRouterProtocol>
+ (UIViewController *)createAddRouteModule;

@end

NS_ASSUME_NONNULL_END
