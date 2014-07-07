//
//  UserDetailMessageViewController.h
//  certne
//
//  Created by apple on 13-10-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UserDetailMessageCardCell.h"
#import "QBKOverlayMenuView.h"
#import "UserWebsiteViewController.h"
#import "setMessageViewController.h"
#import "FriendInfoAndMessage.h"
#import "AddToContactListRequest.h"
#import "NavBarView.h"

//#import "ImageDownLoadQueue.h"
//#import "ImageDownLoader.h"

@interface UserDetailMessageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UserHeadImageButtonClickedDelegate,QBKOverlayMenuViewDelegate,AddToContactListRequestDelegate,NavBarViewDelegate>
{
    UITableView         *_userDetailMessageTableView;
    
    QBKOverlayMenuView  *_overlayMenuView;
    
    NSMutableDictionary *_imageDictionary;
    NSMutableArray      *_imageURLArray;
//    ImageDownLoadQueue  *_imageDownLoadQueue;
//    
//    ImageDownLoader     *_headImageDownloader;
    NSData              *_headImageData;
    
    NSArray                 *_userInfoArray;
    FriendDetailData        *_friendDetailData;
    FriendInfoAndMessage    *_friendInfoMsg;
    NSMutableArray          *_publishMsgArray;
    
    AddToContactListRequest *_addToContactListRequest;
    NavBarView              *_navBarView;
}

@property (strong, nonatomic) UITableView           *userDetailMessageTableView;

@property (strong, nonatomic) NSArray               *userInfoArray;
@property (strong, nonatomic) FriendDetailData      *friendDetailData;
@property (strong, nonatomic) FriendInfoAndMessage  *friendInfoMsg;

-(void)createUserDetailInfo;

-(void)createImageURLArray;

@end
