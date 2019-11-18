#import "TrainTableViewCell.h"

@implementation TrainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithTrain:(TrainModel *)train {
    [self.trainCodeLabel setText:train.code];
    [self.trainOriginDestinationLabel setText:[NSString stringWithFormat:@"%@ - %@", train.originStationName, train.destinationStationName]];
    [self.arrivalTimeLabel setText:[NSString stringWithFormat:@"Arrival: %@", train.expectedArrivalTime]];
    [self.departureTimeLabel setText:[NSString stringWithFormat:@"Departure: %@", train.expectedDepartureTime]];
}

@end
