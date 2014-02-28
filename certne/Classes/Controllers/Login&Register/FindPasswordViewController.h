//
//  FindPasswordViewController.h
//  certne
//
//  Created by apple on 13-12-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "FindPswRequest.h"
#import "NavBarView.h"

@interface FindPasswordViewController : BaseViewController<UITextFieldDelegate,FindPswRequestDelegate,NavBarViewDelegate>
{
    UITextField     *_mobileNumTextField;
    FindPswRequest  *_findPswRequest;
    NavBarView      *_navBarView;
}

@property (retain, nonatomic) UITextField       *mobileNumTextField;

@end
