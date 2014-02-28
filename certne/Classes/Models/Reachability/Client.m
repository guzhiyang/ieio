//
//  Client.m
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Client.h"

@implementation Client

- (void)dealloc
{
    self.headImage=nil;
    self.name=nil;
    self.position=nil;
    self.supply=nil;
    self.company=nil;
    self.password=nil;
    [super dealloc];
}

@end
