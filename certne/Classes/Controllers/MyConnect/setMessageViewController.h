//
//  setMessageViewController.h
//  certne
//
//  Created by apple on 13-5-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendDetailData.h"

@class HeadNavView;
@interface setMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray             *_sectionText;
    
    NSArray             *_btnImageArray;
    NSArray             *_titleArray;
    NSMutableArray      *_userInfoArray;
    
    HeadNavView         *_headNavView;
    FriendDetailData    *_friendDetailData;
}

@property (strong, nonatomic) UITableView       *contactTableView;
@property (strong, nonatomic) HeadNavView       *headNavView;
@property (strong, nonatomic) FriendDetailData  *friendDetailData;

-(void)createUserInfoArray;

@end
