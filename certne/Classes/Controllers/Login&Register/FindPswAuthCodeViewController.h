//
//  FindPswAuthCodeViewController.h
//  certne
//
//  Created by apple on 13-12-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NewPswCheckRequest.h"
#import "NavBarView.h"

@interface FindPswAuthCodeViewController : BaseViewController<UITextFieldDelegate,NewPswCheckRequestDelegate,NavBarViewDelegate>
{
    UITextField         *_authCodeTextField;
    
    NewPswCheckRequest  *_newPswCheckRequest;
    NavBarView          *_navBarView;
}

@property (retain, nonatomic) UITextField       *authCodeTextField;

@end
