#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NearbyRouter.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
