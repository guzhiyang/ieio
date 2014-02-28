//
//  PrivacySetView.m
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PrivacySetView.h"
#import "Foundation.h"

@implementation PrivacySetView
@synthesize open;
@synthesize privacySetButton=_privacySetButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open=NO;
        _privacySetButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_privacySetButton setFrame:CGRectMake(0, 0, 320, 50)];
        [_privacySetButton setTitle:@"隐私设置" forState:UIControlStateNormal];
        [_privacySetButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
        [_privacySetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_privacySetButton setBackgroundColor:[UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0]];
        [_privacySetButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_privacySetButton];
    }
    return self;
}

-(void)buttonClicked
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(privacySetButtonClick:)]) {
            [_delegate privacySetButtonClick:self];
        }
    }
}

@end
