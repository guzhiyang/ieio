//
//  NearbyFriendViewController.h
//  certne
//
//  Created by apple on 13-6-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NearbyUser.h"
//#import "ImageDownLoadQueue.h"
#import "PromptsLabel.h"
#import "ReadNoticeRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "GetNearbyUserListRequest.h"
#import "PromptsMessageViewController.h"

@interface NearbyFriendViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ReadNoticeRequestDelegate,EGORefreshTableHeaderDelegate,GetNearbyUserListRequestDelegate>
{
    UITableView                 *_nearbyFriendTabelView;
    EGORefreshTableHeaderView   *_refreshHeaderView;
    BOOL                        _isLoading;
    
    NSArray                     *_nearbyUserParserArray;
    NSMutableArray              *_nearbyUserArray;
    
    NSMutableArray              *_headImageArray;
    NSMutableDictionary         *_headImageDic;
    
    PromptsLabel                *_chatMessageLabel;
    NSMutableArray              *_pushMessageArray;
    
    ReadNoticeRequest           *_readNoticeRequest;
    GetNearbyUserListRequest    *_getNearbyUserListRequest;
    PromptsMessageViewController *_promptsMessageViewController;
}

@property (strong, nonatomic) UITableView       *nearbyFriendTabelView;
@property (strong, nonatomic) NSArray           *nearbyUserParserArray;
@property (strong, nonatomic) NSMutableArray    *nearbyUserArray;
@property (strong, nonatomic) NSMutableArray    *pushMessageArray;

/**
 *	@brief	获取解析数据，转换为用户数组
 */
-(void) createNearbyUserDataWithArray:(NSArray *)dataArray;

-(BOOL) clearPushMessage;

@end
