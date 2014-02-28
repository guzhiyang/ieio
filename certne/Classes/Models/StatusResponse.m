//
//  StatusResponse.m
//  certne
//
//  Created by apple on 13-12-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "StatusResponse.h"

@implementation StatusResponse
@synthesize status = _status;
@synthesize msg    = _msg;

-(void)dealloc
{
    self.msg = nil;
    [super dealloc];
}

@end
