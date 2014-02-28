//
//  RecentContactUserList.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RecentContactUserList.h"

@implementation RecentContactUserList
@synthesize status      = _status;
@synthesize msg         = _msg;
@synthesize dataArray   = _dataArray;
@synthesize contactuser = _contactuser;

-(void)dealloc
{
    self.msg         = nil;
    self.dataArray   = nil;
    self.contactuser = nil;
    [super dealloc];
}

@end
