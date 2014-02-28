//
//  UserDataCell.h
//  certne
//
//  Created by apple on 13-9-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataCell : UITableViewCell
{
    UILabel     *_nameLabel;
    UILabel     *_positionLabel;
    UILabel     *_supplyLabel;
    UILabel     *_companyLabel;
}

@property (retain, nonatomic) UILabel   *nameLabel;
@property (retain, nonatomic) UILabel   *positionLabel;
@property (retain, nonatomic) UILabel   *supplyLabel;
@property (retain, nonatomic) UILabel   *companyLabel;

-(void)cleanCompent;

@end
