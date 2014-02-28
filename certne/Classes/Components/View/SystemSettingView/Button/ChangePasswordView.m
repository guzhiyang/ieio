//
//  ChangePasswordView.m
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChangePasswordView.h"
#import "Foundation.h"

@implementation ChangePasswordView
@synthesize open;
@synthesize changePassButton=_changePassButton;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open=NO;
        _changePassButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_changePassButton setFrame:CGRectMake(0, 0, 320, 50)];
        [_changePassButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [_changePassButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
        [_changePassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changePassButton setBackgroundColor:[UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0]];
        [_changePassButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changePassButton];
    }
    return self;
}

-(void)buttonClicked
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(ChangePsdButtonClicked:)]) {
            [_delegate ChangePsdButtonClicked:self];
        }
    }
}

@end
