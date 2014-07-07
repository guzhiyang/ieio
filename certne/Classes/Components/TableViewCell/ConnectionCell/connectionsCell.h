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
#import "UIImageView+OnlineImage.h"

@interface connectionsCell : UITableViewCell
{
}

@property (nonatomic, strong) UIView       *view;
@property (nonatomic, strong) UIImageView  *headImageView;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel      *positionLabel;
@property (nonatomic, strong) UILabel      *industryLabel;
@property (nonatomic, strong) UILabel      *companyLabel;

-(void)setFriendsInfo:(FriendsInfoListData *)friendsInfo indexPath:(NSIndexPath *)indexPath;
-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserSupply:(NSString *)aSupply;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(NSString *)headImageURL;

-(void)cleanComponents;

@end
