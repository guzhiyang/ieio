//
//  PassWordView.m
//  certne
//
//  Created by apple on 13-5-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PassWordView.h"
#import <QuartzCore/QuartzCore.h>
#import "Foundation.h"

@implementation PassWordView
@synthesize delegate          = _delegate;
@synthesize nawPswTextField   = _newPswTextField;
@synthesize pswAgainTextField = _pswAgainTextField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 310, 84)];
        backGroundImageView.image = [UIImage imageNamed:@"text_cell_rim.png"];
        [self addSubview:backGroundImageView];
        [backGroundImageView release];
        
        _newPswTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 16, 300, 30)];
        _newPswTextField.delegate      = self;
        _newPswTextField.textAlignment = NSTextAlignmentLeft;
        _newPswTextField.font          = [UIFont fontWithName:FONTNAME size:14];
        _newPswTextField.placeholder   = @"请输入新密码";
        _newPswTextField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_newPswTextField];
        [_newPswTextField release];
        
        _pswAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 56, 300, 30)];
        _pswAgainTextField.delegate      = self;
        _pswAgainTextField.textAlignment = NSTextAlignmentLeft;
        _pswAgainTextField.font          = [UIFont fontWithName:FONTNAME size:14];
        _pswAgainTextField.placeholder   = @"请再次输入密码";
        _pswAgainTextField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_pswAgainTextField];
        [_pswAgainTextField release];

        UIImage *sendMessageImage=[UIImage imageNamed:@"btn_test.png"];
        UIImage *stetchSendMessageImage=[sendMessageImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
        
        UIButton *ensureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [ensureButton setFrame:CGRectMake(4, 98, 312, 36)];
        [ensureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [ensureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ensureButton setBackgroundImage:stetchSendMessageImage forState:UIControlStateNormal];
        [ensureButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [ensureButton addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ensureButton];
        
        self.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0];
    }
    return self;
}

#pragma mark - Custom event methods

-(void)ensureButtonClick:(id)sender
{
    if ([_newPswTextField.text length] == 0 || [_pswAgainTextField.text length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码不可以为空"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        if ([_newPswTextField.text isEqualToString:_pswAgainTextField.text]) {
            if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(ensureThePassword)]) {
                [_delegate ensureThePassword];
            }
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码输入不一致请检查!"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
}

#pragma mark - Textfield delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
