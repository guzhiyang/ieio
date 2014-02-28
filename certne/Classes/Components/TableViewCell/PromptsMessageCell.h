//
//  PromptsMessageCell.h
//  certne
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellButton.h"
#import "PushMessage.h"

@protocol PromptsMessageCellDelegate;

@interface PromptsMessageCell : UITableViewCell
{
    CellButton  *_headImageButton;
    UILabel     *_messageLabel;
    UILabel     *_nameLabel;
    UILabel     *_timeLabel;
    CellButton  *_addFriendButton;
    id<PromptsMessageCellDelegate>  _delegate;
}

@property (retain, nonatomic) CellButton    *headImageButton;
@property (retain, nonatomic) UILabel       *messageLabel;
@property (retain, nonatomic) UILabel       *nameLabel;
@property (retain, nonatomic) UILabel       *timeLabel;
@property (retain, nonatomic) CellButton    *addFriendButton;
@property (assign, nonatomic) id<PromptsMessageCellDelegate>    delegate;

-(void)cleanCompents;

-(void)setUserHeadImage:(UIImage *)headImage;
-(void)setUserName:(NSString *)userName;
-(void)setPromptsMessage:(NSString *)message;
-(void)setTime:(NSString *)time;

-(void)setAllMessage:(PushMessage *)pushMessage indexPath:(NSIndexPath *)indexPath;

@end

@protocol PromptsMessageCellDelegate <NSObject>

-(void)friendDetailInfoWithHeadImageButton:(CellButton *)headImageButton;

-(void)addFriendWithAddFriendButton:(CellButton *)addFriendButton;

@end
