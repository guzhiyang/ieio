//
//  LoginViewController.m
//  certne
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SideBarViewController.h"
#import "certneCardAppDelegate.h"
#import "FindPasswordViewController.h"
#import "Foundation.h"
#import "Global.h"
#import "UserDefault.h"
#import "TKAlertCenter.h"
#import "TKLoadingView.h"

@interface LoginViewController ()

@property (strong, nonatomic) TKLoadingView *loadingView;

@end

@implementation LoginViewController

@synthesize userNameTextField     = _userNameTextField;
@synthesize userPasswordTextField = _userPasswordTextField;
@synthesize sessionDataBase       = _sessionDataBase;
@synthesize loadingView;

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
        
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    UILabel *welcomeLoginLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 280, 40)];
    welcomeLoginLabel.text = @"欢迎登录";
    welcomeLoginLabel.font = [UIFont fontWithName:FONTNAME size:30];
    welcomeLoginLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLoginLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:welcomeLoginLabel];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 198, 280, 24)];
    tipLabel.font     = [UIFont fontWithName:FONTNAME size:16];
    tipLabel.text     = @"易友助您踏上成功商途！";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.backgroundColor = [UIColor whiteColor];
    backgroundImage.layer.cornerRadius = 3.0;
    backgroundImage.layer.borderWidth  = 1.0f;
    backgroundImage.layer.borderColor = [UIColor colorWithRed:65/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f].CGColor;
    backgroundImage.frame = CGRectMake(20, 308, 280, 38);
    [self.view addSubview:backgroundImage];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 317, 270, 20)];
    _userNameTextField.delegate = self;
    _userNameTextField.font = [UIFont fontWithName:FONTNAME size:15];
    _userNameTextField.textAlignment   = NSTextAlignmentLeft;
    _userNameTextField.placeholder     = @"输入您的手机号";
    _userNameTextField.backgroundColor = [UIColor clearColor];
    _userNameTextField.returnKeyType   = UIReturnKeyDone;
    _userNameTextField.keyboardType    = UIKeyboardTypeNumberPad;
    [self.view addSubview:_userNameTextField];
    
    UIImageView *nextBackgroundImage = [[UIImageView alloc]init];
    nextBackgroundImage.backgroundColor = [UIColor whiteColor];
    nextBackgroundImage.layer.cornerRadius = 3.0;
    nextBackgroundImage.layer.borderColor = [UIColor colorWithRed:65/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f].CGColor;
    nextBackgroundImage.layer.borderWidth = 1.0f;
    nextBackgroundImage.frame = CGRectMake(20, 353, 280, 38);
    [self.view addSubview:nextBackgroundImage];
    
    _userPasswordTextField=[[UITextField alloc] initWithFrame:CGRectMake(25, 362, 270, 20)];
    _userPasswordTextField.delegate      = self;
    _userPasswordTextField.returnKeyType = UIReturnKeyDone;
    _userPasswordTextField.font = [UIFont fontWithName:FONTNAME size:15];
    _userPasswordTextField.textAlignment   = NSTextAlignmentLeft;
    _userPasswordTextField.placeholder     = @"输入密码";
    _userPasswordTextField.secureTextEntry = YES;
    _userPasswordTextField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_userPasswordTextField];
    
    UIImage *buttonImage=[UIImage imageNamed:@"button_green.png"];
    buttonImage=[buttonImage stretchableImageWithLeftCapWidth:10 topCapHeight:6];
    _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame=CGRectMake(19, 398, 282, 40);
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loadingTheMainView:textField:) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
    [self.view addSubview:_loginButton];
    
    UIButton *findPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    findPsw.frame = CGRectMake(220, 440, 80, 36);
    [findPsw setTitle:@"忘记密码" forState:UIControlStateNormal];
    [findPsw setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [findPsw.titleLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
    [findPsw addTarget:self action:@selector(findPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPsw];
    
    self.view.backgroundColor = UIColorFromFloat(245.0,245.0,240.0);
}

#pragma mark- Custom event methods

-(void)sendLoginStatusToService
{
    //--纪录活跃用户
}

-(void)findPassword
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    FindPasswordViewController *findPasswordViewController = [[FindPasswordViewController alloc] init];
    [self.navigationController pushViewController:findPasswordViewController animated:NO];
}

-(void)loadingTheMainView:(UIViewController *)viewController textField:(UITextField *)textField
{
    if ([_userNameTextField.text length] == 0 && [_userPasswordTextField.text length] == 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入手机号和密码!"];
    }else if ([_userNameTextField.text length] == 0 && [_userPasswordTextField.text length] != 0) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入手机号"];
        [_userNameTextField becomeFirstResponder];
    }else if([_userNameTextField.text length] != 0 && [_userPasswordTextField.text length] == 0){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入密码"];
        [_userPasswordTextField becomeFirstResponder];
    }else{
        
        [[LoginRequest shareRequest] sendLoginRequestWithUseMobile:self.userNameTextField.text
                                                          password:self.userPasswordTextField.text];
        [LoginRequest shareRequest].delegate = self;
    }
}

#pragma mark-LoginRequestDelegate methods

-(void)loginRequestStart:(LoginRequest *)request
{
    loadingView = [[TKLoadingView alloc] initWithTitle:@"Loading..."];
}

