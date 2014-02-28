//
//  FriendInfoAndMessage.m
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FriendInfoAndMessage.h"

@implementation FriendInfoAndMessage
@synthesize status    = _status;
@synthesize msg       = _msg;
@synthesize data      = _data;
@synthesize infoArray = _infoArray;

-(void)dealloc
{
    self.msg       = nil;
    self.data      = nil;
    self.infoArray = nil;
    [super dealloc];
}

@end
