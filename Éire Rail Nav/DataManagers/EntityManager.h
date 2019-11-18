#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "EntityManagerProtocol.h"
#import "RemoteDataAPI.h"
#import "InternalDataManager.h"
#import "XMLStationsParser.h"
#import "XMLTrainsParser.h"
#import "IrishRailRemoteDataAPI.h"
#import "NSXMLStationsParser.h"
#import "XMLTrainsParser.h"
#import "NSXMLTrainsParser.h"
#import "XMLTrainStopsParser.h"
#import "NSXMLTrainStopsParser.h"
#import "CoreDataIDM.h"

NS_ASSUME_NONNULL_BEGIN

@interface EntityManager : NSObject <EntityManagerProtocol>

+ (id)sharedInstance;
@property id<RemoteDataAPI> remoteAPI;
@property id<InternalDataManager> coreDataManager;
@end

NS_ASSUME_NONNULL_END
