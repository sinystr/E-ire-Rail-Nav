#import <UIKit/UIKit.h>
#import "TrainsModuleProtocols.h"
#import "TrainTableViewCell.h"
#import <JGProgressHUD/JGProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrainsViewController : UIViewController <TrainsViewProtocol, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *entityTitle;
@property (weak, nonatomic) IBOutlet UILabel *entityTypeSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *entityDistance;
@property (weak, nonatomic) IBOutlet UITableView *trainsTableView;
@property (nonatomic, strong, nullable) id<TrainsPresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
