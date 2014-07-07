//
//  RecentContactViewController.h
//  certne
//
//  Created by apple on 13-6-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ContactUser.h"
#import "GetFriendDetailInfoRequest.h"
#import "EGORefreshTableHeaderView.h"
//#import "ImageDownLoadQueue.h"
#import "GetContactUserListRequest.h"

@interface RecentContactViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,GetFriendDetailInfoRequestDelegate,EGORefreshTableHeaderDelegate,GetContactUserListRequestDelegate>
{
    UITableView                 *_recentContactTabelView;
    NSArray                     *_contactUserParserArray;
    NSMutableArray              *_contactUserArray;
    
    GetFriendDetailInfoRequest  *_getFriendDetailInfoRequest;
    
//    ImageDownLoadQueue          *_imageDownloadImageQueue;
    NSMutableDictionary         *_imageDic;
    NSMutableArray              *_imageURLArray;
    
    EGORefreshTableHeaderView   *_refreshHeaderView;
    BOOL                        _isLoading;
    GetContactUserListRequest   *_getContactUserListRequest;
}

@property (strong, nonatomic) UITableView   *recentContactTabelView;
@property (strong, nonatomic) NSArray       *contactUserParserArray;

-(void)getContactUserDataWithArray:(NSArray *)dataArray;

@end
