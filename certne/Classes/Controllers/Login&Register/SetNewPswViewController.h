//
//  SetNewPswViewController.h
//  certne
//
//  Created by apple on 13-12-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "SetNewPswRequest.h"
#import "NavBarView.h"

@interface SetNewPswViewController : BaseViewController<UITextFieldDelegate,SetNewPswRequestDelegate,NavBarViewDelegate>
{
    UITextField         *_setNewPswTextField;
    SetNewPswRequest    *_setNewPswRequest;
    NSInteger           _code;
    NavBarView          *_headNavView;
}

@property (strong, nonatomic) UITextField       *setNewPswTextField;
@property (assign, nonatomic) NSInteger         code;

@end
