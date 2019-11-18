#import "NearbyEntitiesViewController.h"

@implementation NearbyEntitiesViewController
{
    NSArray *routes;
    NSArray *stations;
    BOOL stationsFullListIsShown;
    BOOL routesFullListIsShown;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyEntityTableViewCell" bundle:nil] forCellReuseIdentifier:@"NearbyEntityTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyEntitiesCategoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"NearbyEntitiesCategoryTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyEntitiesCategoryFooterTableViewCell" bundle:nil] forCellReuseIdentifier:@"NearbyEntitiesCategoryFooterTableViewCell"];

    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

#pragma mark - Utility

- (NSArray *)getEntitiesFor:(int)section {
    if (stationsFullListIsShown) {
        return stations;
    }

    if (routesFullListIsShown) {
        return routes;
    }
    return section == 0 ? routes : stations;
}

#pragma mark - NearbyEntitiesViewProtocol

- (void)showAllRoutes:(NSArray *)routes {
    self->routes = routes;
    routesFullListIsShown = true;
    [self.tableView reloadData];
}

- (void)showAllStations:(NSArray *)stations {
    self->stations = stations;
    stationsFullListIsShown = true;
    [self.tableView reloadData];
}

- (void)showNearbyRoutes:(NSArray *)routes andStations:(NSArray *)stations {
    stationsFullListIsShown = false;
    routesFullListIsShown = false;
    self->routes = routes;
    self->stations = stations;
    [self.tableView reloadData];
}

- (void)addButtonPressed {
    [self.nearbyView addRouteAction];
}

- (void)addButtonPressedForSection:(NSInteger)sectionNumber {
    return;
}

#pragma mark - Table view delegate methods
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getEntitiesFor:(int)section] count];
}

- (void)configureCellForStation:(NSInteger)stationIndex cell:(NearbyEntityTableViewCell *)cell {
    StationModel *station = stations[stationIndex];
    cell.entityTypeImageView.image = [UIImage imageNamed:@"stationIcon"];
    cell.entityTypeLabel.text = @"Station";
    cell.entityNameLabel.text = station.name;
    cell.entityDistanceLabel.text = [self getDistanceStringInKilometersFrom:station.distance];
}

- (void)configureCellForRoute:(NSInteger)stationIndex cell:(NearbyEntityTableViewCell *)cell {
    RouteModel *route = routes[stationIndex];
    cell.entityTypeImageView.image = [UIImage imageNamed:@"routeIcon"];
    cell.entityTypeLabel.text = @"Route";
    cell.entityNameLabel.text = [NSString stringWithFormat:@"%@ - %@", route.fromStation.name, route.toStation.name];
    cell.entityDistanceLabel.text = [self getDistanceStringInKilometersFrom:route.fromStation.distance];
}

- (NSString *)getDistanceStringInKilometersFrom:(double)distanceInMeters {
    return [NSString stringWithFormat:@"%.1f km. away", distanceInMeters / 1000];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NearbyEntityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NearbyEntityTableViewCell"];

    if (stationsFullListIsShown) {
        [self configureCellForStation:indexPath.row cell:cell];
        return cell;
    }

    if (routesFullListIsShown) {
        [self configureCellForRoute:indexPath.row cell:cell];
        return cell;
    }

    switch ([indexPath section]) {
        case 0:
            [self configureCellForRoute:indexPath.row cell:cell];
            break;
        case 1:
            [self configureCellForStation:indexPath.row cell:cell];
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return stationsFullListIsShown || routesFullListIsShown ? 1 : 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NearbyEntitiesCategoryTableViewCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:@"NearbyEntitiesCategoryTableViewCell"];
    headerCell.nearbyView = self.nearbyView;
    
    if(routesFullListIsShown){
        headerCell.titleLabel.text = @"All Routes";
        return headerCell;
    }
    
    if(stationsFullListIsShown){
        headerCell.titleLabel.text = @"All Stations";
        headerCell.addButton.hidden = YES;
        return headerCell;
    }

    switch (section) {
        case 0:
            headerCell.titleLabel.text = @"Routes";
            break;
        default:
            headerCell.titleLabel.text = @"Stations";
            headerCell.addButton.hidden = YES;
            break;
    }

    return headerCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NearbyEntitiesCategoryFooterTableViewCell *footerCell = [self.tableView dequeueReusableCellWithIdentifier:@"NearbyEntitiesCategoryFooterTableViewCell"];

    if (routesFullListIsShown || stationsFullListIsShown) {
        footerCell.isFullListCell = true;
    }

    footerCell.nearbyView = self.nearbyView;
    footerCell.tag = section;

    return footerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (routesFullListIsShown) {
        [_nearbyView showRouteDetailsAction:routes[indexPath.row]];
        return;
    }

    if (stationsFullListIsShown) {
        [_nearbyView showStationDetailsAction:stations[indexPath.row]];
        return;
    }

    switch (indexPath.section) {
        case 0:
            [_nearbyView showRouteDetailsAction:routes[indexPath.row]];
            break;
        case 1:
            [_nearbyView showStationDetailsAction:stations[indexPath.row]];
            break;
        default:
            break;
    }
}

@end
