//
//  PublicInfoResponse.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PublicInfoResponse.h"

@implementation PublicInfoResponse
@synthesize status     = _status;
@synthesize msg        = _msg;
@synthesize dataArray  = _dataArray;
@synthesize publicInfo = _publicInfo;

-(void)dealloc
{
    self.msg        = nil;
    self.dataArray  = nil;
    self.publicInfo = nil;
    [super dealloc];
}

@end
