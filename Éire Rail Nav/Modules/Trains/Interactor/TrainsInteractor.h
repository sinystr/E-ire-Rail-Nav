#import <Foundation/Foundation.h>
#import "TrainsModuleProtocols.h"
#import "StationModel.h"
#import "EntityManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainsInteractor : NSObject <TrainsInteractorInputProtocol>

@property (nonatomic, weak, nullable) id<TrainsInteractorOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
