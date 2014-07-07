//
//  PaddingTextField.h
//  certne
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaddingTextField : UITextField
{
    float       _verticalPadding;
    float       _horizontalPadding;
}

@property (nonatomic, assign) float     verticalPadding;
@property (nonatomic, assign) float     horizontalPadding;

@end
