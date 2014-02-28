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
#import "NearbyFriendViewController.h"
#import "RecentContactViewController.h"
#import "certneCardViewController.h"

//--数据请求
#import "GetMyFriendsInfoRequest.h"
#import "GetNearbyUserListRequest.h"
#import "GetSupplyListRequest.h"
#import "GetNeedListRequest.h"
#import "GetContactUserListRequest.h"

//@protocol SiderBarDelegate;//--代理

@interface leftMenuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,GetMyFriendsInfoRequestDelegate,GetNearbyUserListRequestDelegate,GetSupplyListRequestDelegate,GetNeedListRequestDelegate,GetContactUserListRequestDelegate>
{
    NSMutableArray      *menuDataList;
    NSArray             *_iconArray;

//    certneCardViewController            *_certneCardViewController;
    ConnectionsViewController           *_connectViewController;
    NearbyFriendViewController          *_nearbyFriendViewController;
    SystemSettingViewController         *_systemSettingViewController;
    PublishInformationViewController    *_publishInformationViewController;
    RecentContactViewController         *_recentContactViewController;
    
    GetMyFriendsInfoRequest             *_getMyFriendsInfoRequest;
    GetNearbyUserListRequest            *_getNearbyUserListRequest;
    GetSupplyListRequest                *_getSupplyListRequest;
    GetNeedListRequest                  *_getNeedListRequest;
    GetContactUserListRequest           *_getContactUserListRequest;

    NSArray                             *_getFriendsTempArray;
    NSString                            *_getFriendsResponse;
    
    NSArray                             *_getNearbyUserTempArray;
    NSString                            *_getNearbyUserResponse;
    
    NSArray                             *_getContactUserTempArray;
    NSString                            *_getContactUserResponse;
    
    NSArray                             *_getSupplyListArray;
    NSArray                             *_getNeedListArray;
    NSString                            *_getSupplyResponse;
    NSString                            *_getNeedResponse;
}

@property (assign, nonatomic) id<SiderBarDelegate>  delegate;

@property (assign, nonatomic) UITableView           *menuTableView;
@property (retain, nonatomic) NSArray               *iconArray;

@end
