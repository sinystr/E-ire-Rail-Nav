#import <Foundation/Foundation.h>
#import "AddRouteModuleProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddRoutePresenter : NSObject <AddRouteInteractorOutputProtocol, AddRoutePresenterProtocol>

@property (nonatomic, weak, nullable) id<AddRouteViewProtocol> view;
@property (nonatomic) id<AddRouteInteractorInputProtocol> interactor;
@property (nonatomic, weak) id<AddRouteRouterProtocol> router;

- (instancetype)initWithInterface:(id<AddRouteViewProtocol>)interface
                       interactor:(id<AddRouteInteractorInputProtocol>)interactor
                           router:(id<AddRouteRouterProtocol>)router;

@end

NS_ASSUME_NONNULL_END
