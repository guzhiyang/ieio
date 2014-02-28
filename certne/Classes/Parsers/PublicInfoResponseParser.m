//
//  PublicInfoResponseParser.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PublicInfoResponseParser.h"
#import "SBJson.h"

@implementation PublicInfoResponseParser

-(id)PublicInfoResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        PublicInfoResponse *publicInfoResponse = [[PublicInfoResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            publicInfoResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            publicInfoResponse.msg = (NSString *)msgObject;
        }
        
        NSArray *dataArray = [[NSArray alloc] init];
        id dataObejct = [jsonDic objectForKey:@"data"];
        if ([[dataObejct class] isSubclassOfClass:[NSMutableArray class]]) {
            dataArray = (NSArray *)dataObejct;
            
            for (NSDictionary *messageInfo in dataArray) {
                PublicInfo *publicInfo = [[PublicInfo alloc] init];
                
                id infoIDObject = [messageInfo objectForKey:@"info_id"];
                if ([[infoIDObject class] isSubclassOfClass:[NSNumber class]]) {
                    publicInfo.infoID = [infoIDObject integerValue];
                }
                
                id avatarObject = [messageInfo objectForKey:@"avatar"];
                if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.avatar = (NSString *)avatarObject;
                }
                
                id nameObject = [messageInfo objectForKey:@"name"];
                if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.name = (NSString *)nameObject;
                }
                
                id companyObject = [messageInfo objectForKey:@"company"];
                if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.company = (NSString *)companyObject;
                }
                
                id mobileObject = [messageInfo objectForKey:@"mobile"];
                if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.mobile = (NSString *)mobileObject;
                }
                
                id imgObject = [messageInfo objectForKey:@"imgs"];
                if ([[imgObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.img = (NSString *)imgObject;
                }
                
                id descObject = [messageInfo objectForKey:@"desc"];
                if ([[descObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.desc = (NSString *)descObject;
                }
                
                id infoTypeObject = [messageInfo objectForKey:@"info_type"];
                if ([[infoIDObject class] isSubclassOfClass:[NSNumber class]]) {
                    publicInfo.infoType = [infoTypeObject integerValue];
                }
                
                id publishAddressObject = [messageInfo objectForKey:@"address"];
                if ([[publishAddressObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.publishAddress = (NSString *)publishAddressObject;
                }
                
                id addTimeObject = [messageInfo objectForKey:@"add_time"];
                if ([[addTimeObject class] isSubclassOfClass:[NSString class]]) {
                    publicInfo.addTime = (NSString *)addTimeObject;
                }
                
                publicInfoResponse.publicInfo = publicInfo;
                [publicInfo release];
            }
            publicInfoResponse.dataArray = dataArray;
        }
        [dataArray release];
        return [publicInfoResponse autorelease];
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _dataArray = [[NSMutableArray alloc] init];
        _publicInfo = [[PublicInfo alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _publicInfoResponse.status    = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _publicInfoResponse.msg       = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _publicInfoResponse.dataArray = _dataArray;
        [_dataArray release];
        _dataArray = nil;
    }else if ([elementName isEqualToString:@"uid"]){
        _publicInfo.infoID         = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"avatar"]){
        _publicInfo.avatar         = _currentString;
    }else if ([elementName isEqualToString:@"name"]){
        _publicInfo.name           = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _publicInfo.company        = _currentString;
    }else if ([elementName isEqualToString:@"mobile"]){
        _publicInfo.mobile         = _currentString;
    }else if ([elementName isEqualToString:@"imgs"]){
        _publicInfo.img            = _currentString;
    }else if ([elementName isEqualToString:@"desc"]){
        _publicInfo.desc           = _currentString;
    }else if ([elementName isEqualToString:@"type"]){
        _publicInfo.infoType       = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"address"]){
        _publicInfo.publishAddress = _currentString;
    }else if ([elementName isEqualToString:@"add_time"]){
        _publicInfo.addTime        = _currentString;
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _currentString = nil;
    [super dealloc];
}

@end
