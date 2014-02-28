//
//  HeadImageButton.h
//  certne
//
//  Created by apple on 13-9-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageButton : UIButton
{
    NSInteger       _cellSection;
    NSInteger       _cellRow;
}

@property (assign, nonatomic) NSInteger     cellSection;
@property (assign, nonatomic) NSInteger     cellRow;

@end
