//
//  MyFriendsInfoList.m
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MyFriendsInfoList.h"

@implementation MyFriendsInfoList
@synthesize status          = _status;
@synthesize msg             = _msg;
@synthesize data            = _data;
@synthesize friendListArray = _friendListArray;

-(void)dealloc
{
    self.msg  = nil;
    self.data = nil;
    self.friendListArray = nil;
}

@end
