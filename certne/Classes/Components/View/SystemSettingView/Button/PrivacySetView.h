//
//  PrivacySetView.h
//  certne
//
//  Created by apple on 13-6-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrivacySetViewDelegate;

@interface PrivacySetView : UIView
{
    __unsafe_unretained id<PrivacySetViewDelegate> _delegate;
    BOOL        open;
    UIButton    *_privacySetButton;
}

@property (nonatomic,assign) BOOL                         open;
@property (nonatomic,strong) UIButton                   *privacySetButton;
@property (nonatomic,assign) id<PrivacySetViewDelegate >  delegate;

@end

@protocol PrivacySetViewDelegate <NSObject>

-(void)privacySetButtonClick:(PrivacySetView *)view;

@end
