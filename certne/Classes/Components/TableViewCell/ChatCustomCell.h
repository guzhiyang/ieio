//
//  ChatCustomCell.h
//  certne
//
//  Created by apple on 13-6-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCustomCell : UITableViewCell
{
    UILabel *_dateLabel;
    UIImageView *_dateBgImageView;
}

@property(retain,nonatomic)UILabel *dateLabel;
@property(retain,nonatomic)UIImageView *dateBgImageView;

@end
