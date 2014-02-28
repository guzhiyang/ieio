//
//  connectionsCell.m
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "connectionsCell.h"
#import "Foundation.h"

@implementation connectionsCell
@synthesize headImageButton;
@synthesize nameLabel;
@synthesize positionLabel;
@synthesize industryLabel;
@synthesize companyLabel;
@synthesize view;

#pragma mark-View lifeCycle methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        headImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        headImageButton.frame=CGRectMake(26, 11, 68, 68);
        
        UIImageView *headTempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 70, 70)];
        [headTempImageView setImage:[UIImage imageNamed:@"circle_headImage.png"]];
        
        nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 15, 60, 20)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        [nameLabel setTextColor:[UIColor colorWithRed:55/255.0f green:171/255.0f blue:170/255.0f alpha:1.0]];
        
        positionLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 15)];
        [positionLabel setBackgroundColor:[UIColor clearColor]];
        [positionLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [positionLabel setTextAlignment:NSTextAlignmentLeft];
        [positionLabel setTextColor:[UIColor colorWithRed:55/255.0f green:171/255.0f blue:170/255.0f alpha:1.0]];
        
        industryLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, 188, 15)];
        [industryLabel setBackgroundColor:[UIColor clearColor]];
        [industryLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [industryLabel setTextAlignment:NSTextAlignmentLeft];
        [industryLabel setTextColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1.0]];
        
        companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 60, 188, 15)];
        [companyLabel setBackgroundColor:[UIColor clearColor]];
        [companyLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [companyLabel setTextAlignment:NSTextAlignmentLeft];
        [companyLabel setTextColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:1.0]];
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 89, self.bounds.size.width, 1)];
        lineView.backgroundColor=[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0f];
        
        view=[[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, 90)];
        [view addSubview:headImageButton];
        [view addSubview:headTempImageView];
        [view addSubview:nameLabel];
        [view addSubview:positionLabel];
        [view addSubview:industryLabel];
        [view addSubview:companyLabel];
        [view addSubview:lineView];
        
        [self addSubview:view];
        [headTempImageView release];
        [lineView release];
    }
    return self;
}

#pragma mark-Custom event methods

-(void)cleanComponents
{
    [headImageButton setBackgroundImage:nil forState:UIControlStateNormal];
    nameLabel.text     = nil;
    positionLabel.text = nil;
    industryLabel.text = nil;
    companyLabel.text  = nil;
}

#pragma mark- Create user data

-(void)setFriendsInfo:(FriendsInfoListData *)friendsInfo indexPath:(NSIndexPath *)indexPath
{
    [self cleanComponents];
    [self setUserName:friendsInfo.name];
    [self setUserPosition:friendsInfo.position];
    [self setUserSupply:friendsInfo.info];
    [self setUserCompany:friendsInfo.company];
}

-(void)setUserName:(NSString *)aName
{
    nameLabel.text=aName;
}

-(void)setUserPosition:(NSString *)aPosition
{
    positionLabel.text=aPosition;
}

-(void)setUserSupply:(NSString *)aSupply
{
    industryLabel.text=aSupply;
}

-(void)setUserCompany:(NSString *)aCompany
{
    companyLabel.text=aCompany;
}

-(void)setUserHeadImage:(UIImage *)aheadImage
{
    [headImageButton setBackgroundImage:aheadImage forState:UIControlStateNormal];
}

#pragma mark- Memory management methods

-(void)dealloc
{
    [nameLabel release];
    [positionLabel release];
    [industryLabel release];
    [companyLabel release];
    [view release];
    [super dealloc];
}

@end