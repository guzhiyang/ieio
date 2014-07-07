//
//  SystemSettingViewController.m
//  certne
//
//  Created by apple on 13-5-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "PrivacySetView.h"
#import "ChangePasswordView.h"
#import "SendAdviceView.h"
#import "Global.h"
#import "Foundation.h"
#import "certneCardAppDelegate.h"

@implementation SystemSettingViewController
@synthesize headNavView;
@synthesize privacySetButtonView = _privacySetButtonView;
@synthesize changePsdButtonView  = _changePsdButtonView;
@synthesize sendAdviceButtonView = _sendAdviceButtonView;
@synthesize settingNavButton_4;
@synthesize certneViewController = _certneViewController;
@synthesize privacySettingView   = _privacySettingView;
@synthesize passWordView         = _passWordView;
@synthesize deviceView           = _deviceView;

#pragma mark-View lifeCycle methods

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
    
    [self setPrivacyRequest];
    
    _privacySetButtonView=[[PrivacySetView alloc]initWithFrame:CGRectMake(0, 64, 320, 50)];
    _privacySetButtonView.delegate = self;
    [self.view addSubview:_privacySetButtonView];
    
    _privacySettingView=[[PrivacySettingView alloc]initWithFrame:CGRectMake(0, 115, 320, 204)];
    _privacySettingView.hidden   = YES;
    _privacySettingView.delegate = self;
    [self.view addSubview:_privacySettingView];
    
    _changePsdButtonView=[[ChangePasswordView alloc]initWithFrame:CGRectMake(0, 115, 320, 50)];
    _changePsdButtonView.delegate = self;
    [self.view addSubview:_changePsdButtonView];
    
    _passWordView=[[PassWordView alloc]initWithFrame:CGRectMake(0, 166, 320, 136)];
    _passWordView.hidden   = YES;
    _passWordView.delegate = self;
    [self.view addSubview:_passWordView];
    
    _sendAdviceButtonView=[[SendAdviceView alloc]initWithFrame:CGRectMake(0, 166, 320, 50)];
    _sendAdviceButtonView.delegate = self;
    [self.view addSubview:_sendAdviceButtonView];
    
    _deviceView=[[DeviceView alloc]initWithFrame:CGRectMake(0, 217, 320, 131)];
    _deviceView.hidden   = YES;
    _deviceView.delegate = self;
    [self.view addSubview:_deviceView];
    
    settingNavButton_4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingNavButton_4 setFrame:CGRectMake(0, 217, 320, 50)];
    [settingNavButton_4 setTitle:@"退出登录" forState:UIControlStateNormal];
    [settingNavButton_4.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
    [settingNavButton_4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingNavButton_4 setBackgroundColor:[UIColor colorWithRed:251/255.0f green:251/255.0f blue:251/255.0f alpha:1.0]];
    [settingNavButton_4 addTarget:self action:@selector(backToRootView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingNavButton_4];
    
    self.view.backgroundColor = UIColorFromFloat(240, 240, 240);
}

#pragma mark- Custom Event methods

-(void)backToRootView:(id)sender
{
    if (_loginOutRequest == nil) {
        _loginOutRequest = [[LoginOutRequest alloc] init];
        _loginOutRequest.delegate = self;
    }
    
    [_loginOutRequest sendLoginOutRequestWithSessionID:[Global shareGlobal].session_id];
}

-(void)setPrivacyRequest
{
    if (_setPrivacyRequest == nil) {
        _setPrivacyRequest = [[SetPrivacyRequest alloc] init];
        _setPrivacyRequest.delegate = self;
    }
    
    [_setPrivacyRequest sendSetPrivacyRequestWithMobile:[Global shareGlobal].mobile session_id:[Global shareGlobal].session_id is_sharing_info:1 is_allow_add:1 is_allow_search:1 is_recommend_user:1];
}

#pragma mark - SendLoginOutRequest delegate methods

-(void)loginOutRequestDidFinished:(LoginOutRequest *)loginOutRequest
{
    NSArray *paths             = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile     = [paths objectAtIndex:0];
    NSString *sqlPath          = [documentFile stringByAppendingPathComponent:SESSIONDBNAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileRemove = [fileManager removeItemAtPath:sqlPath error:nil];
    
    if (fileRemove) {
        certneCardAppDelegate *appDelegate = (certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadLoginView];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有删除成功!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)loginOutRequestDidFinished:(LoginOutRequest *)loginOutRequest error:(NSError *)error
{
    NSLog(@"退出登录失败:%@",error);
}

#pragma mark - PswView delegate methods

-(void)ensureThePassword
{
    if (_modifyPasswordRequest == nil) {
        _modifyPasswordRequest = [[ModifyPasswordRequest alloc] init];
        _modifyPasswordRequest.delegate = self;
    }
    
    [_modifyPasswordRequest sendModifyPasswordRequestWithSessionid:[Global shareGlobal].session_id newPassword:self.passWordView.nawPswTextField.text];
}

#pragma mark - DeviceView delegate methods

-(void)sendSuggestionMessage
{
    if (_sendSuggestionRequest == nil) {
        _sendSuggestionRequest = [[SendSuggestionRequest alloc] init];
        _sendSuggestionRequest.delegate = self;
    }
    
    [_sendSuggestionRequest sendSuggestionRequestWithMobile:[Global shareGlobal].mobile sessionid:[Global shareGlobal].session_id suggestion:self.deviceView.deviceTextView.text];
}

#pragma mark- SetPrivacyRequest delegate methods

-(void)SetPrivacyRequestDidFinished:(SetPrivacyRequest *)setPrivacyRequest systemSet:(SystemSet *)systemSet
{
}

-(void)SetPrivacyRequestDidFailed:(SetPrivacyRequest *)setPrivacyRequest error:(NSError *)error
{
    NSLog(@"系统设置出错");
}

#pragma mark - ModifyPasswordRequest delegate methods

-(void)modifyPasswordRequestDidFinished:(ModifyPasswordRequest *)modifyPasswordResquest statusResponse:(StatusResponse *)statusResponse
{
    if (statusResponse.status == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改成功"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改失败"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)modifyPasswordRequestDidFailed:(ModifyPasswordRequest *)modifyPasswordResquest error:(NSError *)error
{
    NSLog(@"modifyPasswordRequestDidFailed:%@",error);
}

#pragma mark - SendSuggestionRequest delegate methods

-(void)sendSuggestionRequestDidFinished:(SendSuggestionRequest *)sendSuggestionRequest statusResponse:(StatusResponse *)statusResponse
{
    if (statusResponse.status == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"我们用十分努力换您十分满意!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else if (statusResponse.status == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"发送失败，请检查网络!"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)sendSuggestionRequestDidFailed:(SendSuggestionRequest *)sendSuggestionRequest error:(NSError *)error
{
}

#pragma mark- ButtonView delegate methods

-(void)privacySetButtonClick:(PrivacySetView *)view
{
    _privacySetButtonView.open=!_privacySetButtonView.open;
    if (_privacySetButtonView.open == YES) {
        _changePsdButtonView.open  = NO;
        _sendAdviceButtonView.open = NO;
        _privacySettingView.hidden = NO;
        _passWordView.hidden       = YES;
        _deviceView.hidden         = YES;
        _changePsdButtonView.frame  = CGRectMake(0, 319, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 370, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 421, 320, 50);
    }
    else{
        _privacySettingView.hidden=YES;
        _changePsdButtonView.frame  = CGRectMake(0, 115, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 166, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 217, 320, 50);
    }
}

-(void)ChangePsdButtonClicked:(ChangePasswordView *)view
{
    _changePsdButtonView.open=!_changePsdButtonView.open;
    if (_changePsdButtonView.open==YES) {
        _privacySetButtonView.open = NO;
        _sendAdviceButtonView.open = NO;
        _privacySettingView.hidden = YES;
        _passWordView.hidden       = NO;
        _deviceView.hidden         = YES;
        _changePsdButtonView.frame  = CGRectMake(0, 115, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 305, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 354, 320, 50);
    }
    else{
        _passWordView.hidden=YES;
        _changePsdButtonView.frame  = CGRectMake(0, 115, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 166, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 217, 320, 50);
    }
}

-(void)sendAdviceButtonClicked:(SendAdviceView *)view
{
    _sendAdviceButtonView.open =! _sendAdviceButtonView.open;
    if (_sendAdviceButtonView.open==YES) {
        _changePsdButtonView.open  = NO;
        _privacySetButtonView.open = NO;
        _privacySettingView.hidden = YES;
        _passWordView.hidden       = YES;
        _deviceView.hidden         = NO;
        _changePsdButtonView.frame  = CGRectMake(0, 115, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 166, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 349, 320, 50);
    }
    else{
        _deviceView.hidden = YES;
        _changePsdButtonView.frame  = CGRectMake(0, 115, 320, 50);
        _sendAdviceButtonView.frame = CGRectMake(0, 166, 320, 50);
        settingNavButton_4.frame    = CGRectMake(0, 217, 320, 50);
    }
}

#pragma mark- textField delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Privacy Setting delegate methods

-(void)publicInfo
{
    //--公开信息
}

-(void)addFriendVerify
{
    //--添加好友验证
}

-(void)searchMeByMobile
{
    //--通过手机查询好友
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
}

@end
