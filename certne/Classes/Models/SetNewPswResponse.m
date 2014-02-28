//
//  SetNewPswResponse.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SetNewPswResponse.h"

@implementation SetNewPswResponse
@synthesize status    = _status;
@synthesize msg       = _msg;
@synthesize sessionid = _sessionid;

-(void)dealloc
{
    self.msg       = nil;
    self.sessionid = nil;
    [super dealloc];
}

@end
