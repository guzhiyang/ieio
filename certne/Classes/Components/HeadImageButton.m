//
//  HeadImageButton.m
//  certne
//
//  Created by apple on 13-9-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HeadImageButton.h"

@implementation HeadImageButton
@synthesize cellSection = _cellSection;
@synthesize cellRow     = _cellRow;

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
