//
//  ConnectionsViewController.h
//  certne
//
//  Created by apple on 13-5-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "MMReachabilityViewController.h"
#import "GetFriendDetailInfoRequest.h"
#import "NavBarView.h"
#import "ImageDownLoadQueue.h"
#import "GetMyFriendsInfoRequest.h"

@interface ConnectionsViewController : MMReachabilityViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,EGORefreshTableHeaderDelegate,GetFriendDetailInfoRequestDelegate,NavBarViewDelegate,ImageDownLoadQueueDelegate,GetMyFriendsInfoRequestDelegate>
{
    UITableView                     *_connectionTableView;
    EGORefreshTableHeaderView       *_refreshHeaderView;
    
    UITextField                     *_searchTextField;
    UIButton                        *_searchButton;
    UIImageView                     *_arrow_leftImageView;
    UIImage                         *_arrow_leftImage;
    
    BOOL                            _reloading;
    NSInteger                       _currentSection;
    NSInteger                       _currentRow;
    NSArray                         *_parserFriendsArray;
    NSMutableArray                  *_myFriendsArray;
    
    GetFriendDetailInfoRequest      *_getFriendDetailInfoRequest;
    NavBarView                      *_navBarView;
    GetMyFriendsInfoRequest         *_getMyFriendsInfoRequest;
    
    NSMutableArray                  *_headImageArray;
    NSMutableDictionary             *_headImageDic;
    ImageDownLoadQueue              *_headImageDownQueue;
}

@property (retain, nonatomic) UIToolbar         *navToolBar;
@property (retain, nonatomic) UITableView       *connectionTableView;
@property (retain, nonatomic) UITextField       *searchTextField;
@property (retain, nonatomic) UIButton          *searchButton;
@property (retain, nonatomic) UIImageView       *arrow_leftImageView;
@property (retain, nonatomic) UIImage           *arrow_leftImage;
@property (retain, nonatomic) NSArray           *parserFriendsArray;
@property (retain, nonatomic) NSMutableArray    *myFriendsArray;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
