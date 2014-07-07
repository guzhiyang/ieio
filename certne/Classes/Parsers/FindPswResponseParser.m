//
//  FindPswResponseParser.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FindPswResponseParser.h"
#import "SBJson.h"

@implementation FindPswResponseParser

-(id)FindPswResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        FindPswResponse *findPswResponse = [[FindPswResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            findPswResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            findPswResponse.msg = (NSString *)msgObject;
        }
        
        id codeObject = [jsonDic objectForKey:@"code"];
        if ([[codeObject class] isSubclassOfClass:[NSNumber class]]) {
            findPswResponse.code = [codeObject integerValue];
        }
        return findPswResponse;
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
        _findPswResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _findPswResponse.msg = _currentString;
    }else if ([elementName isEqualToString:@"code"]){
        _findPswResponse.code = [_currentString integerValue];
    }
}

#pragma mark - Moemory menagement methods

-(void)dealloc
{
}

@end
