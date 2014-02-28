//
//  PushMessage.m
//  certne
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PushMessage.h"

@implementation PushMessage
@synthesize uid      = _uid;
@synthesize avatar   = _avatar;
@synthesize time     = _time;
@synthesize message  = _message;
@synthesize totalNum = _totalNum;

-(void)dealloc
{
    self.avatar  = nil;
    self.time    = nil;
    self.message = nil;
    [super dealloc];
}

@end
