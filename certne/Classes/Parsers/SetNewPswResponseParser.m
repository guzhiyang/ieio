//
//  SetNewPswResponseParser.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SetNewPswResponseParser.h"
#import "SBJson.h"

@implementation SetNewPswResponseParser

-(id)setNewPswResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        SetNewPswResponse *setNewPswResponse = [[SetNewPswResponse alloc] init];
        
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            setNewPswResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            setNewPswResponse.msg = (NSString *)msgObject;
        }
        
        id sessionidObject = [jsonDic objectForKey:@"session_id"];
        if ([[sessionidObject class] isSubclassOfClass:[NSString class]]) {
            setNewPswResponse.sessionid = (NSString *)sessionidObject;
        }
        return [setNewPswResponse autorelease];
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
        _setNewPswResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _setNewPswResponse.msg = _currentString;
    }else if ([elementName isEqualToString:@"session_id"]){
        _setNewPswResponse.sessionid = _currentString;
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _currentString = nil;
    [super dealloc];
}

@end
