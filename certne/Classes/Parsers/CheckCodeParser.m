//
//  CheckCodeParser.m
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckCodeParser.h"
#import "SBJson.h"

@implementation CheckCodeParser

-(id)checkCodeResponseParserWithJSONData:(NSData *)jsonData
{
    id jsonObject=[jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic=(NSDictionary *)jsonObject;
        
        CheckCodeResponse *checkCodeResponse=[[CheckCodeResponse alloc] init];
        id statusObject=[jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            checkCodeResponse.status=[statusObject integerValue];
        }
        
        id msgObject=[jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            checkCodeResponse.msg=(NSString *)msgObject;
        }
        
        id session_idObject=[jsonDic objectForKey:@"session_id"];
        if ([[session_idObject class] isSubclassOfClass:[NSString class]]) {
            checkCodeResponse.session_id=(NSString *)session_idObject;
        }
        return checkCodeResponse;
    }
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_curentString setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_curentString setString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _checkCodeResponse.status=[_curentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _checkCodeResponse.msg=_curentString;
    }else if ([elementName isEqualToString:@"session_id"]){
        _checkCodeResponse.session_id=_curentString;
    }
}

-(void)dealloc
{
    _curentString=nil;
}

@end
