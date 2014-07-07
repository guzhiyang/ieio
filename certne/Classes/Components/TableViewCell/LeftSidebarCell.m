//
//  LeftSidebarCell.m
//  certne
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//----系统设置导航，点击问题，可能跟cell高度有关

#import "LeftSidebarCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Foundation.h"

@implementation LeftSidebarCell
@synthesize iconImageView   = _iconImageView;
@synthesize titleLabel      = _titleLabel;
@synthesize cellIndexpath   = _cellIndexpath;
@synthesize iconBGImageView = _iconBGImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconBGImageView=[[UIImageView alloc] initWithFrame:CGRectMake(33, kUIsIphone5?23:15, 35, 35)];
        _iconBGImageView.image=[UIImage imageNamed:@"iconBG.png"];
        [self.contentView addSubview:_iconBGImageView];
        
        _iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(38, kUIsIphone5?28:20, 25, 25)];
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kUIsIphone5?67:55, 80, 20)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

#pragma mark- 被选中和高亮状态

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //--被选中状态
    [super setSelected:selected animated:animated];
    
    if (self.cellIndexpath.row == 0) {
//        self.selectedBackgroundView=[]
    }
    
    if (selected) {
        _iconBGImageView.layer.shadowRadius  = 8.0f;
        _iconBGImageView.layer.shadowOffset  = CGSizeMake(0, 0);
        _iconBGImageView.layer.shadowOpacity = 1.0;
        _iconBGImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    }else{
        self.backgroundView   = nil;
        _titleLabel.textColor = [UIColor whiteColor];
        _iconBGImageView.layer.shadowRadius = 0;
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    //--高亮显示
    [super setHighlighted:highlighted animated:animated];
}

#pragma mark- Memory management methods

-(void)dealloc
{
    _iconImageView = nil;
    _titleLabel    = nil;
}

@end
