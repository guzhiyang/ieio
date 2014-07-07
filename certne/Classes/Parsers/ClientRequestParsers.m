//
//  ClientRequestParsers.m
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ClientRequestParsers.h"
#import "SBJson.h"

@implementation ClientRequestParsers

-(id)clientParserWithJSONData:(NSData *)jsonData
{
    id jsonObject=[jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic=(NSDictionary *)jsonObject;
        
        id clientObject=[jsonDic valueForKey:@"client"];
        if ([[clientObject class] isSubclassOfClass:[NSDictionary class]]) {
            NSDictionary *clientDic=(NSDictionary *)clientObject;
            Client *client=[[Client alloc]init];
            
            id clientIdObject=[clientDic valueForKey:@"id"];
            if ([[clientIdObject class] isSubclassOfClass:[NSNumber class]]) {
                client.userId=[(NSNumber *)clientIdObject integerValue];
            }
            
            id clientNameObject=[clientDic valueForKey:@"name"];
            if ([[clientNameObject class] isSubclassOfClass:[NSString class]]) {
                client.name=(NSString *)clientNameObject;
            }
            
            id clientHeadImageObject=[clientDic valueForKey:@"headImage"];
            if ([[clientHeadImageObject class] isSubclassOfClass:[NSString class]]) {
                client.headImage=(NSString *)clientHeadImageObject;
            }
            
            id clientPositionObject=[clientDic valueForKey:@"position"];
            if ([[clientPositionObject class] isSubclassOfClass:[NSString class]]) {
                client.position=(NSString *)clientPositionObject;
            }
            
            id clientSupplyObject=[clientDic valueForKey:@"supply"];
            if ([[clientSupplyObject class] isSubclassOfClass:[NSString class]]) {
                client.supply=(NSString *)clientSupplyObject;
            }
            
            id clientCompanyObject=[clientDic valueForKey:@"company"];
            if ([[clientCompanyObject class] isSubclassOfClass:[NSString class]]) {
                client.company=(NSString *)clientCompanyObject;
            }
            
            id clientPasswordObject=[clientDic valueForKey:@"password"];
            if ([[clientPasswordObject class] isSubclassOfClass:[NSString class]]) {
                client.password=(NSString *)clientPasswordObject;
            }
            
            return client;
        }
    }
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentValue setString:@""];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentValue setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"name"]) {
        _client.name=_currentValue;
    }else if ([elementName isEqualToString:@"headImage"]){
        _client.headImage=_currentValue;
    }else if ([elementName isEqualToString:@"position"]){
        _client.position=_currentValue;
    }else if ([elementName isEqualToString:@"supply"]){
        _client.supply=_currentValue;
    }else if ([elementName isEqualToString:@"company"]){
        _client.company=_currentValue;
    }else if ([elementName isEqualToString:@"id"]){
        _client.userId=[_currentValue integerValue];
    }else if ([elementName isEqualToString:@"password"]){
        _client.password=_currentValue;
    }
}

-(void)dealloc
{
    _currentValue=nil;
}

@end
