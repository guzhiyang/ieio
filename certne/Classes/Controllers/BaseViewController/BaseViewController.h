//
//  BaseViewController.h
//  certne
//
//  Created by apple on 13-8-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBarView.h"
#import "Global.h"
#import "Foundation.h"

@interface BaseViewController : UIViewController<NavBarViewDelegate>

@property (strong, nonatomic) NSString *navViewTitle;

@property (strong, nonatomic) NavBarView    *navBarView;

@property (assign, nonatomic) BOOL      isSideBarNavVC;

@end
