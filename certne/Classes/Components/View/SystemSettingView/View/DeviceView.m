//
//  DeviceView.m
//  certne
//
//  Created by apple on 13-5-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DeviceView.h"
#import <QuartzCore/QuartzCore.h>
#import "Foundation.h"

@implementation DeviceView
@synthesize deviceTextView = _deviceTextView;
@synthesize delegate       = _delegate;

#pragma mark - View alloc

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _deviceTextView=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, 310, 80)];
        [_deviceTextView setBackgroundColor:[UIColor whiteColor]];
        _deviceTextView.delegate=self;
        _deviceTextView.returnKeyType=UIReturnKeyDone;
        _deviceTextView.layer.borderColor=[UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1.0].CGColor;
        _deviceTextView.layer.borderWidth  = 1.0f;
        _deviceTextView.layer.cornerRadius = 4.0f;
        [_deviceTextView setFont:[UIFont fontWithName:FONTNAME size:14]];
        [_deviceTextView setTextColor:[UIColor grayColor]];
        [_deviceTextView setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_deviceTextView];
        
        UIImage *sendMessageImage=[UIImage imageNamed:@"btn_test.png"];
        UIImage *stetchSendMessageImage=[sendMessageImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
        
        UIButton *ensureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [ensureButton setFrame:CGRectMake(4, 93, 312, 36)];
        [ensureButton setTitle:@"确定发送" forState:UIControlStateNormal];
        [ensureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ensureButton setBackgroundImage:stetchSendMessageImage forState:UIControlStateNormal];
        [ensureButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [ensureButton addTarget:self action:@selector(ensureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ensureButton];
        
        self.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0];
    }
    return self;
}

#pragma mark - Custom event methods

-(void)ensureButtonClicked
{
    if ([self.deviceTextView.text length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"亲，不可以为空哦~"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else{
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(sendSuggestionMessage)]) {
            [_delegate sendSuggestionMessage];
        }
    }
}

#pragma mark - UITextView delegate methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    _deviceTextView=nil;
}

@end
