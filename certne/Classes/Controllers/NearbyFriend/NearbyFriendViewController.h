//
//  NearbyFriendViewController.h
//  certne
//
//  Created by apple on 13-6-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "NearbyUser.h"
#import "NavBarView.h"
#import "ImageDownLoadQueue.h"
#import "PromptsLabel.h"
#import "ReadNoticeRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "GetNearbyUserListRequest.h"
#import "PromptsMessageViewController.h"

@interface NearbyFriendViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,NavBarViewDelegate,ImageDownLoadQueueDelegate,ReadNoticeRequestDelegate,EGORefreshTableHeaderDelegate,GetNearbyUserListRequestDelegate>
{
    UITableView                 *_nearbyFriendTabelView;
    EGORefreshTableHeaderView   *_refreshHeaderView;
    BOOL                        _isLoading;
    
    NSArray                     *_nearbyUserParserArray;
    NSMutableArray              *_nearbyUserArray;
    NavBarView                  *_navBarView;
    
    NSMutableArray              *_headImageArray;
    NSMutableDictionary         *_headImageDic;
    ImageDownLoadQueue          *_headImageQueue;
    
    PromptsLabel                *_chatMessageLabel;
    NSMutableArray              *_pushMessageArray;
    
    ReadNoticeRequest           *_readNoticeRequest;
    GetNearbyUserListRequest    *_getNearbyUserListRequest;
    PromptsMessageViewController *_promptsMessageViewController;
}

@property (retain, nonatomic) UITableView       *nearbyFriendTabelView;
@property (retain, nonatomic) NSArray           *nearbyUserParserArray;
@property (retain, nonatomic) NSMutableArray    *nearbyUserArray;
@property (retain, nonatomic) NSMutableArray    *pushMessageArray;

/**
 *	@brief	获取解析数据，转换为用户数组
 */
-(void) createNearbyUserDataWithArray:(NSArray *)dataArray;

-(BOOL) clearPushMessage;

@end
