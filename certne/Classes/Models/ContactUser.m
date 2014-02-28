//
//  ContactUser.m
//  certne
//
//  Created by apple on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ContactUser.h"

@implementation ContactUser
@synthesize avatar   = _avatar;
@synthesize name     = _name;
@synthesize position = _position;
@synthesize info     = _info;
@synthesize company  = _company;
@synthesize uid      = _uid;
@synthesize mobile   = _mobile;
@synthesize sort     = _sort;

-(void)dealloc
{
    self.avatar   = nil;
    self.name     = nil;
    self.position = nil;
    self.info     = nil;
    self.company  = nil;
    self.mobile   = nil;
    [super dealloc];
}

@end
