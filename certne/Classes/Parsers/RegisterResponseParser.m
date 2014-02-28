//
//  RegisterResponseParser.m
//  certne
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RegisterResponseParser.h"
#import "SBJson.h"

@implementation RegisterResponseParser

-(id)requestResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject=[jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic=(NSDictionary *)jsonObject;
        
        RegisterResponse *registerResponse=[[RegisterResponse alloc] init];
        id statusObject=[jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            registerResponse.status=[statusObject integerValue];
        }
        
        id msgObject=[jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            registerResponse.msg=(NSString *)msgObject;
        }
        
        id codeObject=[jsonDic objectForKey:@"code"];
        if ([[codeObject class] isSubclassOfClass:[NSNumber class]]) {
            registerResponse.code=[codeObject integerValue];
        }
        return [registerResponse autorelease];
    }
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _registerResponse.status=[_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _registerResponse.msg=_currentString;
    }else if ([elementName isEqualToString:@"code"]){
        _registerResponse.code=[_currentString integerValue];
    }
}

-(void)dealloc
{
    _currentString=nil;
    [super dealloc];
}

@end
