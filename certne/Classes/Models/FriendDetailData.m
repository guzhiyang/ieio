//
//  FriendDetailData.m
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FriendDetailData.h"

@implementation FriendDetailData
@synthesize avatar     = _avatar;
@synthesize name       = _name;
@synthesize position   = _position;
@synthesize company    = _company;
@synthesize uid        = _uid;
@synthesize mobile     = _mobile;
@synthesize tel        = _tel;
@synthesize email      = _email;
@synthesize fax        = _fax;
@synthesize qq         = _qq;
@synthesize department = _department;
@synthesize industry   = _industry;
@synthesize website    = _website;
@synthesize address    = _address;
@synthesize zipcode    = _zipcode;

-(void)dealloc
{
    self.avatar     = nil;
    self.name       = nil;
    self.position   = nil;
    self.company    = nil;
    self.uid        = nil;
    self.mobile     = nil;
    self.tel        = nil;
    self.email      = nil;
    self.fax        = nil;
    self.qq         = nil;
    self.department = nil;
    self.industry   = nil;
    self.website    = nil;
    self.address    = nil;
    self.zipcode    = nil;
    [super dealloc];
}

@end
