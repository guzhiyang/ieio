//
//  setMessageCell.m
//  certne
//
//  Created by apple on 13-5-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "setMessageCell.h"
#import "Foundation.h"

@implementation setMessageCell
@synthesize iconImageView;
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        [self.contentView addSubview:iconImageView];
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 34, 200, 16)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:[UIColor darkGrayColor]];
        [titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [self addSubview:titleLabel];
        
        contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 220, 24)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextAlignment:NSTextAlignmentLeft];
        [contentLabel setFont:[UIFont fontWithName:FONTNAME size:16]];
        [self addSubview:contentLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 300, 1)];
        lineView.backgroundColor = UIColorFromFloat(210, 215, 226);
        [self.contentView addSubview:lineView];
    }
    return self;
}

#pragma mark - Set Value for cell

-(void)setButtonBackGroundImage:(UIImage *)image
{
    iconImageView.image = image;
}

-(void)setTitleLabelText:(NSString *)title
{
    titleLabel.text = title;
}

-(void)setContentLabelText:(NSString *)content
{
    contentLabel.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    titleLabel   = nil;
    contentLabel = nil;
}

@end
