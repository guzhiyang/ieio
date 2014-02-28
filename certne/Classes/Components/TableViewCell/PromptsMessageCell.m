//
//  PromptsMessageCell.m
//  certne
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "PromptsMessageCell.h"
#import "Foundation.h"

@implementation PromptsMessageCell
@synthesize headImageButton = _headImageButton;
@synthesize messageLabel    = _messageLabel;
@synthesize nameLabel       = _nameLabel;
@synthesize timeLabel       = _timeLabel;
@synthesize addFriendButton = _addFriendButton;
@synthesize delegate        = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageButton = [CellButton buttonWithType:UIButtonTypeCustom];
        _headImageButton.frame = CGRectMake(12, 11, 68, 68);
        [_headImageButton addTarget:self action:@selector(headImageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_headImageButton];
        
        UIImageView *headTempImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
        [headTempImageView setImage:[UIImage imageNamed:@"circle_headImage.png"]];
        [self.contentView addSubview:headTempImageView];
        [headTempImageView release];
        
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 10, 140, 18)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:FONTNAME size:15];
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];

        _messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 30, 180, 40)];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = UIColorFromFloat(80, 80, 80);
        _messageLabel.font = [UIFont fontWithName:FONTNAME size:13];
        _messageLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_messageLabel];
        [_messageLabel release];
        
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 72, 180, 12)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont fontWithName:FONTNAME size:11];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = UIColorFromFloat(80, 80, 80);
        [self.contentView addSubview:_timeLabel];
        [_timeLabel release];
        
        _addFriendButton = [CellButton buttonWithType:UIButtonTypeCustom];
        _addFriendButton.frame = CGRectMake(280, 30, 30, 30);
        [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"add_friend.png"] forState:UIControlStateNormal];
        [_addFriendButton addTarget:self action:@selector(addFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addFriendButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 89, 320, 1)];
        lineView.backgroundColor = UIColorFromFloat(220, 220, 220);
        [self.contentView addSubview:lineView];
        [lineView release];
        
        self.contentView.backgroundColor = UIColorFromFloat(248, 248, 248);
    }
    return self;
}

#pragma mark - Custom event methods

-(void)headImageButtonClicked
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(friendDetailInfoWithHeadImageButton:)]) {
        [_delegate friendDetailInfoWithHeadImageButton:_headImageButton];
    }
}

-(void)addFriendButtonClicked
{
    [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"added_friend.png"] forState:UIControlStateNormal];
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addFriendWithAddFriendButton:)]) {
        [_delegate addFriendWithAddFriendButton:_addFriendButton];
    }
}

#pragma mark - setContent methods

-(void)setAllMessage:(PushMessage *)pushMessage indexPath:(NSIndexPath *)indexPath
{
    _headImageButton.cellRow     = indexPath.row;
    _headImageButton.cellSection = indexPath.section;
    _addFriendButton.cellRow     = indexPath.row;
    _addFriendButton.cellSection = indexPath.section;
}

-(void)setUserHeadImage:(UIImage *)headImage
{
    [_headImageButton setBackgroundImage:headImage forState:UIControlStateNormal];
}

-(void)setUserName:(NSString *)userName
{
    _nameLabel.text = userName;
}

-(void)setPromptsMessage:(NSString *)message
{
    _messageLabel.text = message;
}

-(void)setTime:(NSString *)time
{
    _timeLabel.text = time;
}

-(void)cleanCompents
{
    self.delegate          = nil;
    self.messageLabel.text = nil;
    self.nameLabel.text    = nil;
    self.timeLabel.text    = nil;
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
