//
//  SessionID.m
//  certne
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SessionID.h"

@implementation SessionID
@synthesize uid        = _uid;
@synthesize mobile     = _mobile;
@synthesize sessionID  = _sessionID;
@synthesize name       = _name;
@synthesize avatar     = _avatar;
@synthesize company    = _company;
@synthesize department = _department;
@synthesize position   = _position;
@synthesize industry   = _industry;
@synthesize qq         = _qq;
@synthesize website    = _website;
@synthesize email      = _email;
@synthesize address    = _address;
@synthesize tel        = _tel;
@synthesize fax        = _fax;
@synthesize zipcode    = _zipcode;

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
    [super dealloc];
}

@end
