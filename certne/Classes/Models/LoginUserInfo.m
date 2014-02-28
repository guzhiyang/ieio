//
//  LoginUserInfo.m
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginUserInfo.h"

@implementation LoginUserInfo
@synthesize status      = _status;
@synthesize msg         = _msg;
@synthesize session_id  = _session_id;
@synthesize currentUser = _currentUser;

-(void)dealloc
{
    self.msg         = nil;
    self.session_id  = nil;
    self.currentUser = nil;
    [super dealloc];
}

@end
