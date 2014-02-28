//
//  ChangeCardListResponse.m
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChangeCardListResponse.h"

@implementation ChangeCardListResponse
@synthesize status    = _status;
@synthesize msg       = _msg;
@synthesize dataArray = _dataArray;
@synthesize data      = _data;

-(void)dealloc
{
    self.msg       = nil;
    self.dataArray = nil;
    self.data      = nil;
    [super dealloc];
}

@end
