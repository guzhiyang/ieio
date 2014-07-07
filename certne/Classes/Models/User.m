//
//  User.m
//  certne
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize uid        = _uid;
@synthesize name       = _name;
@synthesize mobile     = _mobile;
@synthesize birthday   = _birthday;
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
    self.name       = nil;
    self.mobile     = nil;
    self.birthday   = nil;
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
