//
//  HeadNavView.h
//  certne
//
//  Created by apple on 13-6-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadNavView : UIView
{
    UIButton *_fallbackButton;
    UILabel *_titleLabel;
}

@property (strong,nonatomic) UIButton *fallbackButton;

@property (strong,nonatomic) UILabel  *titleLabel;

@end
