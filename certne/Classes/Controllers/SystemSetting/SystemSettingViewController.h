//
//  SystemSettingViewController.h
//  certne
//
//  Created by apple on 13-5-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "DeviceView.h"
#import "PassWordView.h"
#import "PrivacySetView.h"
#import "ChangePasswordView.h"
#import "SendAdviceView.h"
#import "SetPrivacyRequest.h"
#import "PrivacySettingView.h"
#import "ModifyPasswordRequest.h"
#import "SendSuggestionRequest.h"
#import "certneCardViewController.h"
#import "LoginOutRequest.h"

@interface SystemSettingViewController : BaseViewController<UITextFieldDelegate,PrivacySetViewDelegate,ChangePasswordViewDelegate,SendAdviceViewDelegate,SetPrivacyRequestDelegate,PrivacySettingViewDelegate,ModifyPasswordRequestDelegate,PassWordViewDelegate,SendSuggestionRequestDelegate,DeviceViewDelegate,LoginOutRequestDelegate>
{
    certneCardViewController    *_certneViewController;
    PrivacySettingView          *_privacySettingView;
    PassWordView                *_passWordView;
    DeviceView                  *_deviceView;
    
    PrivacySetView              *_privacySetButtonView;
    ChangePasswordView          *_changePsdButtonView;
    SendAdviceView              *_sendAdviceButtonView;
    
    SetPrivacyRequest           *_setPrivacyRequest;
    ModifyPasswordRequest       *_modifyPasswordRequest;
    SendSuggestionRequest       *_sendSuggestionRequest;
    
    LoginOutRequest             *_loginOutRequest;
}

@property (strong,nonatomic) UIView                   *headNavView;
@property (strong,nonatomic) PrivacySetView           *privacySetButtonView;
@property (strong,nonatomic) ChangePasswordView       *changePsdButtonView;
@property (strong,nonatomic) SendAdviceView           *sendAdviceButtonView;
@property (strong,nonatomic) UIButton                 *settingNavButton_4;
@property (strong,nonatomic) certneCardViewController *certneViewController;
@property (strong,nonatomic) PrivacySettingView       *privacySettingView;
@property (strong,nonatomic) PassWordView             *passWordView;
@property (strong,nonatomic) DeviceView               *deviceView;

-(void)backToRootView:(id)sender;

@end
