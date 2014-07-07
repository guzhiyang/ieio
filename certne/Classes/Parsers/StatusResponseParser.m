//
//  StatusResponseParser.m
//  certne
//
//  Created by apple on 13-12-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "StatusResponseParser.h"
#import "SBJson.h"

@implementation StatusResponseParser

-(id)StatusResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        StatusResponse *statusResponse = [[StatusResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            statusResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            statusResponse.msg = (NSString *)msgObject;
        }
        return statusResponse;
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _statusResponser.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _statusResponser.msg = _currentString;
    }
}

-(void)dealloc
{
}

@end
