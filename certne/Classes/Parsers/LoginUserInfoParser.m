//
//  LoginUserInfoParser.m
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginUserInfoParser.h"
#import "SBJson.h"

@implementation LoginUserInfoParser

-(id)loginUserInfoParserWithJSONData:(NSData *)jsonData
{
    id jsonObject=[jsonData JSONValue];
    if ([[jsonObject class] isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDic=(NSDictionary *)jsonObject;
        
        LoginUserInfo *loginUserInfo=[[LoginUserInfo alloc] init];
        id statusObject = [jsonDic objectForKey:@"status"];
        if ([[statusObject class] isSubclassOfClass:[NSNumber class]]) {
            loginUserInfo.status=[statusObject integerValue];
        }
        
        id msgObject = [jsonDic objectForKey:@"msg"];
        if ([[msgObject class] isSubclassOfClass:[NSString class]]) {
            loginUserInfo.msg=(NSString *)msgObject;
        }
        
        id session_idObject = [jsonDic objectForKey:@"session_id"];
        if ([[session_idObject class] isSubclassOfClass:[NSString class]]) {
            loginUserInfo.session_id = (NSString *)session_idObject;
        }
        
        id userObject=[jsonDic objectForKey:@"user"];
        if ([[userObject class] isSubclassOfClass:[NSDictionary class]]) {
            NSDictionary *userDic = (NSDictionary *)userObject;
            User *user = [[User alloc] init];
            
            id uidObject = [userDic objectForKey:@"uid"];
            if ([[uidObject class] isSubclassOfClass:[NSNumber class]]) {
                user.uid = [uidObject integerValue];
            }
            
            id nameObject = [userDic objectForKey:@"name"];
            if ([[nameObject class] isSubclassOfClass:[NSString class]]) {
                user.name = (NSString *)nameObject;
            }
            
            id mobileObject = [userDic objectForKey:@"mobile"];
            if ([[mobileObject class] isSubclassOfClass:[NSString class]]) {
                user.mobile = (NSString *)mobileObject;
            }
            
            id birthdayObeject = [userDic objectForKey:@"birthday"];
            if ([[birthdayObeject class] isSubclassOfClass:[NSString class]]) {
                user.birthday = (NSString *)birthdayObeject;
            }
            
            id avatarObject = [userDic objectForKey:@"avatar"];
            if ([[avatarObject class] isSubclassOfClass:[NSString class]]) {
                user.avatar = (NSString *)avatarObject;
            }
            
            id companyObject=[userDic objectForKey:@"company"];
            if ([[companyObject class] isSubclassOfClass:[NSString class]]) {
                user.company=(NSString *)companyObject;
            }
            
            id departmentObject=[userDic objectForKey:@"department"];
            if ([[departmentObject class] isSubclassOfClass:[NSString class]]) {
                user.department=(NSString *)departmentObject;
            }
            
            id positionObject=[userDic objectForKey:@"position"];
            if ([[positionObject class] isSubclassOfClass:[NSString class]]) {
                user.position=(NSString *)positionObject;
            }
            
            id industryObject=[userDic objectForKey:@"industry"];
            if ([[industryObject class] isSubclassOfClass:[NSString class]]) {
                user.industry=(NSString *)industryObject;
            }
            
            id qqObject=[userDic objectForKey:@"qq"];
            if ([[qqObject class] isSubclassOfClass:[NSString class]]) {
                user.qq=(NSString *)qqObject;
            }
            
            id websiteObject=[userDic objectForKey:@"website"];
            if ([[websiteObject class] isSubclassOfClass:[NSString class]]) {
                user.website=(NSString *)websiteObject;
            }
            
            id emailObject=[userDic objectForKey:@"email"];
            if ([[emailObject class] isSubclassOfClass:[NSString class]]) {
                user.email=(NSString *)emailObject;
            }
            
            id addressObject=[userDic objectForKey:@"address"];
            if ([[addressObject class] isSubclassOfClass:[NSString class]]) {
                user.address=(NSString *)addressObject;
            }
            
            id telObject=[userDic objectForKey:@"tel"];
            if ([[telObject class] isSubclassOfClass:[NSString class]]) {
                user.tel=(NSString *)telObject;
            }
            
            id faxObject=[userDic objectForKey:@"fax"];
            if ([[faxObject class] isSubclassOfClass:[NSString class]]) {
                user.fax=(NSString *)faxObject;
            }
            
            id zipcodeObject=[userDic objectForKey:@"zipcode"];
            if ([[zipcodeObject class] isSubclassOfClass:[NSString class]]) {
                user.zipcode=[zipcodeObject integerValue];
            }
            
            loginUserInfo.currentUser = user;
        }
        return loginUserInfo;
    }
    return nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentString setString:@""];
    if ([elementName isEqualToString:@"user"]) {
        _loginUser = [[User alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_currentString setString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"status"]) {
        _loginUserInfo.status=[_currentString integerValue];
    }else if([elementName isEqualToString:@"msg"]){
        _loginUserInfo.msg        = _currentString;
    }else if ([elementName isEqualToString:@"session_id"]){
        _loginUserInfo.session_id = _currentString;
    }else if ([elementName isEqualToString:@"user"]){
        _loginUserInfo.currentUser = _loginUser;
        _loginUser = nil;
    }else if ([elementName isEqualToString:@"uid"]){
        _loginUser.uid=[_currentString integerValue];
    }else if ([elementName isEqualToString:@"name"]){
        _loginUser.name       = _currentString;
    }else if ([elementName isEqualToString:@"mobile"]){
        _loginUser.mobile     = _currentString;
    }else if ([elementName isEqualToString:@"birthday"]){
        _loginUser.birthday   = _currentString;
    }else if ([elementName isEqualToString:@"avatar"]){
        _loginUser.avatar     = _currentString;
    }else if ([elementName isEqualToString:@"company"]){
        _loginUser.company    = _currentString;
    }else if ([elementName isEqualToString:@"department"]){
        _loginUser.department = _currentString;
    }else if ([elementName isEqualToString:@"position"]){
        _loginUser.position   = _currentString;
    }else if ([elementName isEqualToString:@"industry"]){
        _loginUser.industry   = _currentString;
    }else if ([elementName isEqualToString:@"qq"]){
        _loginUser.qq         = _currentString;
    }else if ([elementName isEqualToString:@"website"]){
        _loginUser.website    = _currentString;
    }else if ([elementName isEqualToString:@"email"]){
        _loginUser.email      = _currentString;
    }else if ([elementName isEqualToString:@"address"]){
        _loginUser.address    = _currentString;
    }else if ([elementName isEqualToString:@"tel"]){
        _loginUser.tel        = _currentString;
    }else if ([elementName isEqualToString:@"fax"]){
        _loginUser.fax        = _currentString;
    }else if ([elementName isEqualToString:@"zipcode"]){
        _loginUser.zipcode=[_currentString integerValue];
    }
}

-(void)dealloc
{
    _currentString=nil;
}

@end
