//
//  RegisterViewController.m
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJson.h"
#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AuthCodeViewController.h"
#import "MultipartForm.h"
#import "certneCardAppDelegate.h"
#import "Foundation.h"

@implementation RegisterViewController
@synthesize inputNumberTextField   = _inputNumberTextField;
@synthesize inputPasswordTextField = _inputPasswordTextField;
@synthesize timerStart             = _timerStart;
@synthesize registerResponse       = _registerResponse;

#pragma mark- View lifestyle methods

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
    [_navBarView settitleLabelText:@"欢迎注册"];
    [self.view addSubview:_navBarView];
    [_navBarView release];
    
    UIImage *buttonBgImage=[UIImage imageNamed:@"button_green.png"];
    buttonBgImage=[buttonBgImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    
    UILabel *tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 74, 280, 50)];
    tipsLabel.font = [UIFont fontWithName:FONTNAME size:14];
    tipsLabel.numberOfLines = 0;
    tipsLabel.text = @"欢迎使用易有，申请之后系统会发送验证码到手机上，填写正确验证码即可注册成为易有用户！感谢您的支持！";
    tipsLabel.textAlignment   = NSTextAlignmentLeft;
    tipsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipsLabel];
    [tipsLabel release];
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 129, 200, 20)];
    textLabel.font            = [UIFont fontWithName:FONTNAME size:15];
    textLabel.text            = @"请输入您的手机号:";
    textLabel.textAlignment   = NSTextAlignmentLeft;
    textLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textLabel];
    [textLabel release];
    
    _inputNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(20, 154, 280, 38)];
    _inputNumberTextField.placeholder       = @"例如:13223232421";
    _inputNumberTextField.textAlignment     = NSTextAlignmentLeft;
    _inputNumberTextField.layer.borderWidth = 1.0;
    _inputNumberTextField.layer.borderColor = [UIColor colorWithRed:173/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f].CGColor;
    _inputNumberTextField.layer.cornerRadius = 4.0;
    _inputNumberTextField.font=[UIFont fontWithName:FONTNAME size:14];
    _inputNumberTextField.delegate=self;
    _inputNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    _inputNumberTextField.backgroundColor=[UIColor whiteColor];
    _inputNumberTextField.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:_inputNumberTextField];
    [_inputNumberTextField release];
    [_inputNumberTextField becomeFirstResponder];//--打开界面直接弹出键盘
    
    UILabel  *psdTextlabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 197, 280, 20)];
    psdTextlabel.text=@"请输入您的密码";
    psdTextlabel.font=[UIFont fontWithName:FONTNAME size:15];
    psdTextlabel.textAlignment=NSTextAlignmentLeft;
    psdTextlabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:psdTextlabel];
    [psdTextlabel release];
    
    _inputPasswordTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 222, 280, 38)];
    _inputPasswordTextField.placeholder=@"您的密码";
    _inputPasswordTextField.font=[UIFont fontWithName:FONTNAME size:14];
    _inputPasswordTextField.textAlignment=NSTextAlignmentLeft;
    _inputPasswordTextField.layer.borderWidth=1.0f;
    _inputPasswordTextField.layer.borderColor=[UIColor colorWithRed:173/255.0f green:212/255.0f blue:212/255.0f alpha:1.0f].CGColor;
    _inputPasswordTextField.layer.cornerRadius=4.0f;
    _inputPasswordTextField.delegate=self;
    _inputPasswordTextField.backgroundColor=[UIColor whiteColor];
    _inputPasswordTextField.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:_inputPasswordTextField];
    [_inputPasswordTextField release];
    
    _sendRequestButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _sendRequestButton.frame=CGRectMake(20, 270, 280, 38);
    [_sendRequestButton setTitle:@"发送申请" forState:UIControlStateNormal];
    [_sendRequestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendRequestButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [_sendRequestButton addTarget:self action:@selector(sendRegisterRequestToSever:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendRequestButton];
    
    _countDownLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 310, 280, 30)];
    _countDownLabel.hidden             = YES;
    _countDownLabel.textAlignment      = NSTextAlignmentCenter;
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.layer.cornerRadius = 4.0f;
    _countDownLabel.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0f];
    [self.view addSubview:_countDownLabel];
    [_countDownLabel release];
    
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f];
}

#pragma mark- Custom event methods

-(void)sendRegisterRequestToSever:(id)sender
{
    if (![self isPhoneNumberRight:_inputNumberTextField.text]) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"请输入手机号"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"好的"
                                               otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        if (_registerRequest==nil) {
            _registerRequest=[[RegisterRequest alloc] init];
            _registerRequest.delegate=self;
        }

        NSString *phoneNum = _inputNumberTextField.text;
        NSString *password = _inputPasswordTextField.text;
        [_registerRequest sendRegiseterMoileNumber:phoneNum password:password];
    }
    [_inputNumberTextField resignFirstResponder];
}

-(void)countDown:(NSTimer *)timer
{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *endTime=[[NSDateComponents alloc] init];//--目标时间
    NSDate *today=[NSDate date];
    NSDate *date=[NSDate dateWithTimeInterval:1 sinceDate:today];//--倒计数5秒
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    NSString *dateString=[dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    static int minute;
    static int second;
    
    if (self.timerStart) {
        minute = [[dateString substringWithRange:NSMakeRange(0, 2)] integerValue];
        second = [[dateString substringWithRange:NSMakeRange(3, 2)] integerValue];//--截取字符串
        self.timerStart = NO;
    }
    
    [endTime setMinute:minute];
    [endTime setSecond:second];
    NSDate *todate=[calendar dateFromComponents:endTime];
    [endTime release];
    
    unsigned int unitFlags=NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *dateCompent=[calendar components:unitFlags fromDate:today toDate:todate options:0];
    NSString *miao=[NSString stringWithFormat:@"%d",[dateCompent second]];
    _countDownLabel.text=miao;
    if ([dateCompent second]==0) {
        _countDownLabel.hidden=YES;
        [timer invalidate];
    }
}

#pragma mark - NavBarView delegate methods

-(void)fallBackButtonClicked
{
    certneCardAppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    [appDelegate loadWelcomeView];
}

#pragma mark- Connetction 代理

-(void)connectionDidFinisnedWithRegister:(RegisterRequest *)registerRequest registerResponse:(RegisterResponse *)registerResponse
{
    self.registerResponse=registerResponse;
    
    if (registerResponse.status==1) {
        //--如果得到验证码，即转向验证码界面
        [self loadAuthCodeViewController];
    }else if (registerResponse.status==2){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"您已注册，请直接登陆!"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"好的"
                                                otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }else{
        _countDownLabel.hidden=NO;
        
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(countDown:)
                                       userInfo:@"user info"
                                        repeats:YES];
        self.timerStart=YES;
    }
}

-(void)connectionDidFailed:(RegisterRequest *)registerRequest error:(NSError *)error
{
}

-(void)loadAuthCodeViewController
{
    AuthCodeViewController *authCodeViewController=[[[AuthCodeViewController alloc]init] autorelease];
    authCodeViewController.code=self.registerResponse.code;
    authCodeViewController.mobile=self.inputNumberTextField.text;
    [self.navigationController pushViewController:authCodeViewController animated:YES];
}

-(BOOL)isPhoneNumberRight:(NSString *)phoneNumber
{
    NSString    *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return      [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark- TextField delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_inputNumberTextField resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- Memory management methods

-(void)viewWillUnload
{
    [super viewWillUnload];
}

-(void)viewDidUnload
{
    self.inputNumberTextField = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [_registerRequest release];
    [super dealloc];
}

@end
