//
//  PublicMessageCell.m
//  certne
//
//  Created by apple on 13-9-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PublicMessageCell.h"
#import "Foundation.h"

@implementation PublicMessageCell
@synthesize headImageButton = _headImageButton;
@synthesize delegate        = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageButton = [CellButton buttonWithType:UIButtonTypeCustom];
        _headImageButton.frame = CGRectMake(10, 10, 40, 40);
        [_headImageButton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_headImageButton];
        
        UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        coverImageView.image = [UIImage imageNamed:@"headImage_cover.png"];
        [self.contentView addSubview:coverImageView];
        [coverImageView release];
        
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(55, 15, 80, 20)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor     = UIColorFromFloat(55, 175, 175);
        _nameLabel.font = [UIFont fontWithName:FONTNAME size:14];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        _companyLabel=[[UILabel alloc] initWithFrame:CGRectMake(55, 35, 140, 15)];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.font = [UIFont fontWithName:FONTNAME size:12];
        _companyLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_companyLabel];
        [_companyLabel release];
        
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 300, 100)];
        [self.contentView addSubview:_productImageView];
        [_productImageView release];
        
        _productMessageLabel=[[UILabel alloc] init];
        _productMessageLabel.font=[UIFont fontWithName:FONTNAME size:12];
        _productMessageLabel.backgroundColor = [UIColor clearColor];
        _productMessageLabel.numberOfLines = 3;
        _productMessageLabel.lineBreakMode = UILineBreakModeCharacterWrap|UILineBreakModeTailTruncation;
        _productMessageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_productMessageLabel];
        [_productMessageLabel release];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"date_bg" ofType:@"png"];
        _backGroundImageView = [[UIImageView alloc] init];
        _backGroundImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        [self.contentView addSubview:_backGroundImageView];
        [_backGroundImageView release];
        
        _dateLabel=[[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont fontWithName:FONTNAME size:13];
        _dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.backgroundColor = [UIColor clearColor];
        _locationLabel.font = [UIFont fontWithName:FONTNAME size:13];
        [self.contentView addSubview:_locationLabel];
        [_locationLabel release];
        
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

#pragma mark- Custom event methods

-(void)headImageButtonClicked:(id)sender
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(headImageButtonClickedPushDetalMessage:)]) {
        [_delegate headImageButtonClickedPushDetalMessage:_headImageButton];
    }
}

#pragma mark- Set cell content methods

-(void)setUserPublicInfo:(PublicInfo *)publicInfo indexPath:(NSIndexPath *)indexPath
{
    _headImageButton.cellSection = indexPath.section;
    _headImageButton.cellRow     = indexPath.row;
    
    [self setUserName:publicInfo.name];
    [self setCompanyName:publicInfo.company];
    [self setProductMessage:publicInfo.desc];
    [self setLocation:publicInfo.publishAddress];
    [self setDate:publicInfo.addTime];
}

-(void)setHeadImage:(UIImage *)headImage
{
    [_headImageButton setBackgroundImage:headImage forState:UIControlStateNormal];
}

-(void)setUserName:(NSString *)userName
{
    _nameLabel.text = userName;
}

-(void)setCompanyName:(NSString *)userCompany
{
    _companyLabel.text = userCompany;
}

-(void)setProductImage:(UIImage *)productImage
{
    _productImageView.image = productImage;
}

-(void)setProductMessage:(NSString *)productMessage
{
//    CGSize messageSize=[productMessage sizeWithFont:[UIFont fontWithName:FONTNAME size:14]
//                                   constrainedToSize:CGSizeMake(270, 100000)
//                                       lineBreakMode:UILineBreakModeCharacterWrap];
    _productMessageLabel.frame = CGRectMake(15, 165, 270, 50);
    
//    CGFloat orginY=_productMessageLabel.frame.origin.y+messageSize.height+13;
    
    _backGroundImageView.frame = CGRectMake(0, 220, 300, 30);
    _dateLabel.frame           = CGRectMake(0, 228, 150, 15);
    _locationLabel.frame       = CGRectMake(150, 228, 150, 15);
    _productMessageLabel.text  = productMessage;
}

-(void)setDate:(NSString *)date
{
    _dateLabel.text = date;
}

-(void)setLocation:(NSString *)location
{
    _locationLabel.text = location;
}

//+(CGFloat)caculateCellHeightWithProductMessage:(UserPublishMessage *)publishMessage
//{
//    CGSize textsize=[publishMessage.productMessage sizeWithFont:[UIFont fontWithName:FONTNAME size:14]
//                                              constrainedToSize:CGSizeMake(270, 100000)
//                                                  lineBreakMode:UILineBreakModeCharacterWrap|UILineBreakModeTailTruncation];
//    CGFloat height=textsize.height+10+40+10+100+25+15;
//    CGFloat height=250.0f;
//    return height;
//}

+(CGFloat)caculateCellHeightWithProductMessage:(NSString *)publicInfo
{
    CGFloat height = 250.0f;
    return height;
}

#pragma mark- Custom event methods

-(void)cleanComponent
{
    [_headImageButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_headImageButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    _nameLabel           = nil;
    _companyLabel        = nil;
    _productImageView    = nil;
    _productMessageLabel = nil;
    _dateLabel           = nil;
    _locationLabel       = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    [super dealloc];
}

@end
