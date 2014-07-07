//
//  FriendsInfoListData.m
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FriendsInfoListData.h"

@implementation FriendsInfoListData
@synthesize uid      = _uid;
@synthesize avatar   = _avatar;
@synthesize name     = _name;
@synthesize position = _position;
@synthesize info     = _info;
@synthesize company  = _company;
@synthesize sort     = _sort;

-(void)dealloc
{
    self.avatar   = nil;
    self.name     = nil;
    self.position = nil;
    self.info     = nil;
    self.company  = nil;
}

@end
