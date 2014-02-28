//
//  HeadNavView.m
//  certne
//
//  Created by apple on 13-6-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HeadNavView.h"
#import <QuartzCore/QuartzCore.h>
#import "Foundation.h"

@implementation HeadNavView
@synthesize fallbackButton=_fallbackButton;
@synthesize titleLabel=_titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *tempBackGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 65)];
        [tempBackGroundImageView setBackgroundColor:[UIColor whiteColor]];
        tempBackGroundImageView.layer.cornerRadius  = 12.0;
        tempBackGroundImageView.layer.borderColor   = [UIColor whiteColor].CGColor;
        tempBackGroundImageView.layer.borderWidth   = 2.0f;
        tempBackGroundImageView.layer.shadowOffset  = CGSizeMake(0, 0);
        tempBackGroundImageView.layer.shadowOpacity = 0.5;
        tempBackGroundImageView.layer.shadowRadius  = 12.0;
        tempBackGroundImageView.layer.shadowColor   = [UIColor grayColor].CGColor;
        [self addSubview:tempBackGroundImageView];
        [tempBackGroundImageView release];
        
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 12)];
        [tempImageView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tempImageView];
        [tempImageView release];
        
        _fallbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fallbackButton setFrame:CGRectMake(270, 17, 30, 30)];
        [_fallbackButton setBackgroundImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
        [self addSubview:_fallbackButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 18, 80, 30)];
        [_titleLabel setFont:[UIFont fontWithName:FONTNAME size:20]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)dealloc
{
    [_titleLabel release];
    _titleLabel=nil;
    [super dealloc];
}

@end
