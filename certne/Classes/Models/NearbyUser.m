//
//  NearbyUser.m
//  certne
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NearbyUser.h"

@implementation NearbyUser
@synthesize avatar   = _avatar;
@synthesize name     = _name;
@synthesize position = _position;
@synthesize info     = _info;
@synthesize company  = _company;
@synthesize uid      = _uid;
@synthesize distance = _distance;
@synthesize mobile   = _mobile;

-(void)dealloc
{
    self.avatar   = nil;
    self.name     = nil;
    self.position = nil;
    self.info     = nil;
    self.company  = nil;
    self.mobile   = nil;
}

@end
