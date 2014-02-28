//
//  Global.h
//  certne
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"
#import "User.h"

@interface Global : NSObject
{
    Client      *_currentClient;
    User        *_currentUser;
    NSString    *_session_id;
    NSString    *_mobile;
    CGFloat     _longitude;
    CGFloat     _latitude;
    NSString    *_deviceToken;
    NSString    *_headImageKey;
    
    NSData      *_headImageData;
}

@property (nonatomic, retain) Client        *currentClient;
@property (retain, nonatomic) User          *currentUser;
@property (retain, nonatomic) NSString      *session_id;
@property (retain, nonatomic) NSString      *mobile;
@property (assign, nonatomic) CGFloat       longitude;
@property (assign, nonatomic) CGFloat       latitude;
@property (retain, nonatomic) NSString      *deviceToken;
@property (retain, nonatomic) NSString      *headImageKey;
@property (retain, nonatomic) NSData        *headImageData;

+(Global *)shareGlobal;
+(void)releaseGlobal;

@end
