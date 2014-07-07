//
//  PromptsMessageCell.h
//  certne
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImageButton.h"
#import "PushMessage.h"

@protocol PromptsMessageCellDelegate;

@interface PromptsMessageCell : UITableViewCell
{
    HeadImageButton     *_headImageButton;
    UILabel             *_messageLabel;
    UILabel             *_nameLabel;
    UILabel             *_timeLabel;
    HeadImageButton     *_addFriendButton;
    __unsafe_unretained id<PromptsMessageCellDelegate>  _delegate;
}

@property (strong, nonatomic) HeadImageButton   *headImageButton;
@property (strong, nonatomic) UILabel           *messageLabel;
@property (strong, nonatomic) UILabel           *nameLabel;
@property (strong, nonatomic) UILabel           *timeLabel;
@property (strong, nonatomic) HeadImageButton   *addFriendButton;
@property (assign, nonatomic) id<PromptsMessageCellDelegate>    delegate;

-(void)cleanCompents;

-(void)setUserHeadImage:(UIImage *)headImage;
-(void)setUserName:(NSString *)userName;
-(void)setPromptsMessage:(NSString *)message;
-(void)setTime:(NSString *)time;

-(void)setAllMessage:(PushMessage *)pushMessage indexPath:(NSIndexPath *)indexPath;

@end

@protocol PromptsMessageCellDelegate <NSObject>

-(void)friendDetailInfoWithHeadImageButton:(HeadImageButton *)headImageButton;

-(void)addFriendWithAddFriendButton:(HeadImageButton *)addFriendButton;

@end
