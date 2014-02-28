//
//  SiderBarDelegate.h
//  certne
//
//  Created by apple on 13-5-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _SideBarShowDirection
{
    SideBarShowDirectionNone = 0,
    SideBarShowDirectionLeft = 1,
//    SideBarShowDirectionRight = 2 //--删除向右移动的方式 需要计算移动距离 让其偏移量不可以为负
}SideBarShowDirection;

@protocol SiderBarDelegate <NSObject>

- (void)leftSideBarSelectWithController:(UIViewController *)controller;
//- (void)rightSideBarSelectWithController:(UIViewController *)controller;//--右边代理
- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction;

@end
