//
//  MarginTextField.m
//  certne
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MarginTextField.h"

#define kTextFieldPaddingWidth  (10.0f)
#define kTextFieldPaddingHeight (10.0f)

@implementation MarginTextField
@synthesize dx=_dx;
@synthesize dy=_dy;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.dx==0.0f?kTextFieldPaddingWidth:self.dx, self.dy==0.0f?kTextFieldPaddingHeight:self.dy);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.dx==0.0f?kTextFieldPaddingWidth:self.dx, self.dy==0.0f?kTextFieldPaddingHeight:self.dy);
}

-(void)setDx:(CGFloat)dx
{
    _dx=dx;
    [self setNeedsDisplay];
}

-(void)setDy:(CGFloat)dy
{
    _dy=dy;
    [self setNeedsDisplay];
}

@end
