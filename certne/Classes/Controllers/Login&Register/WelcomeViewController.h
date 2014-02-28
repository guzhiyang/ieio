//
//  WelcomeViewController.h
//  certne
//
//  Created by apple on 13-9-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface WelcomeViewController : BaseViewController<UIScrollViewDelegate>
{
    UIScrollView        *_usageScrollView;
    UIPageControl       *_pageControl;
    UIView              *_contentView;
}

@property (retain, nonatomic) UIScrollView      *usageScrollView;
@property (retain, nonatomic) UIPageControl     *pageControl;
@property (retain, nonatomic) UIView            *contentView;

@end
