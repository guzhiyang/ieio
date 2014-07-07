//
//  NearbyUserCell.m
//  certne
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NearbyUserCell.h"
#import "Foundation.h"

@implementation NearbyUserCell
@synthesize headImageButton = _headImageButton;
@synthesize nameLabel       = _nameLabel;
@synthesize companyLabel    = _companyLabel;
@synthesize positionLabel   = _positionLabel;
@synthesize distanceLabel   = _distanceLabel;
@synthesize animationView   = _animationView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headImageButton.frame = CGRectMake(26, 11, 68, 68);
        
        UIImageView *headTempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 70, 70)];
        [headTempImageView setImage:[UIImage imageNamed:@"circle_headImage.png"]];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 15, 60, 20)];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        [_nameLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setTextColor:[UIColor colorWithRed:55/255.0f green:171/255.0f blue:170/255.0f alpha:1.0]];
        
        _positionLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 15)];
        [_positionLabel setBackgroundColor:[UIColor clearColor]];
        [_positionLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_positionLabel setTextAlignment:NSTextAlignmentLeft];
        [_positionLabel setTextColor:[UIColor colorWithRed:55/255.0f green:171/255.0f blue:170/255.0f alpha:1.0]];
        
        _distanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, 188, 15)];
        [_distanceLabel setBackgroundColor:[UIColor clearColor]];
        [_distanceLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_distanceLabel setTextAlignment:NSTextAlignmentLeft];
        [_distanceLabel setTextColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1.0]];
        
        _companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 188, 15)];
        [_companyLabel setBackgroundColor:[UIColor clearColor]];
        [_companyLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_companyLabel setTextAlignment:NSTextAlignmentLeft];
        [_companyLabel setTextColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1.0]];
        
        UIImageView *cell_arrowImageView=[[UIImageView alloc] initWithFrame:CGRectMake(295, 35, 10, 20)];
        cell_arrowImageView.image=[UIImage imageNamed:@"cell_arrow.png"];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 89, self.bounds.size.width, 1)];
        lineView.backgroundColor = UIColorFromFloat(220, 220, 220);
        
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(kFBaseWidth, 0, kFBaseWidth, self.contentView.frame.size.height)];
        [self.animationView addSubview:_headImageButton];
        [self.animationView addSubview:headTempImageView];
        [self.animationView addSubview:_nameLabel];
        [self.animationView addSubview:_positionLabel];
        [self.animationView addSubview:_distanceLabel];
        [self.animationView addSubview:_companyLabel];
        [self.animationView addSubview:cell_arrowImageView];
        [self.animationView addSubview:lineView];
        [self.contentView addSubview:self.animationView];
        
        self.contentView.backgroundColor = UIColorFromFloat(248, 248, 248);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark-Custom event methods

-(void)cleanComponents
{
    [_headImageButton setBackgroundImage:nil forState:UIControlStateNormal];
    _nameLabel.text     = nil;
    _positionLabel.text = nil;
    _distanceLabel.text = nil;
    _companyLabel.text  = nil;
}

#pragma mark- Create user data

-(void)setUserMessage:(NearbyUser *)user indexPath:(NSIndexPath *)indexPath
{
    [self cleanComponents];
    [self setUserName:user.name];
    [self setUserPosition:user.position];
    [self setUserDistance:[NSString stringWithFormat:@"%i米", user.distance]];
    [self setUserCompany:user.company];
}

-(void)setUserName:(NSString *)aName
{
    _nameLabel.text = aName;
}

-(void)setUserPosition:(NSString *)aPosition
{
    _positionLabel.text = aPosition;
}

-(void)setUserDistance:(NSString *)aDistance
{
    _distanceLabel.text = aDistance;
}

-(void)setUserCompany:(NSString *)aCompany
{
    _companyLabel.text = aCompany;
}

-(void)setUserHeadImage:(UIImage *)aheadImage
{
    [_headImageButton setBackgroundImage:aheadImage forState:UIControlStateNormal];
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
}

@end
