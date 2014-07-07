//
//  RegisterViewController.h
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterRequest.h"
#import "RegisterResponse.h"
#import "NavBarView.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,RegisterRequestDelegate,NavBarViewDelegate>
{
    UITextField         *_inputNumberTextField;
    UITextField         *_inputPasswordTextField;
    UIButton            *_sendRequestButton;
    
    //--倒数秒，多少秒之内不允许再次发送注册请求
    UILabel             *_countDownLabel;
    BOOL                _timerStart;
    
    RegisterRequest     *_registerRequest;
    RegisterResponse    *_registerResponse;
    NavBarView          *_navBarView;
}

@property (strong, nonatomic) UITextField       *inputNumberTextField;
@property (strong, nonatomic) UITextField       *inputPasswordTextField;
@property (strong, nonatomic) RegisterResponse  *registerResponse;
@property (assign, nonatomic) BOOL              timerStart;

-(void)sendRegisterRequestToSever:(id)sender;

-(void)countDown:(NSTimer *)timer;

@end
