//
//  FriendInfoAndMessageParser.m
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FriendInfoAndMessageParser.h"
#import "SBJson.h"

@implementation FriendInfoAndMessageParser

-(id)friendInfoAndMessageParserWithJsonData:(NSData *)jsonData
{
    id jsonOject = [jsonData JSONValue];
    if ([[jsonOject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic = (NSDictionary *)jsonOject;
        
        FriendInfoAndMessage *friendInfoAndMessage = [[FriendInfoAndMessage alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            friendInfoAndMessage.status = [statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            friendInfoAndMessage.msg = (NSString *)msgObject;
        }
        
        id dataObject = [jsonDic objectForKey:@"data"];
        if ([[dataObject class]isSubclassOfClass:[NSDictionary class]]) {
            
            NSDictionary *detailDataDic = (NSDictionary *)dataObject;
            FriendDetailData *data = [[FriendDetailData alloc] init];
            
            id avatarObject = [detailDataDic objectForKey:@"avatar"];
            if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                data.avatar = (NSString *)avatarObject;
            }
            
            id nameObject = [detailDataDic objectForKey:@"name"];
            if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                data.name = (NSString *)nameObject;
            }
            
            id positionObject =[detailDataDic objectForKey:@"position"];
            if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
                data.position = (NSString *)positionObject;
            }
            
            NSArray *infoArray = [[NSArray alloc] init];
            id infoObject = [detailDataDic objectForKey:@"info"];
            if ([[infoObject class] isSubclassOfClass:[NSArray class]]) {
                infoArray = (NSArray *)infoObject;
                
                for (NSDictionary *infoDic in infoArray) {
                    InfoData *infoData = [[InfoData alloc] init];
                    
                    id infoIDObject = [infoDic objectForKey:@"info_id"];
                    if ([[infoIDObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.infoID = [infoIDObject integerValue];
                    }
                    
                    id imgObject = [infoDic objectForKey:@"imgs"];
                    if ([[imgObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.img = (NSString *)imgObject;
                    }
                    
                    id descObject = [infoDic objectForKey:@"desc"];
                    if ([[descObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.desc = (NSString *)descObject;
                    }
                    
                    id addressObject = [infoDic objectForKey:@"publish_address"];
                    if ([[addressObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.publishAddress = (NSString *)addressObject;
                    }
                    
                    id infoTypeObject = [infoDic objectForKey:@"info_type"];
                    if ([[infoTypeObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.infoType = [infoTypeObject integerValue];
                    }
                    
                    id addTimeObject = [infoDic objectForKey:@"add_time"];
                    if ([[addTimeObject class] isSubclassOfClass:[NSString class]]) {
                        infoData.addTime = (NSString *)addTimeObject;
                    }
                    friendInfoAndMessage.infoData = infoData;
                    [infoData release];
                }
                friendInfoAndMessage.infoArray = infoArray;
            }
            [infoArray release];
            
            id companyObject = [detailDataDic objectForKey:@"company"];
            if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                data.company = (NSString *)companyObject;
            }
            
            id uidObject = [detailDataDic objectForKey:@"uid"];
            if ([[uidObject class] isSubclassOfClass:[NSString class]]) {
                data.uid = (NSString *)uidObject;
            }
            
            id mobielObject = [detailDataDic objectForKey:@"mobile"];
            if ([[mobielObject class] isSubclassOfClass:[NSString class]]) {
                data.mobile = (NSString *)mobielObject;
            }
            
            id telObject = [detailDataDic objectForKey:@"tel"];
            if ([[telObject class] isSubclassOfClass:[NSString class]]) {
                data.tel = (NSString *)telObject;
            }
            
            id emailObject = [detailDataDic objectForKey:@"email"];
            if ([[emailObject class] isSubclassOfClass:[NSString class]]) {
                data.email = (NSString *)emailObject;
            }
            
            id faxObject = [detailDataDic objectForKey:@"fax"];
            if ([[faxObject class] isSubclassOfClass:[NSString class]]) {
                data.fax = (NSString *)faxObject;
            }
            
            id qqObject = [detailDataDic objectForKey:@"qq"];
            if ([[qqObject class] isSubclassOfClass:[NSString class]]) {
                data.qq = (NSString *)qqObject;
            }
            
            id departMentObjet = [detailDataDic objectForKey:@"department"];
            if ([[departMentObjet class] isSubclassOfClass:[NSString class]]) {
                data.department = (NSString *)departMentObjet;
            }
            
            id industryObject = [detailDataDic objectForKey:@"industry"];
            if ([[industryObject class] isSubclassOfClass:[NSString class]]) {
                data.industry = (NSString *)industryObject;
            }
            
            id websiteObject = [detailDataDic objectForKey:@"website"];
            if ([[websiteObject class] isSubclassOfClass:[NSString class]]) {
                data.website = (NSString *)websiteObject;
            }
            
            id addressObject = [detailDataDic objectForKey:@"address"];
            if ([[addressObject class] isSubclassOfClass:[NSString class]]) {
                data.address = (NSString *)addressObject;
            }
            
            id zipcodeObject = [detailDataDic objectForKey:@"zipcode"];
            if ([[zipcodeObject class] isSubclassOfClass:[NSString class]]) {
                data.zipcode = (NSString *)zipcodeObject;
            }
            
            friendInfoAndMessage.data = data;
            [data release];
        }
        return [friendInfoAndMessage autorelease];
    }
    return nil;
}

#pragma mark - XML delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"data"]) {
        _data = [[FriendDetailData alloc] init];
    }else if ([elementName isEqualToString:@"info"]){
        _infodata = [[InfoData alloc] init];
        _infoArray = [[NSArray alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _friendInfoMsg.status = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"msg"]){
        _friendInfoMsg.msg    = _currentString;
    }else if ([elementName isEqualToString:@"data"]){
        _friendInfoMsg.data   = _data;
        [_data release];
        _data = nil;
    }else if ([elementName isEqualToString:@"avatar"]){
        _data.avatar   = _currentString;
    }else if ([elementName isEqualToString:@"name"]){
        _data.name     = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _data.position = _currentString;
    }else if ([elementName isEqualToString:@"info"]){
        _friendInfoMsg.infoArray = _infoArray;
        [_infoArray release];
        _infoArray = nil;
    }else if ([elementName isEqualToString:@"info_id"]){
        _infodata.infoID         = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"imgs"]){
        _infodata.img            = _currentString;
    }else if ([elementName isEqualToString:@"desc"]){
        _infodata.desc           = _currentString;
    }else if ([elementName isEqualToString:@"publish_address"]){
        _infodata.publishAddress = _currentString;
    }else if ([elementName isEqualToString:@"info_type"]){
        _infodata.infoType       = [_currentString integerValue];
    }else if ([elementName isEqualToString:@"add_time"]){
        _infodata.addTime        = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _data.company    = _currentString;
    }else if ([elementName isEqualToString:@"uid"]){
        _data.uid        = _currentString;
    }else if ([elementName isEqualToString:@"mobile"]){
        _data.mobile     = _currentString;
    }else if ([elementName isEqualToString:@"tel"]){
        _data.tel        = _currentString;
    }else if ([elementName isEqualToString:@"email"]){
        _data.email      = _currentString;
    }else if ([elementName isEqualToString:@"fax"]){
        _data.fax        = _currentString;
    }else if ([elementName isEqualToString:@"qq"]){
        _data.qq         = _currentString;
    }else if ([elementName isEqualToString:@"department"]){
        _data.department = _currentString;
    }else if ([elementName isEqualToString:@"industry"]){
        _data.industry   = _currentString;
    }else if ([elementName isEqualToString:@"website"]){
        _data.website    = _currentString;
    }else if ([elementName isEqualToString:@"address"]){
        _data.address    = _currentString;
    }else if ([elementName isEqualToString:@"zipcode"]){
        _data.zipcode    = _currentString;
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _currentString = nil;
    [super dealloc];
}

@end
