//
//  LoginViewController.h
//  certne
//
//  Created by apple on 13-8-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginRequest.h"
#import "SessionIDDatabase.h"
#import "UserOnLineRequest.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,LoginRequestDelegate,UserOnLineRequestDelegate>
{
    UITextField         *_userNameTextField;
    UITextField         *_userPasswordTextField;
    UIButton            *_loginButton;
    
    LoginRequest        *_loginRequest;
    SessionIDDatabase   *_sessionDataBase;
    
    UserOnLineRequest   *_userOnLineRequest;
}

@property (strong, nonatomic) UITextField           *userNameTextField;
@property (strong, nonatomic) UITextField           *userPasswordTextField;
@property (strong, nonatomic) SessionIDDatabase     *sessionDataBase;

-(void)loadingTheMainView:(UIViewController *)viewController textField:(UITextField *)textField;

-(void)sendLoginStatusToService;

@end
