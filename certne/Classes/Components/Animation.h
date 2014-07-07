//
//  Animation.h
//  certne
//
//  Created by apple on 13-8-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animation : NSObject
{
}

+(void)popupAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait;

+(void)moveLeftAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait moveLength:(float)length;

+(void)moveUpAnimation:(UIView *)view animationDuration:(float)duration wait:(BOOL)wait moveLength:(float)length;

@end
