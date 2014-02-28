//
//  Animation.m
//  certne
//
//  Created by apple on 13-8-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Animation.h"

@implementation Animation

+(void)popupAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait
{
    __block BOOL done=wait;
    view.transform=CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:duration
                     animations:^{
                         view.transform=CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         done=NO;
                     }];
    
//    while (done==YES)
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}

+(void)moveLeftAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait moveLength:(float)length
{
    __block BOOL done=wait;
    [UIView animateWithDuration:duration
                     animations:^{
                         view.center=CGPointMake(view.center.x-length, view.center.y);
                     } completion:^(BOOL finished) {
                         done=NO;
                     }];
}

+(void)moveUpAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait moveLength:(float)length
{
    __block BOOL done=wait;
    [UIView animateWithDuration:duration
                     animations:^{
                         view.center=CGPointMake(view.center.x, view.center.y-length);
                     }
                     completion:^(BOOL finished) {
                         done=NO;
                     }];
}

-(void)dealloc
{
    [super dealloc];
}

@end
