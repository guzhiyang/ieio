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

@property (nonatomic, strong) Client        *currentClient;
@property (strong, nonatomic) User          *currentUser;
@property (strong, nonatomic) NSString      *session_id;
@property (strong, nonatomic) NSString      *mobile;
@property (assign, nonatomic) CGFloat       longitude;
@property (assign, nonatomic) CGFloat       latitude;
@property (strong, nonatomic) NSString      *deviceToken;
@property (strong, nonatomic) NSString      *headImageKey;
@property (strong, nonatomic) NSData        *headImageData;

@property (assign, nonatomic) BOOL          sideBarShowing;

+(Global *)shareGlobal;
+(void)releaseGlobal;

@end
