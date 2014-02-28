//
//  PublicMessageCell.h
//  certne
//
//  Created by apple on 13-9-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicInfo.h"
#import "CellButton.h"

@protocol HeadImageButtonClickedDelegate;

@interface PublicMessageCell : UITableViewCell
{
    CellButton          *_headImageButton;
    UILabel             *_nameLabel;
    UILabel             *_companyLabel;
    UIImageView         *_productImageView;
    UILabel             *_productMessageLabel;
    UIImageView         *_backGroundImageView;
    UILabel             *_dateLabel;
    UILabel             *_locationLabel;
    
    id<HeadImageButtonClickedDelegate>  _delegate;
}

@property (retain, nonatomic) CellButton        *headImageButton;
@property (assign, nonatomic) id<HeadImageButtonClickedDelegate> delegate;

-(void)cleanComponent;

-(void)setHeadImage:(UIImage *)headImage;
-(void)setUserName:(NSString *)userName;
-(void)setCompanyName:(NSString *)userCompany;
-(void)setProductImage:(UIImage *)productImage;
-(void)setProductMessage:(NSString *)productMessage;
-(void)setDate:(NSString *)date;
-(void)setLocation:(NSString *)location;

-(void)setUserPublicInfo:(PublicInfo *)publicInfo indexPath:(NSIndexPath *)indexPath;

+(CGFloat)caculateCellHeightWithProductMessage:(NSString *)publicInfo;

@end

@protocol HeadImageButtonClickedDelegate <NSObject>

-(void)headImageButtonClickedPushDetalMessage:(CellButton *)headImagebutton;

@end