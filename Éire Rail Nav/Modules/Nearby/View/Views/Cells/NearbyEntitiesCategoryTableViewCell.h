#import <UIKit/UIKit.h>
#import "NearbyModuleProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearbyEntitiesCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addEntityAction:(id)sender;
@property (weak, nonatomic) id<NearbyViewProtocol> nearbyView;

@end

NS_ASSUME_NONNULL_END
