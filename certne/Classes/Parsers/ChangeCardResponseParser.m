//
//  ChangeCardResponseParser.m
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChangeCardResponseParser.h"
#import "SBJson.h"

@implementation ChangeCardResponseParser

#pragma mark- Custom event methods

-(id)ChangeCardResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        StatusResponse *changeCardResponse = [[StatusResponse alloc] init];
        
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            changeCardResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            changeCardResponse.msg = (NSString *)msgObject;
        }
        
        return changeCardResponse;
    }
    return nil;
}

#pragma mark- XML parser

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
        _changeCardResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _changeCardResponse.msg    = _currentString;
    }
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
}

@end
