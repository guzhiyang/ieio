//
//  FindPswAuthCodeViewController.h
//  certne
//
//  Created by apple on 13-12-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NewPswCheckRequest.h"
#import "FindPswRequest.h"
#import "NavBarView.h"

@interface FindPswAuthCodeViewController : BaseViewController<UITextFieldDelegate,NewPswCheckRequestDelegate,NavBarViewDelegate,FindPswRequestDelegate>
{
    UITextField         *_authCodeTextField;
    
    NewPswCheckRequest  *_newPswCheckRequest;
    NavBarView          *_navBarView;
    FindPswRequest      *_findPswRequest;
}

@property (strong, nonatomic) UITextField       *authCodeTextField;

@end
