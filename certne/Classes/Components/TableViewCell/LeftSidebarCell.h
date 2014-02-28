//
//  LeftSidebarCell.h
//  certne
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSidebarCell : UITableViewCell
{
    UIImageView     *_iconImageView;
    UIImageView     *_iconBGImageView;
    UILabel         *_titleLabel;
    
    NSIndexPath     *_cellIndexpath;
}

@property (retain, nonatomic) UIImageView     *iconImageView;
@property (retain, nonatomic) UIImageView     *iconBGImageView;
@property (retain, nonatomic) UILabel         *titleLabel;
@property (retain, nonatomic) NSIndexPath     *cellIndexpath;

@end
