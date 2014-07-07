//
//  NearbyUserListParser.m
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NearbyUserListParser.h"
#import "SBJson.h"

@implementation NearbyUserListParser

-(id)NearbyUserListParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        NearbyUserList *nearbyUserList = [[NearbyUserList alloc] init];
        
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            nearbyUserList.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            nearbyUserList.msg = (NSString *)msgObject;
        }
        
        NSArray *dataArray = [[NSArray alloc] init];
        id dataObject = [jsonDic objectForKey:@"data"];
        if ([[dataObject class] isSubclassOfClass:[NSMutableArray class]]) {
            
            dataArray = (NSArray *)dataObject;
            
            for (NSDictionary *nearbyUser in dataArray) {
                NearbyUser *nearbyUser = [[NearbyUser alloc] init];
                
                id avatarObject = [jsonDic objectForKey:@"avatar"];
                if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.avatar = (NSString *)avatarObject;
                }
                
                id nameObject = [jsonDic objectForKey:@"name"];
                if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.name = (NSString *)nameObject;
                }
                
                id positionObject = [jsonDic objectForKey:@"position"];
                if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.position = (NSString *)positionObject;
                }
                
                id infoObject = [jsonDic objectForKey:@"info"];
                if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.info = (NSString *)infoObject;
                }
                
                id companyObject = [jsonDic objectForKey:@"company"];
                if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.company = (NSString *)companyObject;
                }
                
                id uidObject = [jsonDic objectForKey:@"uid"];
                if ([[uidObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.uid = [uidObject integerValue];
                }
                
                id distanceObject = [jsonDic objectForKey:@"distance"];
                if ([[distanceObject class] isSubclassOfClass:[NSNumber class]]) {
                    nearbyUser.distance = [distanceObject integerValue];
                }

                id mobileObject = [jsonDic objectForKey:@"mobile"];
                if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
                    nearbyUser.mobile = (NSString *)mobileObject;
                }
                
                nearbyUserList.nearbyUser = nearbyUser;
            }
            nearbyUserList.nearbyUserArray = dataArray;
        }
        return nearbyUserList;
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _dataArray = [[NSArray alloc] init];
        _nearbyUser = [[NearbyUser alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _nearbyUserList.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _nearbyUserList.msg    = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _nearbyUserList.nearbyUserArray   = _dataArray;
    }else if ([elementName isEqualToString:@"avatar"]){
        _nearbyUser.avatar   = _currentString;
    }else if ([elementName isEqualToString:@"name"]){
        _nearbyUser.name     = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _nearbyUser.position = _currentString;
    }else if ([elementName isEqualToString:@"info"]){
        _nearbyUser.info = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _nearbyUser.company  = _currentString;
    }else if ([elementName isEqualToString:@"uid"]){
        _nearbyUser.uid = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"distance"]){
        _nearbyUser.distance = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"mobile"]){
        _nearbyUser.mobile   = _currentString;
    }
}

-(void)dealloc
{
    _currentString = nil;
}

@end
