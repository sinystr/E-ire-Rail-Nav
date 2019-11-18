#import "NSXMLTrainStopsParser.h"

@implementation NSXMLTrainStopsParser
{
    NSXMLParser *xmlParser;
    NSMutableArray <NSString *> *trainStops;
    NSString *currentElement;
    void (^ completionBlock)(NSMutableArray<NSString *> *, NSError *);
}

- (void)parseTrainStopsFrom:(nonnull NSData *)data completionHandler:(void (^)(NSMutableArray<NSString *> *, NSError *))completionHandler {
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
    trainStops = [NSMutableArray new];
}

- (void)   parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
       attributes:(NSDictionary *)attributeDict
{
    currentElement = elementName;
}

- (void)   parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
     namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
{
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return;
    }

    if ([currentElement isEqualToString:@"LocationFullName"]) {
        [trainStops addObject:string];
        return;
    }
}

// MARK: Completion methods
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    completionBlock(trainStops, nil);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    completionBlock(nil, parseError);
}

@end
