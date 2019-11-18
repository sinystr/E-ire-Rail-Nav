#import <UIKit/UIKit.h>
#import "NearbyEntityTableViewCell.h"
#import "NearbyEntitiesCategoryTableViewCell.h"
#import "NearbyEntitiesCategoryFooterTableViewCell.h"
#import "NearbyModuleProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyEntitiesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NearbyEntitiesViewProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id<NearbyViewProtocol> nearbyView;

@end

NS_ASSUME_NONNULL_END
