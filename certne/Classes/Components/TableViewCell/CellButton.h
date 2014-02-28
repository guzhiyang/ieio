//
//  CellButton.h
//  certne
//
//  Created by apple on 14-1-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellButton : UIButton
{
    NSInteger   _cellRow;
    NSInteger   _cellSection;
}

@property (assign, nonatomic) NSInteger     cellRow;
@property (assign, nonatomic) NSInteger     cellSection;

@end
