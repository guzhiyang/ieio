//
//  MyFriendsInfoListParser.m
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MyFriendsInfoListParser.h"
#import "SBJson.h"

@implementation MyFriendsInfoListParser

-(id)sendMyFriendsInfoListParserWithJsonData:(NSData *)jsonData
{
    id jsonObject = [jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary    *jsonDic = (NSDictionary *)jsonObject;
        MyFriendsInfoList *friendsInfoList = [[MyFriendsInfoList alloc] init];
        
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            friendsInfoList.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            friendsInfoList.msg = (NSString *)msgObject;
        }
        
        NSArray *friendListArray = [[NSArray alloc] init];
        id listDataObject = [jsonDic objectForKey:@"data"];
        if ([[listDataObject class] isSubclassOfClass:[NSArray class]]) {
            
            friendListArray = (NSArray *)listDataObject;
            
            FriendsInfoListData *listData = [[FriendsInfoListData alloc] init];

            for (NSDictionary *listDataDic in friendListArray) {
                id uidObject = [listDataDic objectForKey:@"uid"];
                if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
                    listData.uid = [uidObject integerValue];
                }
                
                id avatarObject = [listDataDic objectForKey:@"avatar"];
                if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                    listData.avatar = (NSString *)avatarObject;
                }
                
                id nameObject = [listDataDic objectForKey:@"name"];
                if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                    listData.name = (NSString *)nameObject;
                }
                
                id positionObejct = [listDataDic objectForKey:@"position"];
                if ([[positionObejct class] isSubclassOfClass:[NSString class]]) {
                    listData.position = (NSString *)positionObejct;
                }
                
                id infoObect = [listDataDic objectForKey:@"info"];
                if ([[infoObect class] isSubclassOfClass:[NSString class]]) {
                    listData.info = (NSString *)infoObect;
                }
                
                id companyObject  = [listDataDic objectForKey:@"company"];
                if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                    listData.company  = (NSString *)companyObject;
                }
                
                id sortObject = [listDataDic objectForKey:@"sort"];
                if ([[sortObject class] isSubclassOfClass:[NSNumber class]]) {
                    listData.sort = [sortObject integerValue];
                }
            }
            
            friendsInfoList.data = listData;
        }
        friendsInfoList.friendListArray = friendListArray;
        friendListArray = nil;
        return friendsInfoList;
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _friendsListArray = [[NSArray alloc] init];
        _listData = [[FriendsInfoListData alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _myFriendsInfoList.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _myFriendsInfoList.msg    = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _myFriendsInfoList.friendListArray = _friendsListArray;
        _friendsListArray = nil;
    }else if ([elementName isEqualToString:@"uid"]){
        _listData.uid      = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"name"]){
        _listData.name     = _currentString;
    }else if ([elementName isEqualToString:@"avatar"]){
        _listData.avatar   = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _listData.position = _currentString;
    }else if ([elementName isEqualToString:@"info"]){
        _listData.info     = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _listData.company  = _currentString;
    }else if ([elementName isEqualToString:@"sort"]){
        _listData.sort = [_currentString integerValue];
    }
}

#pragma mark - Memroy menagement methods

-(void)dealloc
{
    _currentString = nil;
}

@end
