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

@property (nonatomic, retain) UIButton     *headImageButton;
@property (nonatomic, retain) UILabel      *nameLabel;
@property (nonatomic, retain) UILabel      *positionLabel;
@property (nonatomic, retain) UILabel      *companyLabel;
@property (nonatomic, retain) UILabel      *distanceLabel;
@property (nonatomic, retain) UIView       *animationView;

-(void)setUserMessage:(NearbyUser *)user indexPath:(NSIndexPath *)indexPath;

-(void)setUserName:(NSString *)aName;
-(void)setUserPosition:(NSString *)aPosition;
-(void)setUserDistance:(NSString *)aDistance;
-(void)setUserCompany:(NSString *)aCompany;
-(void)setUserHeadImage:(UIImage *)aHeadImage;

-(void)cleanComponents;

@end
