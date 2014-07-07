//
//  DoExchangeResponseParser.m
//  certne
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DoExchangeResponseParser.h"
#import "SBJson.h"

@implementation DoExchangeResponseParser

#pragma mark- Custom event methods

-(id)doExchangeResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObect = [jsonData JSONValue];
    if ([[jsonObect class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObect;
        
        StatusResponse *doExchangeResponse = [[StatusResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            doExchangeResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            doExchangeResponse.msg = (NSString *)msgObject;
        }
        return doExchangeResponse;
    }
    return nil;
}

#pragma mark- XML Parser delegate

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
        _doExchangeResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _doExchangeResponse.msg = _currentString;
    }
}

-(void)dealloc
{
    _currentString = nil;
}

@end
