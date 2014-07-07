//
//  ContentView.h
//  certne
//
//  Created by apple on 13-8-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentViewTransLateDelegate;

@interface ContentView : UIView
{
    UIPanGestureRecognizer                  *_panGestureRecognizer;
    __unsafe_unretained id<ContentViewTransLateDelegate>        _delegate;
}

@property (strong,nonatomic) UIPanGestureRecognizer           *panGestureRecognizer;
@property (assign,nonatomic) id<ContentViewTransLateDelegate >  delegate;

@end

@protocol ContentViewTransLateDelegate <NSObject>

-(void)sideBarShowing:(BOOL)showing translate:(float)translate;

@end