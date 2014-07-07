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
    
    __unsafe_unretained id<PassWordViewDelegate>    _delegate;
}

@property (strong, nonatomic) UITextField   *nawPswTextField;
@property (strong, nonatomic) UITextField   *pswAgainTextField;
@property (assign, nonatomic) id<PassWordViewDelegate>      delegate;

@end

@protocol PassWordViewDelegate <NSObject>

-(void)ensureThePassword;

@end
