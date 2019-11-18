#import <Foundation/Foundation.h>
#import "NearbyModuleProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyPresenter : NSObject <NearbyInteractorOutputProtocol, NearbyPresenterProtocol>

@property (nonatomic, weak, nullable) id<NearbyViewProtocol> view;
@property (nonatomic) id<NearbyInteractorInputProtocol> interactor;
@property (nonatomic, strong) id<NearbyRouterProtocol> router;

- (instancetype)initWithInterface:(id<NearbyViewProtocol>)interface
                       interactor:(id<NearbyInteractorInputProtocol>)interactor
                           router:(id<NearbyRouterProtocol>)router;

@end

NS_ASSUME_NONNULL_END
