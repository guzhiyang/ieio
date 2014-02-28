//
//  CellButton.m
//  certne
//
//  Created by apple on 14-1-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CellButton.h"

@implementation CellButton
@synthesize cellRow     = _cellRow;
@synthesize cellSection = _cellSection;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end
