//
//  certneCardAppDelegate.h
//  certne
//
//  Created by apple on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingViewController.h"
#import "PushMessageDataBase.h"

@interface certneCardAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString        *_session_id;
    NSString        *_deviceToken;
    
    PushMessageDataBase     *_pushMessageDataBase;
}

@property (retain, nonatomic) UIWindow                  *window;
@property (retain, nonatomic) LoadingViewController     *loadingViewController;
@property (retain, nonatomic) UINavigationController    *loginNavigationController;
@property (copy, nonatomic) NSString                    *session_id;
@property (copy, nonatomic) NSString                    *deviceToken;
@property (retain, nonatomic) PushMessageDataBase       *pushMessageDataBase;

-(void)loadingView;
-(void)loadWelcomeView;
-(void)loadLoginView;
-(void)loadRegisterView;
-(void)loadMainView;

@end
