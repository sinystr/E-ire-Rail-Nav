#import "NearbyEntitiesCategoryFooterTableViewCell.h"

@implementation NearbyEntitiesCategoryFooterTableViewCell

@synthesize isFullListCell = _isFullListCell;

- (void)setIsFullListCell:(BOOL)isFullListCell {
    if (isFullListCell) {
        [_changeViewButton setTitle:@"Show Nearby view" forState:normal];
    } else {
        [_changeViewButton setTitle:@"See all" forState:normal];
    }
    _isFullListCell = isFullListCell;
}

- (IBAction)changeView:(id)sender {
    if (_isFullListCell) {
        [self.nearbyView showNearbyRoutesAndStationsAction];
        return;
    }

    switch ([self tag]) {
        case 0:
            [self.nearbyView showAllRoutesAction];
            break;
        case 1:
            [self.nearbyView showAllStationsAction];
            break;
        default:
            break;
    }
}

@end
