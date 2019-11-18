#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NearbyEntityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *entityTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *entityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *entityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *entityDistanceLabel;

@end

NS_ASSUME_NONNULL_END
