//
//  ChangeCardListResponseParser.m
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChangeCardListResponseParser.h"
#import "SBJson.h"

@implementation ChangeCardListResponseParser

#pragma mark- Custom event methods

-(id)sendChangeCardListResponseParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        ChangeCardListResponse *cardListResponse = [[ChangeCardListResponse alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            cardListResponse.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            cardListResponse.msg = (NSString *)msgObject;
        }
        
        NSArray *dataArray = [[NSArray alloc] init];
        id dataObject = [jsonDic objectForKey:@"data"];
        if ([[dataObject class] isSubclassOfClass:[NSArray class]]) {
            dataArray = (NSArray *)dataObject;
            
            CardListData *data = [[CardListData alloc] init];
            
            for (NSDictionary *dataDic in dataArray) {
                id avatarObject = [jsonDic objectForKey:@"avatar"];
                if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                    data.avatar = (NSString *)avatarObject;
                }
                
                id nameObject = [jsonDic objectForKey:@"name"];
                if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                    data.name = (NSString *)nameObject;
                }
                
                id positionObject = [jsonDic objectForKey:@"position"];
                if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
                    data.position = (NSString *)positionObject;
                }
                
                id infoObject = [jsonDic objectForKey:@"info"];
                if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
                    data.info = (NSString *)infoObject;
                }
                
                id companyObject = [jsonDic objectForKey:@"company"];
                if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                    data.company = (NSString *)companyObject;
                }
                
                id uidObject = [jsonDic objectForKey:@"uid"];
                if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
                    data.uid = [uidObject integerValue];
                }
            }
            cardListResponse.data = data;
            data = nil;
        }
        cardListResponse.dataArray = dataArray;
        dataArray = nil;
        return cardListResponse;
    }
    return nil;
}

#pragma mark- XML parser

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _dataArray = [[NSArray alloc] init];
        _data = [[CardListData alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _changeCardListResponse.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _changeCardListResponse.msg    = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _changeCardListResponse.dataArray   = _dataArray;
        _dataArray = nil;
    }else if ([elementName isEqualToString:@"avatar"]){
        _data.avatar   = _currentString;
    }else if ([elementName isEqualToString:@"name"]){
        _data.name     = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _data.position = _currentString;
    }else if ([elementName isEqualToString:@"info"]){
        _data.info     = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _data.company  = _currentString;
    }else if ([elementName isEqualToString:@"uid"]){
        _data.uid      = [_currentString integerValue];
    }
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    _currentString = nil;
}

@end
