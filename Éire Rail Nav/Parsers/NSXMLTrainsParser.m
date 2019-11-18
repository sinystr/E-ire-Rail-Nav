#import "NSXMLTrainsParser.h"

@implementation NSXMLTrainsParser
{
    NSXMLParser *xmlParser;
    NSMutableArray <TrainModel *> *trains;
    TrainModel *train;
    NSString *currentElement;
    void (^ completionBlock)(NSMutableArray<TrainModel *> *, NSError *);
}

- (void)parseTrainsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<TrainModel *> *, NSError *))completionHandler {
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
    trains = [NSMutableArray new];
}

- (void)   parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
       attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;

    if ([elementName isEqualToString:@"objStationData"]) {
        train = [TrainModel new];
    }
}

- (void)   parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"objStationData"]) {
        [trains addObject:train];
        train = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([trimmedString length] == 0) {
        return;
    }

    if ([currentElement isEqualToString:@"Traincode"]) {
        train.code = trimmedString;
        return;
    }

    if ([currentElement isEqualToString:@"Exparrival"]) {
        train.expectedArrivalTime = string;
        return;
    }

    if ([currentElement isEqualToString:@"Expdepart"]) {
        train.expectedDepartureTime = string;
        return;
    }

    if ([currentElement isEqualToString:@"Origin"]) {
        train.originStationName = string;
        return;
    }

    if ([currentElement isEqualToString:@"Destination"]) {
        train.destinationStationName = string;
        return;
    }
}

// MARK: Completion methods
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    completionBlock(nil, parseError);
    [self cleanState];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    completionBlock(trains, nil);
    [self cleanState];
}

- (void)cleanState {
    xmlParser = nil;
    trains = nil;
    train = nil;
    currentElement = nil;
    completionBlock = nil;
}

@end
