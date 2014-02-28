//
//  SendAdviceView.m
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SendAdviceView.h"
#import "Foundation.h"

@implementation SendAdviceView
@synthesize open;
@synthesize sendAdviceButton=_sendAdviceButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open=NO;
        _sendAdviceButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendAdviceButton setFrame:CGRectMake(0, 0, 320, 50)];
        [_sendAdviceButton setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_sendAdviceButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
        [_sendAdviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendAdviceButton setBackgroundColor:[UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0]];
        [_sendAdviceButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendAdviceButton];

    }
    return self;
}

-(void)buttonClicked
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(sendAdviceButtonClicked:)]) {
            [_delegate sendAdviceButtonClicked:self];
        }
    }
}

@end
