//
//  FindPswResponse.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FindPswResponse.h"

@implementation FindPswResponse
@synthesize status = _status;
@synthesize msg    = _msg;
@synthesize code   = _code;

-(void)dealloc
{
    self.msg = nil;
    [super dealloc];
}

@end
