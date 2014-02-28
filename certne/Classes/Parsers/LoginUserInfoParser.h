//
//  LoginUserInfoParser.h
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserInfo.h"

@interface LoginUserInfoParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    LoginUserInfo       *_loginUserInfo;
    User                *_loginUser;
}

-(id)loginUserInfoParserWithJSONData:(NSData *)jsonData;

@end
