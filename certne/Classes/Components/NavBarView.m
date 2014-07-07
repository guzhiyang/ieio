//
//  NavBarView.m
//  certne
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

//--使用时 可以考虑将titleLabel属性撤掉

#import "NavBarView.h"
#import "Foundation.h"

@implementation NavBarView
@synthesize titleLabel     = _titleLabel;
@synthesize fallBackButton = _fallBackButton;
@synthesize delegate       = _delegate;

#pragma mark - View lifestyle methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 24)];
        _titleLabel.font = [UIFont fontWithName:FONTNAME size:20];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor       = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        
        _fallBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fallBackButton.frame = CGRectMake(10, 27, 30, 30);
        [_fallBackButton setBackgroundImage:[UIImage imageNamed:@"fall_back.png"] forState:UIControlStateNormal];
        [_fallBackButton addTarget:self action:@selector(fallBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fallBackButton];
        
        self.backgroundColor = themeColor;
    }
    return self;
}

#pragma mark - Custom event methods

-(void)fallBack
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(fallBackButtonClicked)]) {
        [_delegate fallBackButtonClicked];
    }
}

-(void)settitleLabelText:(NSString *)title
{
    self.titleLabel.text = title;
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.delegate = nil;
}

@end
