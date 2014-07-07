//
//  ChangePasswordView.h
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePasswordViewDelegate;

@interface ChangePasswordView : UIView
{
    id<ChangePasswordViewDelegate> _delegate;
    BOOL        open;
    UIButton    *_changePassButton;
}

@property (nonatomic,strong) id<ChangePasswordViewDelegate >  delegate;
@property (nonatomic,assign) BOOL                             open;
@property (nonatomic,strong) UIButton                       *changePassButton;

@end

@protocol ChangePasswordViewDelegate <NSObject>

-(void)ChangePsdButtonClicked:(ChangePasswordView *)view;

@end
