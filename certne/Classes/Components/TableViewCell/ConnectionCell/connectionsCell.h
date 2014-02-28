//
//  connectionsCell.h
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation.h"
#import "FriendsInfoListData.h"
#import "PromptsLabel.h"

@interface connectionsCell : UITableViewCell
{
}

//--添加cell View测试移动动画
@property (nonatomic, retain) UIView       *view;
@property (nonatomic, retain) UIButton     *headImageButton;
@property (nonatomic, retain) UILabel      *nameLabel;
@property (nonatomic, retain) UILabel      *positionLabel;
@property (nonatomic, retain) UILabel      *industryLabel;
@property (nonatomic, retain) UILabel      *companyLabel;
@property (nonatomic, retain) PromptsLabel  *promptsLabel;

-(void)setFriendsInfo:(FriendsInfoListData *)friendsInfo indexPath:(NSIndexPath *)indexPath;
-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserSupply:(NSString *)aSupply;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(UIImage *)aHeadImage;

-(void)cleanComponents;

@end
