#import "NSXMLStationsParser.h"

@implementation NSXMLStationsParser
{
    NSXMLParser *xmlParser;
    NSMutableArray *stations;
    StationModel *station;
    NSString *currentElement;
    void (^ completionBlock)(NSMutableArray<StationModel *> *, NSError *);
}

- (void)parseStationsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<StationModel *> *, NSError *))completionHandler {
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    completionBlock = completionHandler;
    [xmlParser parse];
    return;
}

//MARK: - NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    stations = [NSMutableArray new];
}

- (void)   parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
       attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;

    if ([elementName isEqualToString:@"objStation"]) {
        station = [StationModel new];
    }
}

- (void)   parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"objStation"]) {
        [stations addObject:station];
        station = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return;
    }

    if ([currentElement isEqualToString:@"StationDesc"]) {
        station.name = string;
        return;
    }

    if ([currentElement isEqualToString:@"StationLatitude"]) {
        station.latitude = [string doubleValue];
        return;
    }

    if ([currentElement isEqualToString:@"StationLongitude"]) {
        station.longtitude = [string doubleValue];
        return;
    }
}

// MARK: Completion methods

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    completionBlock(stations, nil);
    [self clearState];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    completionBlock(nil, parseError);
    [self clearState];
}

- (void)clearState {
    xmlParser = nil;
    stations = nil;
    station = nil;
    currentElement = nil;
    completionBlock = nil;
}

@end
