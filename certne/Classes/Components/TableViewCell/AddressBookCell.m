//
//  AddressBookCell.m
//  certne
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AddressBookCell.h"
#import "Foundation.h"

@implementation AddressBookCell
@synthesize nameLabel = _nameLabel;
@synthesize delegate  = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 22, 80, 16)];
        _nameLabel.text          = @"好友姓名";
        _nameLabel.font          = [UIFont fontWithName:FONTNAME size:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        UIImage *buttonImage = [UIImage imageNamed:@"button_green.png"];
        buttonImage = [buttonImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        UIButton *addFeriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addFeriendButton.frame = CGRectMake(260, 18, 40, 24);
        [addFeriendButton.titleLabel setFont:[UIFont fontWithName:FONTNAME size:12]];
        [addFeriendButton setTitle:@"邀请" forState:UIControlStateNormal];
        [addFeriendButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [addFeriendButton addTarget:self action:@selector(AddFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addFeriendButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
        [self.contentView addSubview:lineView];
        [lineView release];
    }
    return self;
}

#pragma mark - Custom event methods

-(void)AddFriendButtonClicked
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addressBookButtonClicked)]) {
        [_delegate addressBookButtonClicked];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
