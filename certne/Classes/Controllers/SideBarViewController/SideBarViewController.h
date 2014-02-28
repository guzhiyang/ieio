//
//  SideBarViewController.h
//  certne
//
//  Created by apple on 13-5-21.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SideBarViewController : BaseViewController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    BOOL  _sideBarShowing;
}

@property (assign, nonatomic) BOOL   sideBarShowing;
@property (retain, nonatomic) IBOutlet UIView  *contentView;
@property (retain, nonatomic) IBOutlet UIView  *navBackView;

+(id)share;

@end
