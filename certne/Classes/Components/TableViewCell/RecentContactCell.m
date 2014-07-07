//
//  RecentContactCell.m
//  certne
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RecentContactCell.h"
#import "Foundation.h"

@implementation RecentContactCell
@synthesize view            = _view;
@synthesize headImageButton = _headImageButton;
@synthesize nameLabel       = _nameLabel;
@synthesize companyLabel    = _companyLabel;
@synthesize industryLabel   = _industryLabel;
@synthesize positionLabel   = _positionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _headImageButton.frame=CGRectMake(26, 11, 68, 68);
        
        UIImageView *headTempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 10, 70, 70)];
        [headTempImageView setImage:[UIImage imageNamed:@"circle_headImage.png"]];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 60, 20)];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        [_nameLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setTextColor:UIColorFromFloat(55, 171, 170)];
        
        _positionLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 15)];
        [_positionLabel setBackgroundColor:[UIColor clearColor]];
        [_positionLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_positionLabel setTextAlignment:NSTextAlignmentLeft];
        [_positionLabel setTextColor:UIColorFromFloat(55, 171, 170)];
        
        _industryLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, 188, 15)];
        [_industryLabel setBackgroundColor:[UIColor clearColor]];
        [_industryLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_industryLabel setTextAlignment:NSTextAlignmentLeft];
        [_industryLabel setTextColor:UIColorFromFloat(100, 100, 100)];
        
        _companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 188, 15)];
        [_companyLabel setBackgroundColor:[UIColor clearColor]];
        [_companyLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [_companyLabel setTextAlignment:NSTextAlignmentLeft];
        [_companyLabel setTextColor:UIColorFromFloat(100, 100, 100)];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 89, self.bounds.size.width, 1)];
        lineView.backgroundColor = UIColorFromFloat(220, 220, 220);
        
        _view=[[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 90)];
        [_view addSubview:_headImageButton];
        [_view addSubview:headTempImageView];
        [_view addSubview:_nameLabel];
        [_view addSubview:_positionLabel];
        [_view addSubview:_industryLabel];
        [_view addSubview:_companyLabel];
        [_view addSubview:lineView];
        [self.contentView addSubview:_view];
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
    _industryLabel.text = nil;
    _companyLabel.text  = nil;
}

#pragma mark- Create user data

-(void)setUserMessage:(ContactUser *)user indexPath:(NSIndexPath *)indexPath
{
    [self cleanComponents];
    [self setUserName:user.name];
    [self setUserPosition:user.position];
    [self setUserInfo:user.info];
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

-(void)setUserInfo:(NSString *)aInfo
{
    _industryLabel.text = aInfo;
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
