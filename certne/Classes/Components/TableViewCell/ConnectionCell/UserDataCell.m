//
//  UserDataCell.m
//  certne
//
//  Created by apple on 13-9-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UserDataCell.h"
#import "Foundation.h"

@implementation UserDataCell
@synthesize nameLabel     = _nameLabel;
@synthesize positionLabel = _positionLabel;
@synthesize supplyLabel   = _supplyLabel;
@synthesize companyLabel  = _companyLabel;

#pragma mark- Cell lifestyle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 15, 60, 20)];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.font=[UIFont fontWithName:FONTNAME size:18];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        _positionLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 15)];
        _positionLabel.backgroundColor=[UIColor clearColor];
        _positionLabel.font=[UIFont fontWithName:FONTNAME size:14];
        _positionLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_positionLabel];
        [_positionLabel release];
        
        _supplyLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, 200, 15)];
        _supplyLabel.backgroundColor=[UIColor clearColor];
        _supplyLabel.font=[UIFont fontWithName:FONTNAME size:14];
        _supplyLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_supplyLabel];
        [_supplyLabel release];
        
        _companyLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 60, 200, 15)];
        _companyLabel.backgroundColor=[UIColor clearColor];
        _companyLabel.font=[UIFont fontWithName:FONTNAME size:14];
        _companyLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_companyLabel];
        [_companyLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)cleanCompent
{
    _nameLabel.text     = nil;
    _positionLabel.text = nil;
    _supplyLabel.text   = nil;
    _companyLabel.text  = nil;
}

-(void)dealloc
{
    [super dealloc];
}

@end
