//
//  AuthCodeViewController.h
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "CheckCodeRequest.h"
#import "NavBarView.h"

@interface AuthCodeViewController : BaseViewController<UITextFieldDelegate,CheckCodeRequestDelegate,NavBarViewDelegate>
{
    UIButton        *_backButton;
    UIButton        *_doneButton;
    
    UITextField     *_authCodeTextField;
    NSInteger       _code;
    NSString        *_mobile;
    
    CheckCodeRequest    *_checkCodeRequest;
    NavBarView          *_navBarView;
}

@property (strong, nonatomic) UITextField       *authCodeTextField;
@property (assign, nonatomic) NSInteger         code;
@property (copy, nonatomic) NSString            *mobile;

@end
