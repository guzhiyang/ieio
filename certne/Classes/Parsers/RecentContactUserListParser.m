//
//  RecentContactUserListParser.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RecentContactUserListParser.h"
#import "SBJson.h"

@implementation RecentContactUserListParser

-(id)RecentContactUserListParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonObject;
        
        RecentContactUserList *recentContactUserList = [[RecentContactUserList alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            recentContactUserList.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            recentContactUserList.msg = (NSString *)msgObject;
        }
        
        NSArray *dataArray = [[NSArray alloc] init];
        id dataObject = [jsonDic objectForKey:@"data"];
        if ([[dataObject class] isSubclassOfClass:[NSArray class]]) {
            dataArray = (NSArray *)dataObject;
            
            for (NSDictionary *userDic in dataArray) {
                ContactUser *user = [[ContactUser alloc] init];

                id avatarObject = [userDic objectForKey:@"avatar"];
                if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                    user.avatar = (NSString *)avatarObject;
                }
                
                id nameObject = [userDic objectForKey:@"name"];
                if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                    user.name = (NSString *)nameObject;
                }
                
                id positionObject = [userDic objectForKey:@"position"];
                if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
                    user.position = (NSString *)positionObject;
                }
                
                id infoObject = [userDic objectForKey:@"info"];
                if ([[infoObject class] isSubclassOfClass:[NSString class]]) {
                    user.info = (NSString *)infoObject;
                }
                
                id companyObject = [userDic objectForKey:@"company"];
                if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                    user.company = (NSString *)companyObject;
                }
                
                id uidObject = [userDic objectForKey:@"uid"];
                if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
                    user.uid = [uidObject integerValue];
                }
                
                id mobileObject = [userDic objectForKey:@"mobile"];
                if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
                    user.mobile = (NSString *)mobileObject;
                }
                
                id sortObject = [userDic objectForKey:@"sort"];
                if ([[sortObject class] isSubclassOfClass:[NSNumber class]]) {
                    user.sort = [sortObject integerValue];
                }
                
                recentContactUserList.contactuser = user;
            }
            recentContactUserList.dataArray = dataArray;
        }
        return recentContactUserList;
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _dataArray = [[NSArray alloc] init];
        _contactuser = [[ContactUser alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _recentContactUserList.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _recentContactUserList.msg    = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _recentContactUserList.dataArray   = _dataArray;
        _dataArray = nil;
    }else if ([elementName isEqualToString:@"avatar"]){
        _contactuser.avatar = _currentString;
    }else if ([elementName isEqualToString:@"name"]){
        _contactuser.name = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _contactuser.position = _currentString;
    }else if ([elementName isEqualToString:@"info"]){
        _contactuser.info = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _contactuser.company = _currentString;
    }else if ([elementName isEqualToString:@"uid"]){
        _contactuser.uid = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"mobile"]){
        _contactuser.mobile = _currentString;
    }else if ([elementName isEqualToString:@"sort"]){
        _contactuser.sort = [_currentString integerValue];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _currentString = nil;
}

@end
