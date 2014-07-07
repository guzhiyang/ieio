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
#import "GetMyFriendsInfoRequest.h"

@interface ConnectionsViewController : MMReachabilityViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,EGORefreshTableHeaderDelegate,GetFriendDetailInfoRequestDelegate,NavBarViewDelegate,GetMyFriendsInfoRequestDelegate>
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
}

@property (strong, nonatomic) UIToolbar         *navToolBar;
@property (strong, nonatomic) UITableView       *connectionTableView;
@property (strong, nonatomic) UITextField       *searchTextField;
@property (strong, nonatomic) UIButton          *searchButton;
@property (strong, nonatomic) UIImageView       *arrow_leftImageView;
@property (strong, nonatomic) UIImage           *arrow_leftImage;
@property (strong, nonatomic) NSArray           *parserFriendsArray;
@property (strong, nonatomic) NSMutableArray    *myFriendsArray;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
