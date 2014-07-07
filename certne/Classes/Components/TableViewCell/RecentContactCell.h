//
//  RecentContactCell.h
//  certne
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation.h"
#import "ContactUser.h"

@interface RecentContactCell : UITableViewCell
{
    UIView          *_view;
    UIButton        *_headImageButton;
    UILabel         *_nameLabel;
    UILabel         *_positionLabel;
    UILabel         *_industryLabel;
    UILabel         *_companyLabel;
}

@property (nonatomic, strong) UIView       *view;
@property (nonatomic, strong) UIButton     *headImageButton;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel      *positionLabel;
@property (nonatomic, strong) UILabel      *industryLabel;
@property (nonatomic, strong) UILabel      *companyLabel;

-(void)setUserMessage:(ContactUser *)user indexPath:(NSIndexPath *)indexPath;

-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserInfo:(NSString *)aInfo;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(UIImage *)aHeadImage;

-(void)cleanComponents;

@end
