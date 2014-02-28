//
//  UserDetailMessageCardCell.h
//  certne
//
//  Created by apple on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImageButton.h"
#import "FriendInfoAndMessage.h"

@protocol UserHeadImageButtonClickedDelegate;

@interface UserDetailMessageCardCell : UITableViewCell
{
    HeadImageButton *_headImagebutton;
    UILabel         *_nameLabel;
    UILabel         *_companyLabel;
    UIImageView     *_productImageView;
    UILabel         *_messageLabel;
    UILabel         *_dateLabel;
    UILabel         *_locationLabel;
    
    UIImageView     *_backgroundImageView;
    
    id<UserHeadImageButtonClickedDelegate>  _delegate;
}

@property (retain, nonatomic) HeadImageButton       *headImagebutton;
@property (assign, nonatomic) id<UserHeadImageButtonClickedDelegate> delegate;

-(void)cleanComponent;

-(void)setUserPublishMessage:(FriendDetailData *)friendInfo publicInfo:(InfoData *)infoData indexPath:(NSIndexPath *)indexPath;

-(void)setHeadImage:(UIImage *)headImage;
-(void)setUserName:(NSString *)userName;
-(void)setUserCompany:(NSString *)userCompany;
-(void)setProductImage:(UIImage *)productImage;
-(void)setUserMessage:(NSString *)userMessage;
-(void)setDate:(NSString *)date;
-(void)setLocation:(NSString *)location;

+(CGFloat)caculateCellHeightWithPublishMessage:(NSString *)publicDesc;

@end

@protocol UserHeadImageButtonClickedDelegate <NSObject>

-(void)loadUserCardView:(HeadImageButton *)headImagebutton;

@end
