//
//  DetailMessageViewController.h
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUser.h"

@class setMessageViewController;
@class ChatViewController;
@interface DetailMessageViewController : UIViewController
{
    setMessageViewController    *_messageViewController;
    ChatViewController          *_chatViewController;
    UIWebView                   *_phoneCallWebView;
    
    CCUser                      *_user;
}

@property(retain,nonatomic)UIImageView *headImageView;
@property(retain,nonatomic)UIImageView *backgroundView;

@property(retain,nonatomic)UIButton *closeButton;
@property(retain,nonatomic)UIButton *phoneButton;
@property(retain,nonatomic)UIButton *chatButton;
@property(retain,nonatomic)UIButton *testButton;
@property(retain,nonatomic)UIButton *cardButton;
@property(retain,nonatomic)UIButton *websiteButton;

@property(retain,nonatomic)UILabel *nameLabel;
@property(retain,nonatomic)UILabel *positionLabel;
@property(retain,nonatomic)UILabel *companyLabel;

@property(retain,nonatomic)UIImageView *bgImageView;

@property(retain,nonatomic)CCUser       *user;

@property(retain,nonatomic)setMessageViewController *messageViewController;
@property(retain,nonatomic)ChatViewController *chatViewController;

-(void)backToHome:(id)sender;

-(void)phoneCall:(id)sender;
-(void)chat:(id)sender;
-(void)addAttention:(id)sender;
-(void)setMessage:(id)sender;
-(void)openWebsite:(id)sender;

-(void)hiddenTheButton;

-(void)showTheButtonView;

@end
