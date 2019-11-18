#import <UIKit/UIKit.h>
#import "TrainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trainCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainOriginDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;

- (void)fillWithTrain:(TrainModel *)train;
@end

NS_ASSUME_NONNULL_END
