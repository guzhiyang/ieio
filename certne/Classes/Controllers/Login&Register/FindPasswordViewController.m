//
//  FindPasswordViewController.m
//  certne
//
//  Created by apple on 13-12-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "Foundation.h"
#import <QuartzCore/QuartzCore.h>
#import "FindPswAuthCodeViewController.h"
#import "Global.h"

@implementation FindPasswordViewController
@synthesize mobileNumTextField = _mobileNumTextField;

#pragma mark - View lifecycle methods

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
    
    _navBarView = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navBarView.delegate = self;
    [_navBarView settitleLabelText:@"找回密码"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, 280, 38)];
    testImageView.image = [UIImage imageNamed:@"findPswMobile.png"];
    testImageView.layer.cornerRadius = 4.0f;
    testImageView.backgroundColor    = [UIColor whiteColor];
    [self.view addSubview:testImageView];
    [testImageView release];
    
    _mobileNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 93, 230, 20)];
    _mobileNumTextField.delegate      = self;
    _mobileNumTextField.placeholder   = @"请输入您的手机号";
    _mobileNumTextField.textAlignment = NSTextAlignmentLeft;
    _mobileNumTextField.keyboardType  = UIKeyboardTypeNumberPad;
    _mobileNumTextField.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:_mobileNumTextField];
    [_mobileNumTextField release];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 132, 280, 32)];
    explainLabel.text = @"为了验证您的身份，我们将会发送短信验证码到您手机上。";
    explainLabel.numberOfLines = 0;
    explainLabel.font = [UIFont fontWithName:FONTNAME size:14];
    explainLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:explainLabel];
    [explainLabel release];
    
    UIImage *getPswImage = [UIImage imageNamed:@"button_green.png"];
    getPswImage = [getPswImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *getPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getPswButton.frame = CGRectMake(20, 184, 280, 38);
    [getPswButton setTitle:@"获取密码" forState:UIControlStateNormal];
    [getPswButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [getPswButton setBackgroundImage:getPswImage forState:UIControlStateNormal];
    [getPswButton addTarget:self action:@selector(getPsw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getPswButton];
        
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark - Custom event methods

-(void)fallback
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(void)getPsw
{
    //--用户输入电话号码自动加86，区分地区；此功能暂时不做
//    NSString *mobielString = [NSString stringWithFormat:@"+86%@",self.mobileNumTextField.text];
    [Global shareGlobal].mobile = self.mobileNumTextField.text;
    
    if (_findPswRequest == nil) {
        _findPswRequest = [[FindPswRequest alloc] init];
        _findPswRequest.delegate = self;
    }
    
    [_findPswRequest sendFindPswRequestWithMobile:[Global shareGlobal].mobile];
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - FindPswRequest delegare methods

-(void)FindPswRequestDidFinished:(FindPswRequest *)findPswRequest findPswResponse:(FindPswResponse *)findPswResponse
{
    if (findPswResponse.status == 1) {
        FindPswAuthCodeViewController *findPswAuthCodeViewController = [[FindPswAuthCodeViewController alloc] init];
        [self.navigationController pushViewController:findPswAuthCodeViewController animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有得到验证码!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"请重试!"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)FindPswRequestDIdFailed:(FindPswRequest *)findPswRequest error:(NSError *)error
{
    NSLog(@"FindPswRequestDIdFailed :%@",error);
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

#pragma mark - Memroy menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
