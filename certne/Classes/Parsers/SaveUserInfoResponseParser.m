//
//  SaveUserInfoResponseParser.m
//  certne
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SaveUserInfoResponseParser.h"
#import "SBJson.h"

@implementation SaveUserInfoResponseParser

-(id)SaveUserInfoResponseParserWithJSONData:(NSData *)jsonData
{
    id JSONDataObject = [jsonData JSONValue];
    if ([[JSONDataObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic=(NSDictionary *)JSONDataObject;
        
        StatusResponse *saveUserInfoResponse=[[StatusResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            saveUserInfoResponse.status = [statusObject integerValue];
        }
        
        id msgObject=[jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            saveUserInfoResponse.msg = (NSString *)msgObject;
        }
        
        return [saveUserInfoResponse autorelease];
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
        _saveUserInfoResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _saveUserInfoResponse.msg = _currentString;
    }
}

#pragma mark- Memory menagement mthods

- (void)dealloc
{
    [super dealloc];
}

@end
