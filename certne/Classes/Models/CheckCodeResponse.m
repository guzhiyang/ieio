//
//  CheckCodeResponse.m
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckCodeResponse.h"

@implementation CheckCodeResponse
@synthesize status=_status;
@synthesize msg=_msg;
@synthesize session_id=_session_id;

-(void)dealloc
{
    self.msg        = nil;
    self.session_id = nil;
}

@end
