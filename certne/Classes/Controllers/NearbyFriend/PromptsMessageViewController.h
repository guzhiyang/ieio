//
//  PromptsMessageViewController.h
//  certne
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NavBarView.h"
#import "PromptsMessageCell.h"
#import "AgreeInviteRequest.h"
//#import "ImageDownLoadQueue.h"

@interface PromptsMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,NavBarViewDelegate,PromptsMessageCellDelegate,AgreeInviteRequestDelegate>
{
    UITableView             *_promptsMessageTableView;
    NSMutableArray          *_messageArray;
    NavBarView              *_navBarView;
    
    UIView                  *_tipView;
    UIView                  *_contentView;
    AgreeInviteRequest      *_agreeInviteRequest;
    
    NSMutableArray          *_headImageURLArray;
    NSMutableDictionary     *_headImageDic;
//    ImageDownLoadQueue      *_imageDownLoadQueue;
}

@property (strong, nonatomic) UITableView       *promptsMessageTableView;
@property (strong, nonatomic) NSMutableArray    *messageArray;

@end
