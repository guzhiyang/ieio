//
//  AuthCodeViewController.m
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AuthCodeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "certneCardAppDelegate.h"
#import "Global.h"
#import "Foundation.h"

@implementation AuthCodeViewController
@synthesize authCodeTextField = _authCodeTextField;
@synthesize code              = _code;
@synthesize mobile            = _mobile;

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
    [_navBarView settitleLabelText:@"注册验证"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, 200, 24)];
    textLabel.text = @"请输入您收到的验证码:";
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.font = [UIFont fontWithName:FONTNAME size:15];
    textLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textLabel];
    [textLabel release];
    
    _authCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 128, 280, 38)];
    _authCodeTextField.textAlignment      = NSTextAlignmentLeft;
    _authCodeTextField.layer.borderWidth  = 1.0;
    _authCodeTextField.layer.borderColor  = UIColorFromFloat(173, 212, 212).CGColor;
    _authCodeTextField.layer.cornerRadius = 4.0;
    _authCodeTextField.font = [UIFont fontWithName:FONTNAME size:14];
    _authCodeTextField.delegate        = self;
    _authCodeTextField.keyboardType    = UIKeyboardTypeNumberPad;
    _authCodeTextField.backgroundColor = [UIColor whiteColor];
    _authCodeTextField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:_authCodeTextField];
    [_authCodeTextField release];
    [_authCodeTextField becomeFirstResponder];//--界面打开直接弹出键盘
    
    UIImage *buttonBgImage = [UIImage imageNamed:@"button_green.png"];
    buttonBgImage=[buttonBgImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    
    _doneButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.frame = CGRectMake(20, 176, 280, 38);
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton setTitle:@"完 成" forState:UIControlStateNormal];
    [_doneButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [_doneButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doneButton];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark- Custom event methods

-(void)done
{
    [_authCodeTextField resignFirstResponder];
    
    NSString *authCode=_authCodeTextField.text;
    
    if (_checkCodeRequest == nil) {
        _checkCodeRequest = [[CheckCodeRequest alloc] init];
        _checkCodeRequest.delegate = self;
    }
    
    [_checkCodeRequest sendCheckCodeRequestWithCode:authCode mobile:self.mobile];
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- CheckCodeRequest delegate methods

-(void)checkCodeRequestDidFinished:(CheckCodeRequest *)checkCodeRequest checkCodeResponse:(CheckCodeResponse *)checkCodeResponse
{
    [Global shareGlobal].session_id=checkCodeResponse.session_id;
    
    if (checkCodeResponse.status==1) {
        [Global shareGlobal].mobile=self.mobile;
        certneCardAppDelegate *appDelegate=(certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadMainView];
    }else if(checkCodeResponse.status==0){
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:checkCodeResponse.msg
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"好的"
                                               otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(void)checkCodeRequestDIDFaild:(CheckCodeRequest *)checkCodeRequest error:(NSError *)error
{
    NSLog(@"checkError=%@",error);
}

#pragma mark- UITextfield delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_authCodeTextField resignFirstResponder];
    return YES;
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    [super dealloc];
}

@end
