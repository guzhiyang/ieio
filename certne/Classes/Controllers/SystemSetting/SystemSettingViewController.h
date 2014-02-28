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
#import "NavBarView.h"
#import "LoginOutRequest.h"

@interface SystemSettingViewController : BaseViewController<UITextFieldDelegate,PrivacySetViewDelegate,ChangePasswordViewDelegate,SendAdviceViewDelegate,SetPrivacyRequestDelegate,PrivacySettingViewDelegate,ModifyPasswordRequestDelegate,PassWordViewDelegate,SendSuggestionRequestDelegate,DeviceViewDelegate,NavBarViewDelegate,LoginOutRequestDelegate>
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
    NavBarView                  *_navBarView;
    
    LoginOutRequest             *_loginOutRequest;
}

@property (retain,nonatomic) UIView                   *headNavView;
@property (retain,nonatomic) PrivacySetView           *privacySetButtonView;
@property (retain,nonatomic) ChangePasswordView       *changePsdButtonView;
@property (retain,nonatomic) SendAdviceView           *sendAdviceButtonView;
@property (retain,nonatomic) UIButton                 *settingNavButton_4;
@property (retain,nonatomic) certneCardViewController *certneViewController;
@property (retain,nonatomic) PrivacySettingView       *privacySettingView;
@property (retain,nonatomic) PassWordView             *passWordView;
@property (retain,nonatomic) DeviceView               *deviceView;

-(void)backToRootView:(id)sender;

@end
