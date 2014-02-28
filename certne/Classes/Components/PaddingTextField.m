//
//  PaddingTextField.m
//  certne
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PaddingTextField.h"

@implementation PaddingTextField
@synthesize verticalPadding=_verticalPadding;
@synthesize horizontalPadding=_horizontalPadding;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+self.horizontalPadding, bounds.origin.y+self.verticalPadding, bounds.size.width-self.horizontalPadding*2, bounds.size.height-self.verticalPadding*2);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end
