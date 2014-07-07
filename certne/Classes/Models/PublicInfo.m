//
//  PublicInfo.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PublicInfo.h"

@implementation PublicInfo
@synthesize infoID         = _infoID;
@synthesize avatar         = _avatar;
@synthesize name           = _name;
@synthesize company        = _company;
@synthesize mobile         = _mobile;
@synthesize img            = _img;
@synthesize desc           = _desc;
@synthesize infoType       = _infoType;
@synthesize publishAddress = _publishAddress;
@synthesize addTime        = _addTime;

-(void)dealloc
{
    self.avatar         = nil;
    self.name           = nil;
    self.company        = nil;
    self.mobile         = nil;
    self.img            = nil;
    self.desc           = nil;
    self.publishAddress = nil;
    self.addTime        = nil;
}

@end
