//
//  NearbyUserCell.h
//  certne
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation.h"
#import "NearbyUser.h"

@interface NearbyUserCell : UITableViewCell
{
    UIButton        *_headImageButton;
    UILabel         *_nameLabel;
    UILabel         *_positionLabel;
    UILabel         *_companyLabel;
    UILabel         *_distanceLabel;
    UIView          *_animationView;
}

@property (nonatomic, strong) UIButton     *headImageButton;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel      *positionLabel;
@property (nonatomic, strong) UILabel      *companyLabel;
@property (nonatomic, strong) UILabel      *distanceLabel;
@property (nonatomic, strong) UIView       *animationView;

-(void)setUserMessage:(NearbyUser *)user indexPath:(NSIndexPath *)indexPath;

-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserDistance:(NSString *)aDistance;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(UIImage *)aHeadImage;

-(void)cleanComponents;

@end
