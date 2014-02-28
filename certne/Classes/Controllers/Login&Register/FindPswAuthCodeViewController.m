//
//  FindPswAuthCodeViewController.m
//  certne
//
//  Created by apple on 13-12-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FindPswAuthCodeViewController.h"
#import "Foundation.h"
#import "SetNewPswViewController.h"
#import "Global.h"

@implementation FindPswAuthCodeViewController
@synthesize authCodeTextField = _authCodeTextField;

#pragma mark - View lifeCycle methods

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
    [_navBarView settitleLabelText:@"找回验证"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIImageView *testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, 280, 38)];
    testImageView.image = [UIImage imageNamed:@"pswCode.png"];
    testImageView.layer.cornerRadius = 4.0f;
    testImageView.backgroundColor    = [UIColor whiteColor];
    [self.view addSubview:testImageView];
    [testImageView release];
    
    _authCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 93, 230, 20)];
    _authCodeTextField.delegate      = self;
    _authCodeTextField.placeholder   = @"请输入验证码";
    _authCodeTextField.textAlignment = NSTextAlignmentLeft;
    _authCodeTextField.keyboardType  = UIKeyboardTypeNumberPad;
    _authCodeTextField.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:_authCodeTextField];
    [_authCodeTextField release];
    
    UIButton *getAuthCodeAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getAuthCodeAgainButton.frame = CGRectMake(20, 126, 80, 30);
    [getAuthCodeAgainButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:15]];
    [getAuthCodeAgainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getAuthCodeAgainButton setTitle:@"重发验证码" forState:UIControlStateNormal];
    [getAuthCodeAgainButton addTarget:self action:@selector(getAuthCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getAuthCodeAgainButton];
    
    UIImage *submitImage = [UIImage imageNamed:@"button_green.png"];
    submitImage = [submitImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 184, 280, 38);
    [submitButton setTitle:@"提交验证" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [submitButton setBackgroundImage:submitImage forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitTheCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
}

#pragma mark - Custom event methods

-(void)submitTheCode
{
    if (_newPswCheckRequest == nil) {
        _newPswCheckRequest = [[NewPswCheckRequest alloc] init];
        _newPswCheckRequest.delegate = self;
    }
    
    [_newPswCheckRequest sendNewPswCheckRequestWith:[Global shareGlobal].mobile code:[self.authCodeTextField.text integerValue]];
}

-(void)getAuthCode
{
    NSLog(@"重新请求");
}

#pragma mark - navBarView delegate methods

-(void)fallBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - URLConnection delegate methods

-(void)newPswCheckRequestDidFinished:(NewPswCheckRequest *)newPswCheckRequest sayHelloResponse:(StatusResponse *)sayHelloResponse
{
    if (sayHelloResponse.status == 1) {
        SetNewPswViewController *setNewPswViewController = [[SetNewPswViewController alloc] init];
        setNewPswViewController.code = [self.authCodeTextField.text integerValue];
        [self.navigationController pushViewController:setNewPswViewController animated:YES];
    }else if (sayHelloResponse.status == 0){
        NSLog(@"验证失败!");
    }
}

-(void)newPswCheckRequestDidFialed:(NewPswCheckRequest *)newPswCheckRequest error:(NSError *)error
{
    NSLog(@"error = %@",error);
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
    [super dealloc];
}

@end
