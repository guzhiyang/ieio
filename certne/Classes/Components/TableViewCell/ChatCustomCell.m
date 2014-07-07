//
//  ChatCustomCell.m
//  certne
//
//  Created by apple on 13-6-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ChatCustomCell.h"
#import "Foundation.h"

@implementation ChatCustomCell
@synthesize dateLabel=_dateLabel;
@synthesize dateBgImageView=_dateBgImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImage *labelBgImage=[UIImage imageNamed:@"chatDate_label.png"];
        UIImage *strechableLabelBgImage=[labelBgImage stretchableImageWithLeftCapWidth:12 topCapHeight:10];
        
        _dateBgImageView =[[UIImageView alloc]initWithFrame:CGRectMake(210, 5, 100, 20)];
        [_dateBgImageView setImage:strechableLabelBgImage];
//        [self addSubview:_dateBgImageView];
        
        _dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 6, 120, 20)];
        [_dateLabel setBackgroundColor:[UIColor clearColor]];
        [_dateLabel setFont:[UIFont fontWithName:FONTNAME size:13]];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:_dateLabel]; //去掉datelabel
        
        self.contentView.backgroundColor=[UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
        
        self.imageView.image        = nil;
        self.imageView.hidden       = YES;
        self.textLabel.text         = nil;
        self.textLabel.hidden       = YES;
        self.detailTextLabel.text   = nil;
        self.detailTextLabel.hidden = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
}

@end
