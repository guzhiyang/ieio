//
//  PrivacySettingView.m
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PrivacySettingView.h"
#import "Foundation.h"

@implementation PrivacySettingView
@synthesize delegate = _delegate;

#pragma mark - View lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *tempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [tempImageView setBackgroundColor:[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0]];
        [self addSubview:tempImageView];
        [tempImageView release];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 150, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:@"信息是否公开"];
        [titleLabel setTextColor:[UIColor darkGrayColor]];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        UISwitch *publicMesSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(200, 10, 60, 30)];
        [publicMesSwitch addTarget:self action:@selector(publicInfo:) forControlEvents:UIControlEventTouchUpInside];
        publicMesSwitch.on=YES;
        [self addSubview:publicMesSwitch];
        [publicMesSwitch release];
        
        UIImageView *tempImageView_2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 51, 320, 50)];
        [tempImageView_2 setBackgroundColor:[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0]];
        [self addSubview:tempImageView_2];
        [tempImageView_2 release];
        
        UILabel *titleLabel_2=[[UILabel alloc]initWithFrame:CGRectMake(10, 66, 150, 20)];
        [titleLabel_2 setBackgroundColor:[UIColor clearColor]];
        [titleLabel_2 setText:@"添加好友验证"];
        [titleLabel_2 setTextColor:[UIColor darkGrayColor]];
        [titleLabel_2 setTextAlignment:NSTextAlignmentRight];
        [titleLabel_2 setFont:[UIFont fontWithName:FONTNAME size:14]];
        [self addSubview:titleLabel_2];
        [titleLabel_2 release];
        
        UISwitch *addFriendSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(200, 61, 80, 30)];
        [addFriendSwitch addTarget:self action:@selector(addFriendVerify:) forControlEvents:UIControlEventTouchUpInside];
        addFriendSwitch.on=YES;
        [self addSubview:addFriendSwitch];
        [addFriendSwitch release];
        
        UIImageView *tempImageView_3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 102, 320, 50)];
        [tempImageView_3 setBackgroundColor:[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0]];
        [self addSubview:tempImageView_3];
        [tempImageView_3 release];
        
        UILabel *titleLabel_3=[[UILabel alloc]initWithFrame:CGRectMake(10, 117, 150, 20)];
        [titleLabel_3 setBackgroundColor:[UIColor clearColor]];
        [titleLabel_3 setText:@"通过手机号搜索到我"];
        [titleLabel_3 setTextColor:[UIColor darkGrayColor]];
        [titleLabel_3 setTextAlignment:NSTextAlignmentRight];
        [titleLabel_3 setFont:[UIFont fontWithName:FONTNAME size:14]];
        [self addSubview:titleLabel_3];
        [titleLabel_3 release];
        
        UISwitch *phoneNumSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(200, 112, 80, 30)];
        [phoneNumSwitch addTarget:self action:@selector(searchMeByMobile:) forControlEvents:UIControlEventTouchUpInside];
        phoneNumSwitch.on=YES;
        [self addSubview:phoneNumSwitch];
        [phoneNumSwitch release];
        
        //        UIImageView *tempImageView_4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 153, 320, 50)];
        //        [tempImageView_4 setBackgroundColor:[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0]];
        //        [self addSubview:tempImageView_4];
        //        [tempImageView_4 release];
        //
        //        UILabel *titleLabel_4=[[UILabel alloc]initWithFrame:CGRectMake(10, 168, 150, 20)];
        //        [titleLabel_4 setBackgroundColor:[UIColor clearColor]];
        //        [titleLabel_4 setText:@"推荐通讯录好友"];
        //        [titleLabel_4 setTextColor:[UIColor darkGrayColor]];
        //        [titleLabel_4 setTextAlignment:NSTextAlignmentRight];
        //        [titleLabel_4 setFont:[UIFont fontWithName:FONTNAME size:14]];
        //        [self addSubview:titleLabel_4];
        //        [titleLabel_4 release];
        //
        //        UISwitch *addressBookSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(200, 163, 80, 30)];
        //        [addressBookSwitch addTarget:self action:@selector(forwardToAddressBook:) forControlEvents:UIControlEventTouchUpInside];
        //        addressBookSwitch.on=YES;
        //        [self addSubview:addressBookSwitch];
        //        [addressBookSwitch release];
        
        UIImage *sendMessageImage=[UIImage imageNamed:@"btn_test.png"];
        UIImage *stetchSendMessageImage=[sendMessageImage stretchableImageWithLeftCapWidth:10 topCapHeight:5];
        
        UIButton *recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        recommendButton.frame = CGRectMake(4, 160, 312, 36);
        [recommendButton setTitle:@"推荐通讯录好友" forState:UIControlStateNormal];
        [recommendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [recommendButton setBackgroundImage:stetchSendMessageImage forState:UIControlStateNormal];
        [recommendButton addTarget:self action:@selector(recommendFriend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:recommendButton];
        
        self.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0];
    }
    return self;
}

#pragma mark - Custom event methods

-(void)publicInfo:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(publicInfo)]) {
        [_delegate publicInfo];
    }
}

-(void)addFriendVerify:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addFriendVerify)]) {
        [_delegate addFriendVerify];
    }
}

-(void)searchMeByMobile:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(searchMeByMobile)]) {
        [_delegate searchMeByMobile];
    }
}

-(void)recommendFriend:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(recommendFriend)]) {
        [_delegate recommendFriend];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
