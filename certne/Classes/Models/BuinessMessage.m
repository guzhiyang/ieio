//
//  BuinessMessage.m
//  certne
//
//  Created by apple on 13-11-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BuinessMessage.h"

@implementation BuinessMessage

-(void)dealloc
{
    self.proImageURLString=nil;
    self.proMessage=nil;
    self.dateString=nil;
    self.location=nil;
    [super dealloc];
}

@end
