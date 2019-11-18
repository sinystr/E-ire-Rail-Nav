#import "IrishRailRemoteDataAPI.h"

@implementation IrishRailRemoteDataAPI
{
    NSURLSession *session;
}

- (NSURLSession *)getSession {
    if (session == nil) {
        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    }
    return session;
}

- (void)getAllStations:(void (^)(NSData *, NSError *))completionHandler {
    NSURL *url = [NSURL URLWithString:@"http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataTask = [[self getSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completionHandler(data, error);
    }];

    [dataTask resume];
}

- (void)getTrainsForStation:(NSString *)stationName completionHandler:(void (^)(NSData *, NSError *))completionHandler {
    NSString *urlAddress = [NSString stringWithFormat:@"http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=%@", stationName];
    NSURL *url = [NSURL URLWithString:urlAddress];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataTask = [[self getSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completionHandler(data, error);
    }];

    [dataTask resume];
}

- (void)getTrainStops:(NSString *)trainCode completionHandler:(void (^)(NSData *_Nullable, NSError *_Nullable))completionHandler {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];

    NSString *urlAddress = [NSString stringWithFormat:@"http://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=%@&TrainDate=%@", trainCode, [formatter stringFromDate:[NSDate date]]];
    NSURL *url = [NSURL URLWithString:urlAddress];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataTask = [[self getSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completionHandler(data, error);
    }];

    [dataTask resume];
}

@end
