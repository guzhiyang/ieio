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

@implementation LoginViewController

@synthesize userNameTextField     = _userNameTextField;
@synthesize userPasswordTextField = _userPasswordTextField;
@synthesize sessionDataBase       = _sessionDataBase;

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
    [welcomeLoginLabel release];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 198, 280, 24)];
    tipLabel.font     = [UIFont fontWithName:FONTNAME size:16];
    tipLabel.text     = @"易友助您踏上成功商途！";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    [tipLabel release];
    
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.backgroundColor = [UIColor whiteColor];
    backgroundImage.layer.cornerRadius = 3.0;
    backgroundImage.layer.borderWidth  = 1.0f;
    backgroundImage.layer.borderColor = [UIColor colorWithRed:65/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f].CGColor;
    backgroundImage.frame = CGRectMake(20, 308, 280, 38);
    [self.view addSubview:backgroundImage];
    [backgroundImage release];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 317, 270, 20)];
    _userNameTextField.delegate = self;
    _userNameTextField.font = [UIFont fontWithName:FONTNAME size:15];
    _userNameTextField.textAlignment   = NSTextAlignmentLeft;
    _userNameTextField.placeholder     = @"输入您的手机号";
    _userNameTextField.backgroundColor = [UIColor clearColor];
    _userNameTextField.returnKeyType   = UIReturnKeyDone;
    _userNameTextField.keyboardType    = UIKeyboardTypeNumberPad;
    [self.view addSubview:_userNameTextField];
    [_userNameTextField release];
    
    UIImageView *nextBackgroundImage = [[UIImageView alloc]init];
    nextBackgroundImage.backgroundColor = [UIColor whiteColor];
    nextBackgroundImage.layer.cornerRadius = 3.0;
    nextBackgroundImage.layer.borderColor = [UIColor colorWithRed:65/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f].CGColor;
    nextBackgroundImage.layer.borderWidth = 1.0f;
    nextBackgroundImage.frame = CGRectMake(20, 353, 280, 38);
    [self.view addSubview:nextBackgroundImage];
    [nextBackgroundImage release];
    
    _userPasswordTextField=[[UITextField alloc] initWithFrame:CGRectMake(25, 362, 270, 20)];
    _userPasswordTextField.delegate      = self;
    _userPasswordTextField.returnKeyType = UIReturnKeyDone;
    _userPasswordTextField.font = [UIFont fontWithName:FONTNAME size:15];
    _userPasswordTextField.textAlignment   = NSTextAlignmentLeft;
    _userPasswordTextField.placeholder     = @"输入密码";
    _userPasswordTextField.secureTextEntry = YES;
    _userPasswordTextField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_userPasswordTextField];
    [_userPasswordTextField release];
    
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
        UIAlertView *allAlertView=[[UIAlertView alloc]initWithTitle:@"请输入用户名和密码"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"好的", nil];
        [allAlertView show];
        [allAlertView release];
    }else if ([_userNameTextField.text length] == 0 && [_userPasswordTextField.text length] != 0) {
        UIAlertView *nameAlertView = [[UIAlertView alloc]initWithTitle:@"请输入用户名"
                                                               message:nil
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"好的", nil];
        [nameAlertView show];
        [nameAlertView release];
    }else if([_userNameTextField.text length] != 0 && [_userPasswordTextField.text length] == 0){
        UIAlertView *pswAlertView = [[UIAlertView alloc]initWithTitle:@"请输入密码"
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"好的", nil];
        [pswAlertView show];
        [pswAlertView release];
    }else{
        if (_loginRequest == nil) {
            _loginRequest = [[LoginRequest alloc] init];
            _loginRequest.delegate=self;
        }
        
        [_loginRequest sendLoginRequestWithUseMobile:self.userNameTextField.text
                                            password:self.userPasswordTextField.text];
    }
}

#pragma mark-LoginRequestDelegate methods

-(void)loginRequestFinished:(LoginRequest *)request loginUserInfo:(LoginUserInfo *)loginUserInfo
{
    [Global shareGlobal].session_id  = loginUserInfo.session_id;
    [Global shareGlobal].mobile      = loginUserInfo.currentUser.mobile;
    [Global shareGlobal].currentUser = loginUserInfo.currentUser;
    
    //--创建数据库，将获得的数据加入数据文件
    _sessionDataBase = [[[SessionIDDatabase alloc] init] autorelease];
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
        if (_userOnLineRequest == nil) {
            _userOnLineRequest = [[UserOnLineRequest alloc] init];
            _userOnLineRequest.delegate = self;
        }
        
        [_userOnLineRequest sendUserOnLineRequestWithSessionID:[Global shareGlobal].session_id longitude:[Global shareGlobal].longitude latitude:[Global shareGlobal].latitude deviceToken:[Global shareGlobal].deviceToken];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        if ([[Global shareGlobal].currentUser.avatar length] > 5) {
            _headImageDownLoader = [[ImageDownLoader alloc] initWithURLString:[Global shareGlobal].currentUser.avatar delegate:self];
        }
        
        if ([[Global shareGlobal].currentUser.avatar length] > 5) {
            NSArray *headImageArray = [[Global shareGlobal].currentUser.avatar componentsSeparatedByString:@"/"];
            NSString *headImageKey = [headImageArray lastObject];
            [Global shareGlobal].headImageKey = headImageKey;
        }
        [appDelegate loadMainView];
    }else if (loginUserInfo.status == 0){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"密码或者帐号不正确！"
                                                          message:@"请检查您的帐号或密码！"
                                                         delegate:self
                                                cancelButtonTitle:@"好的"
                                                otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"请检查您的网络链接！"
                                                          message:@"网络链接已断开"
                                                         delegate:self
                                                cancelButtonTitle:@"好的"
                                                otherButtonTitles:nil];
        [alertView show];
        [alertView release];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - HeadImageDownLoader delegate methods

-(void)downLoadFinish:(ImageDownLoader *)downLoader
{
}

-(void)downLoaderReceivedData:(ImageDownLoader *)downLoader
{
    UIImage *headImage = [UIImage imageWithData:downLoader.receivedData];
    [Global shareGlobal].headImageData = downLoader.receivedData;
    
    NSArray *imageURLArray = [[Global shareGlobal].currentUser.avatar componentsSeparatedByString:@"/"];
    NSString *imageName = [imageURLArray lastObject];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFile = [paths objectAtIndex:0];
    NSString *imageFile    = [documentFile stringByAppendingPathComponent:imageName];
    NSData *imageData      = UIImagePNGRepresentation(headImage);
    [imageData writeToFile:imageFile atomically:YES];
}

-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求发送失败!"
                                                        message:@"请检查网络设置"
                                                       delegate:self
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

#pragma mark - Memory management

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_loginRequest release];
    _userNameTextField     = nil;
    _userPasswordTextField = nil;
    [super dealloc];
}

@end
