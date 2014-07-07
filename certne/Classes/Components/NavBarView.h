//
//  NavBarView.h
//  certne
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavBarViewDelegate;

@interface NavBarView : UIView
{
    UILabel     *_titleLabel;
    UIButton    *_fallBackButton;
    
    __unsafe_unretained id<NavBarViewDelegate>      _delegate;
}

@property (strong, nonatomic) UILabel       *titleLabel;
@property (strong, nonatomic) UIButton      *fallBackButton;
@property (assign, nonatomic) id<NavBarViewDelegate>    delegate;

-(void)fallBack;

-(void)settitleLabelText:(NSString *)title;

@end

@protocol NavBarViewDelegate <NSObject>

-(void)fallBackButtonClicked;

@end
