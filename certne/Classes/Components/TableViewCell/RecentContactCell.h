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

@property (nonatomic, retain) UIView       *view;
@property (nonatomic, retain) UIButton     *headImageButton;
@property (nonatomic, retain) UILabel      *nameLabel;
@property (nonatomic, retain) UILabel      *positionLabel;
@property (nonatomic, retain) UILabel      *industryLabel;
@property (nonatomic, retain) UILabel      *companyLabel;

-(void)setUserMessage:(ContactUser *)user indexPath:(NSIndexPath *)indexPath;

-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserInfo:(NSString *)aInfo;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(UIImage *)aHeadImage;

-(void)cleanComponents;

@end
