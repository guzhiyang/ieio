//
//  PassWordView.h
//  certne
//
//  Created by apple on 13-5-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassWordViewDelegate;

@interface PassWordView : UIView<UITextFieldDelegate>
{
    UITextField         *_newPswTextField;
    UITextField         *_pswAgainTextField;
    
    id<PassWordViewDelegate>    _delegate;
}

@property (retain, nonatomic) UITextField   *nawPswTextField;
@property (retain, nonatomic) UITextField   *pswAgainTextField;
@property (assign, nonatomic) id<PassWordViewDelegate>      delegate;

@end

@protocol PassWordViewDelegate <NSObject>

-(void)ensureThePassword;

@end
