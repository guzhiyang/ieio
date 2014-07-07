//
//  SessionID.m
//  certne
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SessionID.h"

@implementation SessionID

-(void)dealloc
{
    self.sessionID  = nil;
    self.mobile     = nil;
    self.name       = nil;
    self.avatar     = nil;
    self.company    = nil;
    self.department = nil;
    self.position   = nil;
    self.industry   = nil;
    self.qq         = nil;
    self.website    = nil;
    self.email      = nil;
    self.address    = nil;
    self.tel        = nil;
    self.fax        = nil;
}

@end
