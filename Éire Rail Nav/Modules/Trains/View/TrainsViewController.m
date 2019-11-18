#import "TrainsViewController.h"

@interface TrainsViewController ()
@end

@implementation TrainsViewController
{
    NSArray<TrainModel *> *trains;
    JGProgressHUD * progressHUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.trainsTableView registerNib:[UINib nibWithNibName:@"TrainTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrainTableViewCell"];
    [self.trainsTableView setDelegate:self];
    [self.trainsTableView setDataSource:self];
    [self.presenter viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
}


- (void)setupHeadlineForRoute:(nonnull RouteModel *)route {
    [self.entityTitle setText:[NSString stringWithFormat:@"%@ - %@", route.fromStation.name, route.toStation.name]];
    [self.entityTypeSubtitle setText:@"Route"];
    [self.entityDistance setText:[self getDistanceStringInKilometersFrom:route.distance]];
    return;
}

- (NSString *)getDistanceStringInKilometersFrom:(double)distanceInMeters {
    return [NSString stringWithFormat:@"%.1f km. away", distanceInMeters / 1000];
}

- (void)setupHeadlineForStation:(nonnull StationModel *)station {
    [self.entityTitle setText:station.name];
    [self.entityTypeSubtitle setText:@"Station"];
    [self.entityDistance setText:[self getDistanceStringInKilometersFrom:station.distance]];
    return;
}

- (void)showLoadingIndicator {
    progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
    progressHUD.textLabel.text = @"Loading";
    [progressHUD showInView:self.view];
    return;
}

- (void)hideLoadingIndicator {
    [progressHUD dismiss];
    return;
}

- (void)showTrains:(nonnull NSArray *)trains {
    self->trains = trains;
    [self.trainsTableView reloadData];
    return;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TrainTableViewCell *cell = [self.trainsTableView dequeueReusableCellWithIdentifier:@"TrainTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithTrain:trains[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return trains.count;
}

@end
