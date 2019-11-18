#import <UIKit/UIKit.h>
#import "AddRouteModuleProtocols.h"
#import <JGProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddRouteViewController : UIViewController <AddRouteViewProtocol>
@property (weak, nonatomic) IBOutlet UITextField *toStationTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromStationTextField;
@property (strong, strong, nullable) id<AddRoutePresenterProtocol> presenter;
-(void)setupViewWithStations:(NSArray<StationModel*>*)stations;
-(void)hideLoadingIndicator;
-(void)showLoadingIndicator;
@end

NS_ASSUME_NONNULL_END
