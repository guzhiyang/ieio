//
//  leftMenuViewController.h
//  certne
//
//  Created by apple on 13-5-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "SiderBarDelegate.h"
#import "LeftSidebarCell.h"
#import "PublishInformationViewController.h"
#import "ConnectionsViewController.h"
#import "SystemSettingViewController.h"
#import "RecentContactViewController.h"
#import "certneCardViewController.h"

//--数据请求
#import "GetMyFriendsInfoRequest.h"
#import "GetSupplyListRequest.h"
#import "GetNeedListRequest.h"
#import "GetContactUserListRequest.h"

//@protocol SiderBarDelegate;//--代理

@interface leftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,GetMyFriendsInfoRequestDelegate,GetSupplyListRequestDelegate,GetNeedListRequestDelegate,GetContactUserListRequestDelegate>
{
    NSMutableArray      *menuDataList;
    NSArray             *_iconArray;

    ConnectionsViewController           *_connectViewController;
    SystemSettingViewController         *_systemSettingViewController;
    PublishInformationViewController    *_publishInformationViewController;
    RecentContactViewController         *_recentContactViewController;
    
    GetMyFriendsInfoRequest             *_getMyFriendsInfoRequest;
    GetSupplyListRequest                *_getSupplyListRequest;
    GetNeedListRequest                  *_getNeedListRequest;
    GetContactUserListRequest           *_getContactUserListRequest;

    NSArray                             *_getFriendsTempArray;
    NSString                            *_getFriendsResponse;
    
    NSArray                             *_getContactUserTempArray;
    NSString                            *_getContactUserResponse;
    
    NSArray                             *_getSupplyListArray;
    NSArray                             *_getNeedListArray;
    NSString                            *_getSupplyResponse;
    NSString                            *_getNeedResponse;
}

@property (assign, nonatomic) id<SiderBarDelegate>  delegate;

@property (strong, nonatomic) UITableView           *menuTableView;
@property (strong, nonatomic) NSArray               *iconArray;

@end
