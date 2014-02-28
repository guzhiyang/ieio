//
//  PrivacySettingView.h
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrivacySettingViewDelegate;

@interface PrivacySettingView : UIView
{
    id<PrivacySettingViewDelegate>  _delegate;
}

@property (assign, nonatomic) id<PrivacySettingViewDelegate>    delegate;

@end

@protocol PrivacySettingViewDelegate <NSObject>

-(void)publicInfo;
-(void)addFriendVerify;
-(void)searchMeByMobile;

@end
