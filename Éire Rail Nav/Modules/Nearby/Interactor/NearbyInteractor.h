#import <Foundation/Foundation.h>
#import "NearbyModuleProtocols.h"
#import "StationModel.h"
#import "EntityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyInteractor : NSObject <NearbyInteractorInputProtocol>

@property (nonatomic, weak, nullable) id<NearbyInteractorOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
