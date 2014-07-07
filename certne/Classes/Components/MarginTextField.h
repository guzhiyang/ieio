//
//  MarginTextField.h
//  certne
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarginTextField : UITextField
{
    CGFloat     _dx;
    CGFloat     _dy;
}

@property (assign, nonatomic) CGFloat   dx;
@property (assign, nonatomic) CGFloat   dy;

@end
