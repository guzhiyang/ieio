//
//  RegisterResponse.m
//  certne
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RegisterResponse.h"

@implementation RegisterResponse

@synthesize status=_status;
@synthesize msg=_msg;
@synthesize code=_code;

-(void)dealloc
{
    self.msg=nil;
    [super dealloc];
}

@end
