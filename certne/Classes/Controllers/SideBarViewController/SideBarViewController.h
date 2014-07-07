//
//  SideBarViewController.h
//  certne
//
//  Created by apple on 13-5-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SideBarViewController : UIViewController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _sideBarShowing;
}

@property (assign, nonatomic) BOOL   sideBarShowing;
@property (strong, nonatomic) IBOutlet UIView  *contentView;
@property (strong, nonatomic) IBOutlet UIView  *navBackView;

+(id)share;

@end
