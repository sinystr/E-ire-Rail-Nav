#import <UIKit/UIKit.h>
#import "NearbyModuleProtocols.h"
#import "NearbyModuleProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyEntitiesCategoryFooterTableViewCell : UITableViewCell
- (IBAction)changeView:(id)sender;
@property (weak, nonatomic) id<NearbyViewProtocol> nearbyView;
@property (weak, nonatomic) IBOutlet UIButton *changeViewButton;
@property (nonatomic, assign) BOOL isFullListCell;
@end

NS_ASSUME_NONNULL_END