-(void)loginRequestFinished:(LoginRequest *)request loginUserInfo:(LoginUserInfo *)loginUserInfo
{
    NSLog(@"登录用户的信息:%@",loginUserInfo);
    
    [Global shareGlobal].currentUser = loginUserInfo.currentUser;
    
    //--创建数据库，将获得的数据加入数据文件
    _sessionDataBase = [[SessionIDDatabase alloc] init];
    [_sessionDataBase createSessionIDDataTable];
    SessionID *sessionID = [[SessionID alloc] init];
    sessionID.uid        = loginUserInfo.currentUser.uid;
    sessionID.mobile     = loginUserInfo.currentUser.mobile;
    sessionID.sessionID  = loginUserInfo.session_id;
    sessionID.name       = loginUserInfo.currentUser.name;
    sessionID.company    = loginUserInfo.currentUser.company;
    sessionID.avatar     = loginUserInfo.currentUser.avatar;
    sessionID.department = loginUserInfo.currentUser.department;
    sessionID.position   = loginUserInfo.currentUser.position;
    sessionID.industry   = loginUserInfo.currentUser.industry;
    sessionID.qq         = loginUserInfo.currentUser.qq;
    sessionID.website    = loginUserInfo.currentUser.website;
    sessionID.email      = loginUserInfo.currentUser.email;
    sessionID.address    = loginUserInfo.currentUser.address;
    sessionID.tel        = loginUserInfo.currentUser.tel;
    sessionID.fax        = loginUserInfo.currentUser.fax;
    sessionID.zipcode    = loginUserInfo.currentUser.zipcode;
    
    [_sessionDataBase addSessionID:sessionID];
    
    certneCardAppDelegate *appDelegate = (certneCardAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.session_id = loginUserInfo.session_id;//--将链接字符串赋值给全局变量
    
    if (loginUserInfo.status == 1) {
        
        [UserDefault createUserDefault].uid        = loginUserInfo.currentUser.uid;
        [UserDefault createUserDefault].mobile     = loginUserInfo.currentUser.mobile;
        [UserDefault createUserDefault].sessionID  = loginUserInfo.session_id;
        [UserDefault createUserDefault].name       = loginUserInfo.currentUser.name;
        [UserDefault createUserDefault].company    = loginUserInfo.currentUser.company;
        [UserDefault createUserDefault].avatar     = loginUserInfo.currentUser.avatar?loginUserInfo.currentUser.avatar:TESTUSERAVATAR;
        [UserDefault createUserDefault].department = loginUserInfo.currentUser.department;
        [UserDefault createUserDefault].position   = loginUserInfo.currentUser.position;
        [UserDefault createUserDefault].industry   = loginUserInfo.currentUser.industry;
        [UserDefault createUserDefault].qq         = loginUserInfo.currentUser.qq;
        [UserDefault createUserDefault].website    = loginUserInfo.currentUser.website;
        [UserDefault createUserDefault].email      = loginUserInfo.currentUser.email;
        [UserDefault createUserDefault].address    = loginUserInfo.currentUser.address;
        [UserDefault createUserDefault].tel        = loginUserInfo.currentUser.tel;
        [UserDefault createUserDefault].fax        = loginUserInfo.currentUser.fax;
        [UserDefault createUserDefault].zipCode    = loginUserInfo.currentUser.zipcode;
        [UserDefault createUserDefault].password   = _userPasswordTextField.text;
        [[UserDefault createUserDefault] saveUserDefault];

        if (_userOnLineRequest == nil) {
            _userOnLineRequest = [[UserOnLineRequest alloc] init];
            _userOnLineRequest.delegate = self;
        }
        
        [_userOnLineRequest sendUserOnLineRequestWithSessionID:loginUserInfo.session_id longitude:[Global shareGlobal].longitude latitude:[Global shareGlobal].latitude deviceToken:[Global shareGlobal].deviceToken];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [appDelegate loadMainView];
    }else if (loginUserInfo.status == 0){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"您的密码或者帐号不正确!"];
    }else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请检查您的网络链接!"];
    }
}

-(void)loginRequestFailed:(LoginRequest *)request error:(NSError *)error
{
    NSLog(@"loginRequest Error= %@",error);
}

#pragma mark- TextField delegate methods

-(void)textfieldAnimate:(UITextField *)textField up:(BOOL)up
{
    const int movementDistance   = kUIsIphone5?92:180;
    const float movementDuration = 0.2f;
    int movement = (up?-movementDistance:movementDistance);
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self textfieldAnimate:textField up:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textfieldAnimate:textField up:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UserOnLineRequest delegate methods

-(void)userOnLineRequestDidFinished:(UserOnLineRequest *)userOnLineRequest response:(StatusResponse *)response
{
    NSLog(@"用户在线状态设置信息:%i",response.status);
}

-(void)userOnLineRequestDidFailed:(UserOnLineRequest *)userOnLineRequest error:(NSError *)error
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请检查您的网络设置!"];
}

//#pragma mark - HeadImageDownLoader delegate methods
//
//-(void)downLoadFinish:(ImageDownLoader *)downLoader
//{
//}
//
//-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
//{
//    UIImage *headImage = [UIImage imageWithData:downLoader.receivedData];
//    [Global shareGlobal].headImageData = downLoader.receivedData;
//    
//    NSArray *imageURLArray = [[Global shareGlobal].currentUser.avatar componentsSeparatedByString:@"/"];
//    NSString *imageName = [imageURLArray lastObject];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentFile = [paths objectAtIndex:0];
//    NSString *imageFile    = [documentFile stringByAppendingPathComponent:imageName];
//    NSData *imageData      = UIImagePNGRepresentation(headImage);
//    [imageData writeToFile:imageFile atomically:YES];
//}
//
//-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
//{
//    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名片背景下载失败!"];
//}
//
#pragma mark - Memory management

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
    _userNameTextField     = nil;
    _userPasswordTextField = nil;
}

@end
