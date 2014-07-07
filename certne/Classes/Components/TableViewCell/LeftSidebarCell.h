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

@property (strong, nonatomic) UIImageView     *iconImageView;
@property (strong, nonatomic) UIImageView     *iconBGImageView;
@property (strong, nonatomic) UILabel         *titleLabel;
@property (strong, nonatomic) NSIndexPath     *cellIndexpath;

@end
