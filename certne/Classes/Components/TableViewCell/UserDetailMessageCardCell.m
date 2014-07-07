//
//  UserDetailMessageCardCell.m
//  certne
//
//  Created by apple on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UserDetailMessageCardCell.h"
#import "Foundation.h"

@implementation UserDetailMessageCardCell
@synthesize delegate        = _delegate;
@synthesize headImagebutton = _headImagebutton;

#pragma mark- Cell lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImagebutton=[HeadImageButton buttonWithType:UIButtonTypeCustom];
        _headImagebutton.frame=CGRectMake(10, 10, 40, 40);
        [_headImagebutton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_headImagebutton];
        
        UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        coverImageView.image = [UIImage imageNamed:@"headImage_cover.png"];
        [self.contentView addSubview:coverImageView];
        
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(55, 15, 80, 20)];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        _nameLabel.textColor=[UIColor colorWithRed:55/255.0f green:171/255.0f blue:170/255.0f alpha:1.0f];
        _nameLabel.font=[UIFont fontWithName:FONTNAME size:14];
        _nameLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        
        _companyLabel=[[UILabel alloc] initWithFrame:CGRectMake(55, 35, 140, 15)];
        _companyLabel.textAlignment=NSTextAlignmentLeft;
        _companyLabel.font=[UIFont fontWithName:FONTNAME size:12];
        _companyLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_companyLabel];
        
        _productImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 300, 275)];
        [self.contentView addSubview:_productImageView];
        
        _messageLabel=[[UILabel alloc] init];
        _messageLabel.font=[UIFont fontWithName:FONTNAME size:12];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.numberOfLines = 0;//--这个行数是无限制的，配合下面的注释最初设置是3行。
//        _messageLabel.lineBreakMode = UILineBreakModeCharacterWrap|UILineBreakModeTailTruncation;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_messageLabel];
        
        NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"date_bg" ofType:@"png"];
        _backgroundImageView=[[UIImageView alloc] init];
        _backgroundImageView.image=[UIImage imageWithContentsOfFile:imagePath];
        [self.contentView addSubview:_backgroundImageView];
        
        _dateLabel=[[UILabel alloc] init];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        _dateLabel.font=[UIFont fontWithName:FONTNAME size:13];
        _dateLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
        
        _locationLabel=[[UILabel alloc] init];
        _locationLabel.textAlignment=NSTextAlignmentCenter;
        _locationLabel.backgroundColor=[UIColor clearColor];
        _locationLabel.font=[UIFont fontWithName:FONTNAME size:13];
        [self.contentView addSubview:_locationLabel];
        
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark- Custom event methods

-(void)headImageButtonClicked:(HeadImageButton *)headImageButton
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loadUserCardView:)]) {
        [_delegate loadUserCardView:headImageButton];
    }
}

#pragma mark- Set methods

-(void)setUserPublishMessage:(FriendDetailData *)friendInfo publicInfo:(InfoData *)infoData indexPath:(NSIndexPath *)indexPath
{
    _headImagebutton.cellRow = indexPath.row;
    _headImagebutton.cellSection = indexPath.section;
    
    NSString *date  = [NSString stringWithFormat:@"%@",infoData.addTime];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day   = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *hour  = [date substringWithRange:NSMakeRange(11, 2)];
    NSString *min   = [date substringWithRange:NSMakeRange(14, 2)];
    NSString *publicDate = [NSString stringWithFormat:@"%@月%@日 %@:%@",month,day,hour,min];
    
    [self setUserName:friendInfo.name];
    [self setUserCompany:friendInfo.company];
    [self setUserMessage:infoData.desc];
    [self setLocation:infoData.publishAddress];
    [self setDate:publicDate];
}

-(void)setHeadImage:(UIImage *)headImage
{
    [_headImagebutton setBackgroundImage:headImage forState:UIControlStateNormal];
}

-(void)setUserName:(NSString *)userName
{
    _nameLabel.text = userName;
}

-(void)setUserCompany:(NSString *)userCompany
{
    _companyLabel.text = userCompany;
}

-(void)setProductImage:(UIImage *)productImage
{
    _productImageView.image = productImage;
}

-(void)setUserMessage:(NSString *)userMessage
{
    CGSize messageSize=[userMessage sizeWithFont:[UIFont fontWithName:FONTNAME size:14]
                                  constrainedToSize:CGSizeMake(270, 100000)
                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    _messageLabel.frame = CGRectMake(15, 340, 270, messageSize.height);
    
    CGFloat orginY=_messageLabel.frame.origin.y+messageSize.height+13;
    
    _backgroundImageView.frame = CGRectMake(0, orginY-8, 300, 30);
    _dateLabel.frame           = CGRectMake(0, orginY, 150, 15);
    _locationLabel.frame       = CGRectMake(150, orginY, 150, 15);
    _messageLabel.text         = userMessage;
}

-(void)setDate:(NSString *)date
{
    _dateLabel.text=date;
}

-(void)setLocation:(NSString *)location
{
    _locationLabel.text=location;
}

#pragma mark- 计算cell高度

+(CGFloat)caculateCellHeightWithPublishMessage:(NSString *)publicDesc
{
    CGSize textsize=[publicDesc sizeWithFont:[UIFont fontWithName:FONTNAME size:14]
                                              constrainedToSize:CGSizeMake(270, 100000)
                                                  lineBreakMode:UILineBreakModeCharacterWrap|UILineBreakModeTailTruncation];
    CGFloat height=textsize.height+10+40+10+100+25+15+175;
    return height;
}

#pragma mark- 管理内存

-(void)cleanComponent
{
    _nameLabel        = nil;
    _companyLabel     = nil;
    _productImageView = nil;
    _messageLabel     = nil;
    _dateLabel        = nil;
    _locationLabel    = nil;
}

-(void)dealloc
{
}

@end
