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
}SideBarShowDirection;

@protocol SiderBarDelegate <NSObject>

- (void)leftSideBarSelectWithController:(UIViewController *)controller;
- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction;

@end
