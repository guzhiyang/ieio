//
//  SetNewPswViewController.m
//  certne
//
//  Created by apple on 13-12-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SetNewPswViewController.h"
#import "Foundation.h"
#import "Global.h"
#import "certneCardAppDelegate.h"

@implementation SetNewPswViewController
@synthesize setNewPswTextField = _setNewPswTextField;
@synthesize code               = _code;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _headNavView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 64)];
    _headNavView.delegate = self;
    [self.view addSubview:_headNavView];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, 280, 38)];
    testImageView.image = [UIImage imageNamed:@"newPsw.png"];
    testImageView.layer.cornerRadius = 4.0f;
    testImageView.backgroundColor    = [UIColor whiteColor];
    [self.view addSubview:testImageView];
    
    _setNewPswTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 93, 230, 20)];
    _setNewPswTextField.delegate      = self;
    _setNewPswTextField.placeholder   = @"请输入新的密码";
    _setNewPswTextField.returnKeyType = UIReturnKeyDone;
    _setNewPswTextField.textAlignment = NSTextAlignmentLeft;
    _setNewPswTextField.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:_setNewPswTextField];
    
    UIButton *setNewPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setNewPswButton.frame = CGRectMake(20, 126, 80, 30);
    [setNewPswButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:15]];
    [setNewPswButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [setNewPswButton setTitle:@"设置新密码" forState:UIControlStateNormal];
    [setNewPswButton addTarget:self action:@selector(setNewPsw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setNewPswButton];
    
    UIImage *submitImage = [UIImage imageNamed:@"button_green.png"];
    submitImage = [submitImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 184, 280, 38);
    [submitButton setTitle:@"提交设置" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [submitButton setBackgroundImage:submitImage forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitThePsw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
}

#pragma mark - Custom event methods

-(void)fallback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNewPsw
{
    NSLog(@"设置新密码请求");
}

-(void)submitThePsw
{
    if (_setNewPswRequest == nil) {
        _setNewPswRequest = [[SetNewPswRequest alloc] init];
        _setNewPswRequest.delegate = self;
    }
    
    [_setNewPswRequest sendSetNewPswRequestWithMobile:[Global shareGlobal].mobile code:self.code newPsw:self.setNewPswTextField.text];
}

#pragma mark - HeadNavView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - URLConnetion delegate methods

-(void)SetNewPswRequestDidFinished:(SetNewPswRequest *)setNewPswRequest setNewPswResponse:(SetNewPswResponse *)setNewPswResponse
{
    if (setNewPswResponse.status == 1) {
        [Global shareGlobal].session_id = setNewPswResponse.sessionid;
        
        certneCardAppDelegate *appDelegate = (certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadMainView];
    }else if (setNewPswResponse.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:setNewPswResponse.msg
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)SetNewPswRequestDidFailed:(SetNewPswRequest *)setNewPswRequest error:(NSError *)error
{
    NSLog(@"SetNewPswRequestDidFailed:%@",error);
}

#pragma mark - UITextField delegate methods

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
}

@end
