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
#import "ImageDownLoader.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,LoginRequestDelegate,UserOnLineRequestDelegate,ImageDownLoaderDelegate>
{
    UITextField         *_userNameTextField;
    UITextField         *_userPasswordTextField;
    UIButton            *_loginButton;
    
    LoginRequest        *_loginRequest;
    SessionIDDatabase   *_sessionDataBase;
    
    UserOnLineRequest   *_userOnLineRequest;
    ImageDownLoader     *_headImageDownLoader;
}

@property (retain, nonatomic) UITextField           *userNameTextField;
@property (retain, nonatomic) UITextField           *userPasswordTextField;
@property (retain, nonatomic) SessionIDDatabase     *sessionDataBase;

-(void)loadingTheMainView:(UIViewController *)viewController textField:(UITextField *)textField;

-(void)sendLoginStatusToService;

@end
