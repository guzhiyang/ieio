//
//  NearbyUserList.m
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NearbyUserList.h"

@implementation NearbyUserList
@synthesize status          = _status;
@synthesize msg             = _msg;
@synthesize nearbyUserArray = _nearbyUserArray;
@synthesize nearbyUser      = _nearbyUser;

-(void)dealloc
{
    self.msg             = nil;
    self.nearbyUserArray = nil;
    self.nearbyUser      = nil;
}

@end
