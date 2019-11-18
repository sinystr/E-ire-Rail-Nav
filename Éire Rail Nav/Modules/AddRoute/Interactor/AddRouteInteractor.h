#import <Foundation/Foundation.h>
#import "AddRouteModuleProtocols.h"
#import "StationModel.h"
#import "EntityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddRouteInteractor : NSObject <AddRouteInteractorInputProtocol>

@property (nonatomic, weak, nullable) id<AddRouteInteractorOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
