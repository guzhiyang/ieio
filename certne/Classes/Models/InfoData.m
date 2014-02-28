//
//  InfoData.m
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "InfoData.h"

@implementation InfoData
@synthesize infoID         = _infoID;
@synthesize img            = _img;
@synthesize desc           = _desc;
@synthesize publishAddress = _publishAddress;
@synthesize infoType       = _infoType;
@synthesize addTime        = _addTime;

-(void)dealloc
{
    self.img            = nil;
    self.desc           = nil;
    self.publishAddress = nil;
    self.addTime        = nil;
    [super dealloc];
}

@end
